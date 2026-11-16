package svc

import (
	"github.com/zeromicro/go-zero/core/stores/redis"
	"github.com/zeromicro/go-zero/rest"
	"github.com/zeromicro/go-zero/zrpc"
	"new0.com.cn/etcdclient/internal/config"
	"new0.com.cn/etcdclient/internal/middleware"
	"new0.com.cn/etcdclient/services/characterservice"
	"new0.com.cn/etcdclient/services/userservice"
)

type ServiceContext struct {
	Config              config.Config
	AuthInterceptor     rest.Middleware                   //注册中间件
	CharacterRpcService characterservice.CharacterService //需要对每个rpc服务进行注册
	UserRpcService      userservice.UserService
	RedisClient         *redis.Redis
}

func NewServiceContext(c config.Config) *ServiceContext {
	redisClient := redis.MustNewRedis(c.Redis.RedisConf) //加入redis 2
	return &ServiceContext{
		Config:              c,
		AuthInterceptor:     middleware.NewAuthInterceptorMiddleware(redisClient).Handle,
		UserRpcService:      userservice.NewUserService(zrpc.MustNewClient(c.ServerRpc)), //需要对每个rpc服务进行注册
		CharacterRpcService: characterservice.NewCharacterService(zrpc.MustNewClient(c.ServerRpc)),
		RedisClient:         redisClient,
	}
}
