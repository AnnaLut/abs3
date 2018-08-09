using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.GL.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using AttributeRouting.Web.Http;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.GL.Controllers.Api
{
    public class NLController : ApiController
    {
        private INLRepository _repository;
        public NLController(INLRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string tip)
        {
            try
            {
                var data = _repository.FilesData(tip).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Msg = ex.Message });
            }
        }

        [HttpGet]
        [GET("api/gl/nl/getsubfiles")]
        public HttpResponseMessage GetSubFiles(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal acc)
        {
            try
            {
                var data = _repository.SubFileData(acc).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Msg = ex.Message });
            }
        }

        [HttpDelete]
        [DELETE("api/gl/nl/deleteDocument")]
        public HttpResponseMessage DeleteDocument(decimal id)
        {
            try
            {
                _repository.RemoveDocument(id);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Msg = "Ok" });
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Msg = ex.Message });
            }
        }

        [HttpGet]
        [GET("api/gl/nl/GetSwiftInfo")]
        public HttpResponseMessage GetSwiftInfo(decimal refid)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { RESULT = _repository.GetSwiftInfo(refid) } );
            }
            catch(Exception e)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { Msg = e.Message });
            }
        }
    }
}