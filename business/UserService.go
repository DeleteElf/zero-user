package business

import (
	"github.com/DeleteElf/zero-web-core/svr"
	"github.com/deleteelf/zero-core/ado"
	"github.com/deleteelf/zero-core/entities"
	"github.com/deleteelf/zero-core/utils/jsonhelper"
	"github.com/deleteelf/zero-core/utils/stringhelper"
)

func NewUserService(DbConf *ado.DbConfig) *UserService {
	return &UserService{
		BaseBusiness: svr.BaseBusiness{
			DbConfig: DbConf,
		},
	}
}

type UserService struct {
	svr.BaseBusiness
}

func (s *UserService) GetUserInfo(userId any) ([]byte, error) {
	dbCon, err := ado.CreateDbByConfig(s.DbConfig)
	if dbCon == nil {
		return nil, err
	}
	dataTable := dbCon.QueryData("SELECT to_char(f_create_Time,'yyyy-MM-dd HH24:mi:ss') as registered_Time,"+
		"f_name,f_email,f_telephone,f_active "+
		"FROM sys.t_user_info where f_id =?", userId)
	return jsonhelper.ToJsonByte(dataTable.Rows)
}

func (s *UserService) Login(account, name, pwd string) ([]entities.UserInfo, error) {
	dbCon, err := ado.CreateDbByConfig(s.DbConfig)
	if dbCon == nil {
		return nil, err
	}
	var userInfo []entities.UserInfo
	dbCon.SelectByCondition(&userInfo, "(f_account=? or f_name=?) and f_password=? and f_is_active=true",
		account, name, stringhelper.Md5(pwd))
	return userInfo, nil
}
