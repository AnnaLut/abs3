using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Way4Bpk.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Way4Bpk.Infrastructure.DI.Implementation;
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
using Areas.Way4Bpk.Models;
using System.Collections.Generic;
using System.Linq;
using System.Globalization;

namespace BarsWeb.Areas.Way4Bpk.Controllers.Api
{
    public class Way4BpkController: ApiController
    {
        readonly IWay4BpkRepository _repo;
        public Way4BpkController(IWay4BpkRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string custName, string okpo, long? ndNumber, long? accNls, int? passState, string passDateStr)
        {
            try
            {
                if (!ndNumber.HasValue && !accNls.HasValue && string.IsNullOrEmpty(custName) && 
                    string.IsNullOrEmpty(okpo) && !passState.HasValue)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, new { Data = new List<W4DealWeb>(), Total = 0 });
                }

                BarsSql sql = SqlCreator.SearchMain(custName, okpo, ndNumber, accNls, passState, passDateStr);
                List<W4DealWeb> data = _repo.SearchGlobal<W4DealWeb>(request, sql).ToList();
                //decimal dataCount = _repo.CountGlobal(request, sql);
                decimal dataCount = (request.Page * request.PageSize) + 1;
                if (data.Count == 0)
                    dataCount = 0;

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage AddDealToCmque(DealData o)
        {
            try
            {
                BarsSql sql = SqlCreator.AddDealToCmque(o.ND, o.OperType);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SetPassDate(BackOfficeData o)
        {
            try
            {
                DateTime dt = DateTime.ParseExact(o.passDateStr, "dd.MM.yyyy", CultureInfo.InvariantCulture);

                BarsSql sql = SqlCreator.SetPassDate(o.nD, o.passState, dt);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchSubproduct([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string code)
        {
            try
            {
                BarsSql sql = SqlCreator.SubProduct(code);
                var data = _repo.SearchGlobal<SubProduct>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);
                //decimal dataCount = (request.Page * request.PageSize) + 1;

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage CngCard(SubProductChange o)
        {
            try
            {
                BarsSql sql = SqlCreator.CngCard(o.ND, o.CODE);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage UserBranch()
        {
            try
            {
                string userBranch = _repo.ExecuteStoreQuery<string>(SqlCreator.UserBranch()).SingleOrDefault();
                
                return Request.CreateResponse(HttpStatusCode.OK, new { userBranch = userBranch });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }

    public class SessionData
    {
        public string Key { get; set; }
        public string Value { get; set; }
    }
}
