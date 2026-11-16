package user

import (
	"context"
	"encoding/json"

	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/deleteelf/zero-core/ado"
	"github.com/deleteelf/zero-core/utils/loghelper"
	"github.com/zeromicro/go-zero/core/logx"
)

type UserInfoLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *service.ServiceContext[service.RestConf]
}

// 获取用户信息
func NewUserInfoLogic(ctx context.Context, svcCtx *service.ServiceContext[service.RestConf]) *UserInfoLogic {
	return &UserInfoLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *UserInfoLogic) UserInfo() (resp *types.Response, err error) {
	userId := l.ctx.Value("userId")
	dbCon := ado.CreateDbByConfig(l.svcCtx.Config.DbConfig)
	//dbCon := dbhelper.CreateDb("host=localhost user=postgres dbname=test password=test123 port=5432 sslmode=disable", dbhelper.Postgres, logger.Info)
	if dbCon == nil {
		return &types.Response{
			Code:    "-1",
			Message: "系统错误！！！",
		}, nil
	}
	dataTable := dbCon.QueryData(`SELECT to_char(f_create_Time,'yyyy-MM-dd HH24:mi:ss') as registered_Time,
f_name,f_email,f_telephone,f_active
FROM sys.t_user_info where f_id =?`, userId)
	jsonData, err := json.Marshal(dataTable.Rows)
	if err != nil {
		return &types.Response{
			Code:    "-1",
			Message: "数据格式化失败！！！",
			Result:  err.Error(),
		}, nil
	}
	loghelper.GetDefaultLogger().Info(string(jsonData))
	return &types.Response{
		Code:    "0",
		Message: "获取用户信息成功！！！",
		Result:  dataTable.Rows,
	}, nil
}
