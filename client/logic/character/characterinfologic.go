package character

import (
	"context"

	"github.com/DeleteElf/zero-user/client/rpc/characterservicelogic"
	"github.com/DeleteElf/zero-user/rpchandles/character"
	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/zeromicro/go-zero/core/logx"
)

type CharacterInfoLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *service.ServiceContext[service.RpcClientConf]
}

// 获取角色信息
func NewCharacterInfoLogic(ctx context.Context, svcCtx *service.ServiceContext[service.RpcClientConf]) *CharacterInfoLogic {
	return &CharacterInfoLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *CharacterInfoLogic) CharacterInfo(req *types.IdRequest) (resp *types.Response, err error) {
	// todo: add your logic here and delete this line
	userInfo, _ := l.svcCtx.Services["character"].Service.(characterservicelogic.CharacterService).CharacterInfo(l.ctx, &character.IdRequest{
		Id: req.Id,
	})
	return &types.Response{
		Code:    userInfo.Code,
		Message: userInfo.Message,
		Result:  userInfo.Result,
	}, nil
}
