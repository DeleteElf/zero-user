package user

import (
	"context"
	"encoding/json"

	"github.com/DeleteElf/zero-user/client/rpc/userservicelogic"
	"github.com/DeleteElf/zero-user/rpchandles/user"
	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/deleteelf/zero-core/ado"
	"github.com/zeromicro/go-zero/core/logx"
)

type UserInfoLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *service.ServiceContext[service.RpcClientConf]
}

// 获取用户信息
func NewUserInfoLogic(ctx context.Context, svcCtx *service.ServiceContext[service.RpcClientConf]) *UserInfoLogic {
	return &UserInfoLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *UserInfoLogic) UserInfo() (resp *types.Response, err error) {
	userId := l.ctx.Value("userId").(string)
	userRpcService, ok := l.svcCtx.Services["user"].Service.(userservicelogic.UserService)
	if !ok {
		logx.Error("未注册用户服务模块！")
	}
	userInfo, _ := userRpcService.UserInfo(l.ctx, &user.IdRequest{
		Id: userId,
	})

	dataTable := ado.DataTable{Rows: []map[string]interface{}{}}
	err1 := json.Unmarshal([]byte(userInfo.Result), &dataTable.Rows)
	if err1 != nil {
		return &types.Response{
			Code:    "-1",
			Message: "数据传输错误！",
		}, nil
	}
	return &types.Response{
		Code:    userInfo.Code,
		Message: userInfo.Message,
		Result:  dataTable.Rows,
	}, nil
}
