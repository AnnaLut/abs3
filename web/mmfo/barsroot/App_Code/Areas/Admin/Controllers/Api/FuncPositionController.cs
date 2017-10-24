using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using AttributeRouting.Web.Http;
using System.Net.Http;
using BarsWeb.Areas.Admin.Models.ApiModels.ListSet;
using System.Net;
using System;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    [AuthorizeApi]
    public class FuncPositionController : ApiController
    {
        private readonly IListSetRepository _repo;
        public FuncPositionController(IListSetRepository repo)
        {
            _repo = repo;
        }
        // update func position
        [HttpPost]
        [POST("api/admin/listfuncset/position")]
        public HttpResponseMessage PostPosition(FunctionPosition obj)
        {
            try
            {
                _repo.UpdateFuncPosition(obj.setId, obj.functionId, obj.position);
                const int result = 1;
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotModified, ex.Message);
            }
        }
    }
}