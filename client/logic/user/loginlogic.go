package user

import (
	"context"

	"github.com/DeleteElf/zero-user/client/rpc/userservicelogic"
	"github.com/DeleteElf/zero-user/rpchandles/user"
	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/zeromicro/go-zero/core/logx"
)

type LoginLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *service.ServiceContext[service.RpcClientConf]
}

// 登录
func NewLoginLogic(ctx context.Context, svcCtx *service.ServiceContext[service.RpcClientConf]) *LoginLogic {
	return &LoginLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *LoginLogic) Login(req *types.LoginRequest) (resp *types.Response, err error) {
	// todo: add your logic here and delete this line
	userInfo, _ := l.svcCtx.Services["user"].Service.(userservicelogic.UserService).Login(l.ctx, &user.LoginRequest{
		Account:  req.Account,
		Password: req.Password,
	})
	return &types.Response{
		Code:    userInfo.Code,
		Message: userInfo.Message,
		Result:  userInfo.Result,
	}, nil
}
