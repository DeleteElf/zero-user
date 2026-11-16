package user

import (
	"context"

	"github.com/DeleteElf/zero-user/client/rpc/userservicelogic"
	"github.com/DeleteElf/zero-user/rpchandles/user"
	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/zeromicro/go-zero/core/logx"
)

type LoginHandler2Logic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *service.ServiceContext[service.RpcClientConf]
}

// 登录
func NewLoginHandler2Logic(ctx context.Context, svcCtx *service.ServiceContext[service.RpcClientConf]) *LoginHandler2Logic {
	return &LoginHandler2Logic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *LoginHandler2Logic) LoginHandler2(req *types.UserLoginRequest) (resp *types.Response, err error) {
	// todo: add your logic here and delete this line
	userInfo, _ := l.svcCtx.Services["user"].Service.(userservicelogic.UserService).Login(l.ctx, &user.LoginRequest{
		Account:  req.Name,
		Password: req.Password,
	})
	return &types.Response{
		Code:    userInfo.Code,
		Message: userInfo.Message,
		Result:  userInfo.Result,
	}, nil
}
