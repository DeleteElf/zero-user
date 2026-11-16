package user

import (
	"net/http"

	"github.com/DeleteElf/zero-user/rest/logic/user"
	"github.com/DeleteElf/zero-user/types"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/zeromicro/go-zero/rest/httpx"
)

// 登录
func LoginHandler2Handler(svcCtx *service.ServiceContext[service.RestConf]) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.UserLoginRequest
		if err := httpx.Parse(r, &req); err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
			return
		}

		l := user.NewLoginHandler2Logic(r.Context(), svcCtx)
		resp, err := l.LoginHandler2(&req)
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.OkJsonCtx(r.Context(), w, resp)
		}
	}
}
