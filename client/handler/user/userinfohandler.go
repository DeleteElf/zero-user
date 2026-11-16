package user

import (
	"net/http"

	"github.com/DeleteElf/zero-user/client/logic/user"
	"github.com/DeleteElf/zero-web-core/service"
	"github.com/zeromicro/go-zero/rest/httpx"
)

// @Summary 获取用户信息
// @Description 通过用户id获取用户信息
// @Tags 测试
// @Accept queryString
// @Param name query string true "人名"
// @Success {"code":"0","message": "执行成功","result":{}}
// @Failure {"code":"-1","message": "执行失败"}
// @Router /user/info/:id [get]
func UserInfoHandler(svcCtx *service.ServiceContext[service.RpcClientConf]) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		//var req types.IdRequest
		//if err := httpx.Parse(r, &req); err != nil {
		//	httpx.ErrorCtx(r.Context(), w, err)
		//	return
		//}

		l := user.NewUserInfoLogic(r.Context(), svcCtx)
		resp, err := l.UserInfo()
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.OkJsonCtx(r.Context(), w, resp)
		}
	}
}
