package user

import (
	"context"
	"strconv"

	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/deleteelf/zero-core/ado"
	"github.com/deleteelf/zero-core/entities"
	"github.com/deleteelf/zero-core/utils/httphelper"
	"github.com/deleteelf/zero-core/utils/stringhelper"
	"github.com/zeromicro/go-zero/core/logx"
)

type LoginLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *service.ServiceContext[service.RestConf]
}

// 登录
func NewLoginLogic(ctx context.Context, svcCtx *service.ServiceContext[service.RestConf]) *LoginLogic {
	return &LoginLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *LoginLogic) Login(req *types.LoginRequest) (resp *types.Response, err error) {
	dbCon := ado.CreateDbByConfig(l.svcCtx.Config.DbConfig)
	//dbCon := ado.CreateDb("host=localhost user=postgres dbname=test password=test123 port=5432 sslmode=disable", ado.Postgres, logger.Info)
	if dbCon == nil {
		return &types.Response{
			Code:    "-1",
			Message: "登录时发生系统错误！！！",
		}, nil
	}
	var userInfo []entities.UserInfo
	dbCon.SelectByCondition(&userInfo, "f_account=? and f_password=? and f_is_active=true", req.Account, stringhelper.Md5(req.Password))
	if len(userInfo) == 0 {
		return &types.Response{
			Code:    "-1",
			Message: "登录失败，账号或密码错误！！！",
		}, nil
	}
	//登录成功，生成token
	tokenValue := strconv.Itoa(userInfo[0].Id) //根据需要写入value，也可以是复杂的数据
	token, err := httphelper.BuildJwtToken(tokenValue, l.svcCtx.Config.TokenReplaceTime, 0)
	//登录成功，写入redis，同时需要在中间件对这个信息进行续约
	err1 := l.svcCtx.RedisClient.Setex(token, tokenValue, l.svcCtx.Config.SessionTime) //有效期30分钟
	if err1 != nil {
		return &types.Response{
			Code:    "-1",
			Message: "写入redis发生错误！！！",
			Result:  err1.Error(),
		}, nil
	}
	b, err2 := l.svcCtx.RedisClient.Exists(token)
	if err2 != nil {
		return &types.Response{
			Code:    "-1",
			Message: "确认redis信息发生错误！！！",
			Result:  err2.Error(),
		}, nil
	}
	if !b {
		return &types.Response{
			Code:    "-1",
			Message: "写入redis失败！！！",
		}, nil
	}
	//token, err := httphelper.BuildJwtToken(in.Account, 0, 0)
	if err != nil {
		return &types.Response{
			Code:    "-1",
			Message: "登录失败！！！",
			Result:  err.Error(),
		}, nil
	}
	return &types.Response{
		Code:    "0",
		Message: "登录成功！！！",
		Result:  token,
	}, nil
}
