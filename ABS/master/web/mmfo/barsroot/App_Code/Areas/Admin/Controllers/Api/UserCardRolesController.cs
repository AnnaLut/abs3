using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    //[AuthorizeApi]
    public class UserCardRolesController : ApiController
    {
        private readonly IADMURepository _repo;
        public UserCardRolesController(IADMURepository repo)
        {
            _repo = repo;
        }
        public HttpResponseMessage GetUserRoles(
           [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
           string id)
        {
            try
            {
                // to stub string paraneter in this case:
                const string stubParam = "";
                var user = _repo.GetADMUList(stubParam).Where(x => x.LOGIN_NAME == id).Select(x => x).SingleOrDefault();
                var data = _repo.UserRoles();
                var dataList = data.Where(x => x.USER_ID == user.ID).Select(x => new { USER_ID = x.USER_ID, ROLE_NAME = x.ROLE_NAME, ROLE_CODE = x.ROLE_CODE, ROLE_ID = x.ROLE_ID, IS_GRANTED = x.IS_GRANTED, IS_APPROVED = x.IS_APPROVED }).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, dataList.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }

}