package logic

import (
	"context"

	"github.com/DeleteElf/zero-user/client/rpc/characterservicelogic"
	"github.com/DeleteElf/zero-user/rpchandles/character"
	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/zeromicro/go-zero/core/logx"
)

type CharacterLogic[T service.Config] struct {
	logx.Logger
	ctx    context.Context
	svcCtx *service.ServiceContext[T]
}

// 获取角色信息
func NewCharacterLogic[T service.Config](ctx context.Context, svcCtx *service.ServiceContext[T]) *CharacterLogic[T] {
	return &CharacterLogic[T]{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *CharacterLogic[T]) Info(req *types.IdRequest) (resp *types.Response, err error) {
	if l.svcCtx.Config.GetServiceType() == service.RpcClient { //实现rpc通讯
		userInfo, _ := l.svcCtx.Services["character"].Service.(characterservicelogic.CharacterService).CharacterInfo(l.ctx, &character.IdRequest{
			Id: req.Id,
		})
		return &types.Response{
			Code:    userInfo.Code,
			Message: userInfo.Message,
			Result:  userInfo.Result,
		}, nil
	} else {
		// todo: add your logic here and delete this line
		return
	}
}
