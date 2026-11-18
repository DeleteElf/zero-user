package useraction

import (
	"context"
	"fmt"
	"strconv"

	"github.com/DeleteElf/zero-user/business"
	"github.com/DeleteElf/zero-user/rpchandles/user"
	"github.com/DeleteElf/zero-web-core/ctx"
	"github.com/deleteelf/zero-core/entities"
	"github.com/deleteelf/zero-core/utils/httphelper"
	"github.com/deleteelf/zero-core/utils/loghelper"
	"github.com/deleteelf/zero-core/utils/stringhelper"
	"github.com/zeromicro/go-zero/core/logx"
)

type UserLogic struct {
	ctx    context.Context
	svcCtx *ctx.ServiceContext[ctx.RpcServerConf]
	logx.Logger
}

func NewUserLogic(ctx context.Context, svcCtx *ctx.ServiceContext[ctx.RpcServerConf]) *UserLogic {
	return &UserLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

func (l *UserLogic) UserInfo(in *user.IdRequest) (*user.Response, error) {
	svr := business.NewUserService(l.svcCtx.Config.GetDbConfig())
	userInfo, err := svr.GetUserInfo(in.Id)
	if err != nil {
		return &user.Response{Code: "-1", Message: "数据格式化失败！！！"}, nil
	}
	loghelper.Info(string(userInfo))
	return &user.Response{Code: "0", Message: "获取成功", Result: userInfo}, nil
}

func (l *UserLogic) UnRegister(in *user.IdRequest) (*user.Response, error) {
	// todo: add your logic here and delete this line

	return &user.Response{}, nil
}

func (l *UserLogic) Register(in *user.RegisterRequest) (*user.Response, error) {
	// todo: add your logic here and delete this line

	return &user.Response{}, nil
}

func (l *UserLogic) Logout(in *user.IdRequest) (*user.Response, error) {
	// 登出逻辑，在client做即可，无需在服务端
	//l.svcCtx.RedisClient.Del(in.)
	message := fmt.Sprintf("用户[%s]退出登录！！！", in.Id)
	return &user.Response{Code: "0", Message: message, Result: "from etcd service 8080"}, nil
}

func (l *UserLogic) Login(in *user.LoginRequest) (*user.Response, error) {
	svr := business.NewUserService(l.svcCtx.Config.GetDbConfig())
	var userInfo []entities.UserInfo
	switch in.Type {
	case 0:
		userInfo, _ = svr.Login(in.Account, "", "", stringhelper.Md5(in.Password))
	case 1:
		userInfo, _ = svr.Login("", in.Account, "", stringhelper.Md5(in.Password))
	case 2:
		userInfo, _ = svr.Login("", "", in.Account, stringhelper.Md5(in.Password))
	}
	if len(userInfo) == 0 {
		return &user.Response{Code: "-1", Message: "登录失败，账号或密码错误！！！"}, nil
	}
	//登录成功，生成token
	tokenValue := strconv.Itoa(userInfo[0].Id) //根据需要写入value，也可以是复杂的数据
	token, err := httphelper.BuildJwtToken(tokenValue, l.svcCtx.Config.TokenReplaceTime, 0)
	//登录成功，写入redis，同时需要在中间件对这个信息进行续约
	err1 := l.svcCtx.RedisClient.Setex(token, tokenValue, l.svcCtx.Config.SessionTime) //有效期30分钟
	if err1 != nil {
		return &user.Response{Code: "-1", Message: "写入redis发生错误！！！", Result: err1.Error()}, nil
	}
	b, err2 := l.svcCtx.RedisClient.Exists(token)
	if err2 != nil {
		return &user.Response{Code: "-1", Message: "确认redis信息发生错误！！！"}, nil
	}
	if !b {
		return &user.Response{Code: "-1", Message: "写入redis失败！！！"}, nil
	}
	//token, err := httphelper.BuildJwtToken(in.Account, 0, 0)
	if err != nil {
		return &user.Response{Code: "-1", Message: "登录失败！！！"}, nil
	}
	return &user.Response{Code: "0", Message: "登录成功！！！", Result: token}, nil
}

func (l *UserLogic) ChangePwd(in *user.ChangePwdRequest) (*user.Response, error) {
	// todo: add your logic here and delete this line

	return &user.Response{}, nil
}
