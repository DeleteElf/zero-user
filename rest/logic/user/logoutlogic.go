package user

import (
	"context"
	"fmt"

	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"

	"github.com/zeromicro/go-zero/core/logx"
)

type LogoutLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *service.ServiceContext[service.RestConf]
}

// 登出
func NewLogoutLogic(ctx context.Context, svcCtx *service.ServiceContext[service.RestConf]) *LogoutLogic {
	return &LogoutLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *LogoutLogic) Logout() (resp *types.Response, err error) {
	userId := l.ctx.Value("userId")
	token := l.ctx.Value("token")
	message := fmt.Sprintf("用户[%s]退出登录！！！", userId)
	l.svcCtx.RedisClient.Del(token.(string))
	return &types.Response{
		Code:    "0",
		Message: message,
	}, nil
}
