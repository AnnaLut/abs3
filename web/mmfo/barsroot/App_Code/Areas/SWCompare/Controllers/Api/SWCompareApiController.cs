using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.SWCompare.Infrastructure.DI.Abstract;
using BarsWeb.Areas.SWCompare.Infrastructure.DI.Implementation;
using System;
using System.Drawing;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Areas.SWCompare.Models;
using System.Text;
using System.Net.Http.Headers;
using System.Linq;
using Oracle.DataAccess.Client;
using System.Collections.Generic;

namespace BarsWeb.Areas.SWCompare.Controllers.Api
{
    public class SWCompareController : ApiController
    {
        readonly ISWCompareRepository _repo;
        public SWCompareController(ISWCompareRepository repo)
        {
            _repo = repo;
        }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string DateFrom, string DateTo, string Type)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMain(DateFrom,  DateTo,  Type);
                
                var data = _repo.SearchGlobal<SWCModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchTickets([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string id_c)
        {
            try
            {
                if (null == id_c)
                    return Request.CreateResponse(HttpStatusCode.OK, new { Data = new List<SWCTiketModel>() });
                BarsSql sql = SqlCreator.SerchTickets(id_c);
                var data = _repo.SearchGlobal<SWCTiketModel>(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetBranchNames()
        {
            try
            {
                BarsSql sql = SqlCreator.GetBranchNames();
                var data = _repo.SearchGlobal<BranchNamesDropDownModel>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetUser([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.GetUser();
                var data = _repo.SearchGlobal<string>(request, sql).ToList().FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetNBU()
        {
            try
            {
                BarsSql sql = SqlCreator.GetNBU();
                var data = _repo.SearchGlobal<NBUDropDownModel>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage LoadRuData(RuPostModel ruPostModel)
        {
            try
            {
                var p_message = _repo.LoadRuData(ruPostModel);

                var sql = SqlCreator.RuRowCount(ruPostModel);
                var rows = _repo.ExecuteStoreQuery<int>(sql);

                var resultObj = new { Message = p_message, Rows = rows };

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC() { ResultObj = resultObj });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC() { Result = "ERROR", ErrorMsg = ex.Message.ToString() }, new MediaTypeHeaderValue("text/json"));
            }
        }

        [HttpPost]
        public HttpResponseMessage LoadNBU(NBUPostModel nbu)
        {
            try
            {
                var p_message = _repo.LoadNBU(nbu);
                var resultObj = new { Message = p_message };
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC() { ResultObj = resultObj });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC() { Result = "ERROR", ErrorMsg = ex.Message.ToString() }, new MediaTypeHeaderValue("text/json"));
            }
        }

        [HttpPost]
        public HttpResponseMessage LoadZsData(ZsPostModel zsPostModel)
        {
            try
            {
                var p_message = _repo.LoadZsData(zsPostModel);

                var sql = SqlCreator.ZsRowCount(zsPostModel);
                var rows = _repo.ExecuteStoreQuery<int>(sql);

                var resultObj = new { Message = p_message, Rows = rows };

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC() { ResultObj = resultObj });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC() { Result = "ERROR", ErrorMsg = ex.Message.ToString() }, new MediaTypeHeaderValue("text/json"));
            }
        }

        [HttpPost]
        public HttpResponseMessage ResolveDifference(ResolveModel resolveModel)
        {
            try
            {
                BarsSql sql = SqlCreator.ResolveDifference(resolveModel);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC() { Result = "ERROR", ErrorMsg = ex.Message.ToString() }, new MediaTypeHeaderValue("text/json"));
            }
        }

        [HttpPost]
        public HttpResponseMessage DeleteСompare(ResolveModel resolveModel)
        {
            try
            {
                BarsSql sql = SqlCreator.DeleteСompare(resolveModel);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC() { Result = "ERROR", ErrorMsg = ex.Message.ToString() }, new MediaTypeHeaderValue("text/json"));
            }
        }

        [HttpPost]
        public HttpResponseMessage HandFixing(HandModel handModel)
        {
            try
            {
                BarsSql sql = SqlCreator.HandFixing(handModel);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSWC() { Result = "ERROR", ErrorMsg = ex.Message.ToString() }, new MediaTypeHeaderValue("text/json"));
            }
        }
    }
}
