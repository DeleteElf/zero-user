package business

import (
	"github.com/DeleteElf/zero-core/ado"
	"github.com/DeleteElf/zero-web-core/svr"
)

func NewCharacterService(DbConf *ado.DbConfig) *CharacterService {
	return &CharacterService{
		BaseBusiness: svr.BaseBusiness{
			DbConfig: DbConf,
		},
	}
}

type CharacterService struct {
	svr.BaseBusiness
}
