package business

import (
	"github.com/DeleteElf/zero-web-core/svr"
	"github.com/deleteelf/zero-core/ado"
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
