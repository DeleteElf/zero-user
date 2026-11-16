package user

import (
	"net/http"

	"github.com/DeleteElf/zero-user/client/logic/user"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/zeromicro/go-zero/rest/httpx"
)

// 登出
func LogoutHandler(svcCtx *service.ServiceContext[service.RpcClientConf]) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		//var req types.IdRequest
		//if err := httpx.Parse(r, &req); err != nil {
		//	httpx.ErrorCtx(r.Context(), w, err)
		//	return
		//}

		l := user.NewLogoutLogic(r.Context(), svcCtx)
		resp, err := l.Logout()
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.OkJsonCtx(r.Context(), w, resp)
		}
	}
}
