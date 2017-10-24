using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using System.Net.Http;
using System.Net;
using System;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Admin.Models.ApiModels.ListSet;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    [AuthorizeApi]
    public class ListFuncSetController : ApiController
    {
        private readonly IListSetRepository _repo;
        public ListFuncSetController(IListSetRepository repo)
        {
            _repo = repo;
        }
        
        // update func activity
        [HttpPost]
        [POST("api/admin/listfuncset")]
        public HttpResponseMessage Post(FunctionActivity obj)
        {
            try
            {
                _repo.UpdateFunc(obj.setId, obj.functionId, obj.activityType, obj.comments);
                const int result = 1;
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotModified, ex.Message);
            }
        }
        // add func
        [HttpPut]
        [PUT("api/admin/listfuncset")]
        public HttpResponseMessage Put(Function item)
        {
            try
            {
                _repo.AddFuncToSet(item.id, item.funcId);
                const int result = 1;
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotModified, ex.Message);
            }
        }
        // delete func
        [HttpDelete]
        [DELETE("api/admin/listfuncset")]
        public HttpResponseMessage Delete(Function item)
        {
            try
            {
                _repo.DropFuncFromSet(item.id, item.funcId);
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