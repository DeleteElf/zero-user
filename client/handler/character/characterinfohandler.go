package character

import (
	"net/http"

	"github.com/DeleteElf/zero-user/client/logic/character"
	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/zeromicro/go-zero/rest/httpx"
)

// 获取角色信息
func CharacterInfoHandler(svcCtx *service.ServiceContext[service.RpcClientConf]) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.IdRequest
		if err := httpx.Parse(r, &req); err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
			return
		}

		l := character.NewCharacterInfoLogic(r.Context(), svcCtx)
		resp, err := l.CharacterInfo(&req)
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.OkJsonCtx(r.Context(), w, resp)
		}
	}
}
