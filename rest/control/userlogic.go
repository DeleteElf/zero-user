package control

import (
	"context"
	"fmt"

	"github.com/DeleteElf/zero-core/entities"
	"github.com/DeleteElf/zero-core/utils/jsonhelper"
	"github.com/DeleteElf/zero-user/business"
	"github.com/DeleteElf/zero-user/client/rpc/userclient"
	"github.com/DeleteElf/zero-user/rpchandles/user"
	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/base"
	"github.com/DeleteElf/zero-web-core/ctx"
	"github.com/zeromicro/go-zero/core/logx"
)

type UserAction[T ctx.Config] struct {
	logx.Logger
	ctx    context.Context
	svcCtx *ctx.ServiceContext[T]
}

// 登录
func NewUserAction[T ctx.Config](ctx context.Context, svcCtx *ctx.ServiceContext[T]) *UserAction[T] {
	return &UserAction[T]{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *UserAction[T]) Login(req *types.LoginRequest) (resp *base.Response, err error) {
	if l.svcCtx.Config.GetServiceType() == ctx.RpcClient { //实现rpc通讯
		userInfo, _ := l.svcCtx.Services["user"].Service.(userclient.UserService).Login(l.ctx, &user.LoginRequest{
			Account:  req.Account,
			Password: req.Password,
		})
		return &base.Response{
			Code:    userInfo.Code,
			Message: userInfo.Message,
			Result:  userInfo.Result,
		}, nil
	}
	svr := business.NewUserService(l.svcCtx.Config.GetDbConfig())
	var userInfo []entities.UserInfo
	switch req.Type {
	case 0:
		userInfo, err = svr.Login(req.Account, "", "", req.Password)
	case 1:
		userInfo, err = svr.Login("", req.Account, "", req.Password)
	case 2:
		userInfo, err = svr.Login("", "", req.Account, req.Password)
	}
	if len(userInfo) == 0 {
		return &base.Response{
			Code:    "-1",
			Message: "登录失败，账号或密码错误！！！",
		}, nil
	}
	//登录成功，生成token
	token, tokenValue, err := svr.BuildToken(userInfo[0], l.svcCtx.Config.GetTokenReplaceTime())
	//登录成功，写入redis，同时需要在中间件对这个信息进行续约
	err1 := l.svcCtx.RedisClient.Setex(token, tokenValue, l.svcCtx.Config.GetSessionTime()) //有效期30分钟
	if err1 != nil {
		return &base.Response{
			Code:    "-1",
			Message: "写入redis发生错误！！！",
			Result:  err1.Error(),
		}, nil
	}
	b, err2 := l.svcCtx.RedisClient.Exists(token)
	if err2 != nil {
		return &base.Response{
			Code:    "-1",
			Message: "确认redis信息发生错误！！！",
			Result:  err2.Error(),
		}, nil
	}
	if !b {
		return &base.Response{
			Code:    "-1",
			Message: "写入redis失败！！！",
		}, nil
	}
	//token, err := httphelper.BuildJwtToken(in.Account, 0, 0)
	if err != nil {
		return &base.Response{
			Code:    "-1",
			Message: "登录失败！！！",
			Result:  err.Error(),
		}, nil
	}
	return &base.Response{
		Code:    "0",
		Message: "登录成功！！！",
		Result:  token,
	}, nil
}

func (l *UserAction[T]) Logout() (resp *base.Response, err error) {
	//我们只需要在redis登出即可
	userName := l.ctx.Value("userName")
	token := l.ctx.Value("token")
	message := fmt.Sprintf("用户[%s]退出登录！！！", userName)
	l.svcCtx.RedisClient.Del(token.(string))
	return &base.Response{
		Code:    "0",
		Message: message,
	}, nil
}

func (l *UserAction[T]) UserInfo() (resp *base.Response, err error) {
	userId := l.ctx.Value("userId")
	if l.svcCtx.Config.GetServiceType() == ctx.RpcClient { //实现rpc通讯
		userRpcService, ok := l.svcCtx.Services["user"].Service.(userclient.UserService)
		if !ok {
			logx.Error("未注册用户服务模块！")
		}
		userInfo, _ := userRpcService.UserInfo(l.ctx, &user.IdRequest{
			Id: fmt.Sprint(userId),
		})
		result, _ := jsonhelper.GetJsonObject([]byte(userInfo.Result))
		return &base.Response{
			Code:    userInfo.Code,
			Message: userInfo.Message,
			Result:  result,
		}, nil
	}
	svr := business.NewUserService(l.svcCtx.Config.GetDbConfig())
	userInfo, err := svr.GetUserInfo(userId)
	if err != nil {
		return &base.Response{
			Code:    "-1",
			Message: "获取数据的过程发生了错误",
			Result:  err.Error(),
		}, nil
	}
	//loghelper.Info(string(userInfo))
	return &base.Response{
		Code:    "0",
		Message: "获取用户信息成功！！！",
		Result:  userInfo.Rows[0],
	}, nil
}

func (l *UserAction[T]) ChangePwd(req *types.ChangePwdRequest) (resp *base.Response, err error) {
	// todo: add your logic here and delete this line

	return
}
