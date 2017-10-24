using AttributeRouting.Web.Http;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Pfu.Controllers.Api
{
    /// <summary>
    /// FilesGrid Data
    /// </summary>
    public class MonitoringController : ApiController
    {
        private readonly IGridRepository _repo;
        public MonitoringController(IGridRepository repo)
        {
            _repo = repo;
        }

        [HttpGet]
        [GET("/api/pfu/monitoring/GetBranchСode")]
        public HttpResponseMessage GetBranchСode()
        {
            try
            {
                var data = _repo.GetBranchСode();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.NoContent,
                    ex.Message);
                return response;
            }
        }
        [HttpPost]
        [POST("/api/pfu/monitoring/SendRequest")]
        public HttpResponseMessage SendRequest(int kf)
        {
            try
            {
                _repo.SendRequest(kf);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.NoContent,
                    ex.Message);
                return response;
            }
        }
        [HttpGet]
        [GET("/api/pfu/monitoring/GetEnquiries")]
        public HttpResponseMessage GetEnquiries([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string kf)
        {
            try
            {
                var data = _repo.GetEnquiries(kf);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError,
                    ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/pfu/monitoring/GetCmEpp")]
        public HttpResponseMessage GetCmEpp([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string id)
        {
            if (id != null)
            {
                decimal ID = Convert.ToDecimal(id);

                try
                {
                    var data = _repo.GetCmEpp(ID);
                    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                        new { Data = data });
                    return response;
                }
                catch (Exception ex)
                {
                    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError,
                        ex.Message);
                    return response;
                }
            }
            else
            {
                HttpResponseMessage response = Request.CreateResponse();
                return response;
            }
        }

        [HttpGet]
        [GET("/api/pfu/monitoring/GetVEppLine")]
        public HttpResponseMessage GetVEppLine([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string id)
        {
            if (id != null)
            {
                try
                {
                    var data = _repo.GetVEppLine(id);
                    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                        new { Data = data });
                    return response;
                }
                catch (Exception ex)
                {
                    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError,
                        ex.Message);
                    return response;
                }
            }
            else
            {
                HttpResponseMessage response = Request.CreateResponse();
                return response;
            }
        }
    }
}