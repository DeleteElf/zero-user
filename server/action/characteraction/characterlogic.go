package characteraction

import (
	"context"
	"fmt"

	"github.com/DeleteElf/zero-user/rpchandles/character"
	"github.com/DeleteElf/zero-web-core/ctx"
	"github.com/zeromicro/go-zero/core/logx"
)

type CharacterLogic struct {
	ctx    context.Context
	svcCtx *ctx.ServiceContext[ctx.RpcServerConf]
	logx.Logger
}

func NewCharacterLogic(ctx context.Context, svcCtx *ctx.ServiceContext[ctx.RpcServerConf]) *CharacterLogic {
	return &CharacterLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

func (l *CharacterLogic) Info(in *character.IdRequest) (*character.Response, error) {
	// todo: add your logic here and delete this line
	message := fmt.Sprintf("获取角色编号[%s]的角色信息成功", in.Id)
	return &character.Response{Code: "0", Message: message, Result: "from etcd server 8080"}, nil
}
