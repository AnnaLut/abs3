using AttributeRouting.Web.Http;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using System.Collections.Generic;

namespace BarsWeb.Areas.Pfu.Controllers.Api
{
    /// <summary>
    /// FilesGrid Data
    /// </summary>
    public class EppPortfolioController : ApiController
    {
        private readonly IGridRepository _repo;
        public EppPortfolioController(IGridRepository repo)
        {
            _repo = repo;
        }
        [HttpGet]
        [GET("/api/pfu/EppPortfolio/GetBranchСode")]
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
        [HttpGet]
        [GET("/api/pfu/EppPortfolio/GetEppDate")]
        public HttpResponseMessage GetEppDate()
        {
            try
            {
                var data = _repo.GetEppDate();
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
        [HttpGet]
        [GET("/api/pfu/EppPortfolio/GetEppLine")]
        public HttpResponseMessage GetEppLine([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string kf, string date, string status)
        {
             if (kf != null && date!="null")
            {
                decimal KF = Convert.ToDecimal(kf);
                try
                {
                    //var total = _repo.GetCountGrid();
                    var data = _repo.GetEppLine(request, KF, date, status);
                    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));//new { Data = data, Total = total }
                    return response;
                }
                catch (Exception ex)
                {
                    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
                        ex.Message);
                    return response;

                }
            }
            else {

                HttpResponseMessage response = Request.CreateResponse();
                return response;
            }
        }

        [HttpGet]
        [GET("/api/pfu/EppPortfolio/GetTableByRNK")]
        public HttpResponseMessage GetTableByRNK([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string id, string id_row)
        {
            try
            {
                decimal ID_row = Convert.ToDecimal(id_row);
                //var total = _repo.GetCountGrid();
                var data = _repo.GetTableByRNK(id, ID_row);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));//.ToDataSourceResult(request)
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
                    ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/pfu/EppPortfolio/GetTableByEppNum")]
        public HttpResponseMessage GetTableByEppNum([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string id)
        {
            try
            {
                //var total = _repo.GetCountGrid();
                var data = _repo.GetTableByEppNum(id);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));//.ToDataSourceResult(request)
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
                    ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/pfu/EppPortfolio/GetTableByAccNum")]
        public HttpResponseMessage GetTableByAccNum([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string id)
        {
            try
            {
                //var total = _repo.GetCountGrid();
                var data = _repo.GetTableByAccNum(id);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));//.ToDataSourceResult(request)
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
                    ex.Message);
                return response;
            }
        }

        [HttpPost]
        [POST("/api/pfu/EppPortfolio/RepeatProcessing")]
        public HttpResponseMessage RepeatProcessing(dynamic rows)
        {
            try
            {
                _repo.RepeatProcessing(rows);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
                    ex.Message);
                return response;
            }
        }


        [HttpPost]
        [POST("/api/pfu/EppPortfolio/AssignRNK")]
        public HttpResponseMessage AssignRNK(dynamic rows)
        {
            try
            {
                _repo.AssignRNK(rows);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
                    ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/pfu/EppPortfolio/GetStatusRows")]
        public HttpResponseMessage GetStatusRows(decimal status, string kf, string date)
        {
             if (kf != null && date!="null")
            {
                decimal KF = Convert.ToDecimal(kf);
                try
                {
                    var data = _repo.GetStatusRows(status, KF, date);
                    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);//.ToDataSourceResult(request)
                    return response;
                }
                catch (Exception ex)
                {
                    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
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
        public HttpResponseMessage GetRowsByStatus([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string status, string kf, string date)
        {
            if (kf != null)
            {
                decimal KF = Convert.ToDecimal(kf);
                try
                {
                    var data = _repo.GetRowsByStatus(status, KF, date);
                    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));//.ToDataSourceResult(request)
                    return response;
                }
                catch (Exception ex)
                {
                    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
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