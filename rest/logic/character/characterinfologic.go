package character

import (
	"context"

	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/zeromicro/go-zero/core/logx"
)

type CharacterInfoLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *service.ServiceContext[service.RestConf]
}

// 获取角色信息
func NewCharacterInfoLogic(ctx context.Context, svcCtx *service.ServiceContext[service.RestConf]) *CharacterInfoLogic {
	return &CharacterInfoLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *CharacterInfoLogic) CharacterInfo(req *types.IdRequest) (resp *types.Response, err error) {
	// todo: add your logic here and delete this line

	return
}
