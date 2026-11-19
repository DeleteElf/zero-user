package business

import (
	"github.com/DeleteElf/zero-core/ado"
	"github.com/DeleteElf/zero-core/entities"
	"github.com/DeleteElf/zero-core/utils/httphelper"
	"github.com/DeleteElf/zero-core/utils/jsonhelper"
	"github.com/DeleteElf/zero-core/utils/stringhelper"
	"github.com/DeleteElf/zero-web-core/svr"
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

func (s *UserService) GetUserInfo(userId any) (*ado.DataTable, error) {
	dbCon, err := ado.CreateDbByConfig(s.DbConfig)
	if dbCon == nil {
		return nil, err
	}
	dataTable := dbCon.QueryData("SELECT to_char(f_create_Time,'yyyy-MM-dd HH24:mi:ss') as registered_Time,"+
		"f_name,f_user_name,f_email,f_telephone,f_active "+
		"FROM sys.t_user_info where f_id =?", userId)
	return dataTable, nil //jsonhelper.ToJsonByte(dataTable.Rows)
}

func (s *UserService) Login(account, telephone, email, pwd string) ([]entities.UserInfo, error) {
	dbCon, err := ado.CreateDbByConfig(s.DbConfig)
	if dbCon == nil {
		return nil, err
	}
	var userInfo []entities.UserInfo
	dbCon.SelectByCondition(&userInfo, "(f_account=? or f_telephone=? or f_email=?) and f_password=? and f_active",
		account, telephone, email, stringhelper.Md5(pwd))
	return userInfo, nil
}

func (s *UserService) BuildToken(userInfo entities.UserInfo, tokenReplaceTime int64) (token, value string, err error) {
	tokenValue := jsonhelper.JsonObject{"id": userInfo.Id, "name": userInfo.UserName} //根据需要写入value，也可以是复杂的数据
	value, err = jsonhelper.ToJsonString(tokenValue)
	if err != nil {
		return "", "", err
	}
	token, err = httphelper.BuildJwtToken(tokenValue, tokenReplaceTime, 0)
	return token, value, err
}
