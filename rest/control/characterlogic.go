package control

import (
	"context"

	"github.com/DeleteElf/zero-user/client/rpc/characterclient"
	"github.com/DeleteElf/zero-user/rpchandles/character"
	"github.com/DeleteElf/zero-web-core/base"
	"github.com/DeleteElf/zero-web-core/ctx"
	"github.com/zeromicro/go-zero/core/logx"
)

type CharacterLogic[T ctx.Config] struct {
	logx.Logger
	ctx    context.Context
	svcCtx *ctx.ServiceContext[T]
}

// 获取角色信息
func NewCharacterLogic[T ctx.Config](ctx context.Context, svcCtx *ctx.ServiceContext[T]) *CharacterLogic[T] {
	return &CharacterLogic[T]{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *CharacterLogic[T]) Info(req *base.IdRequest) (resp *base.Response, err error) {
	if l.svcCtx.Config.GetServiceType() == ctx.RpcClient { //实现rpc通讯
		userInfo, _ := l.svcCtx.Services["character"].Service.(characterclient.CharacterService).CharacterInfo(l.ctx, &character.IdRequest{
			Id: req.Id,
		})
		return &base.Response{
			Code:    userInfo.Code,
			Message: userInfo.Message,
			Result:  userInfo.Result,
		}, nil
	} else {
		// todo: add your logic here and delete this line
		return
	}
}
