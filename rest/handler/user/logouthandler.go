package user

import (
	"net/http"

	"github.com/DeleteElf/zero-user/rest/logic/user"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/zeromicro/go-zero/rest/httpx"
)

// 登出
func LogoutHandler(svcCtx *service.ServiceContext[service.RestConf]) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		l := user.NewLogoutLogic(r.Context(), svcCtx)
		resp, err := l.Logout()
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.OkJsonCtx(r.Context(), w, resp)
		}
	}
}
