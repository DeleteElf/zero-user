package middleware

import (
	"context"
	"net/http"
	"strings"

	"github.com/DeleteElf/zero-core/utils/httphelper"
	"github.com/zeromicro/go-zero/core/stores/redis"
)

type AuthInterceptor struct {
	RedisClient *redis.Redis
}

func NewAuthInterceptor(redisClient *redis.Redis) *AuthInterceptor {
	return &AuthInterceptor{RedisClient: redisClient}
}

func (m *AuthInterceptor) Handle(next http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		//md, ok := metadata.FromIncomingContext(ctx) //如果是在上下文处理，可以用这个获取参数 类似request.getParameters 返回类型 map[string][]string
		tokenStr := r.Header.Get("Authorization")
		if tokenStr != "" {
			token := httphelper.ParseJwtToken(tokenStr)
			if token != nil { //如果未取到token，则不再继续
				payload := httphelper.GetJwtPayload(tokenStr)
				if payload != "" { //如果存在有效数据，则继续
					redisKey := strings.Replace(tokenStr, "Bearer ", "", 1)
					b, err := m.RedisClient.Exists(redisKey)
					if err != nil {
						http.Error(w, "授权时，发生服务器内部错误！！", http.StatusInternalServerError) //验证不通过
						return
					}
					if b {
						result, err1 := m.RedisClient.Get(redisKey)
						if err1 != nil {
							http.Error(w, "授权时，发生服务器内部错误！！", http.StatusInternalServerError) //验证不通过
							return
						}
						if result == payload {
							//从redis检查结果是否一致，并续约
							//md, ok := metadata.FromIncomingContext(r.Context())
							//if !ok {
							//	md = metadata.New(nil)
							//}
							//md.Set("userId", payload.(string))
							m.RedisClient.Setex(redisKey, result, 1800) //redis续约
							//ctx := r.Context()
							ctx := context.WithValue(r.Context(), "userId", payload) //写入用户信息
							ctx = context.WithValue(ctx, "token", redisKey)          //写入用户信息
							//r = r.WithContext(ctx)                                   //写回上下文
							//test := ctx.Value("userId")
							//loghelper.GetLogManager().Info(test)
							next(w, r.WithContext(ctx)) // 执行下个中间件
							return
						}
					}
				}
			}
		}
		http.Error(w, "未授权的访问！！", http.StatusUnauthorized) //验证不通过
	}
}
