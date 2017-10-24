using Areas.Swift.Models;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Swift.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Swift.Controllers.Api
{
    public class PositionerController : ApiController
    {
        readonly ISwiftRepository _repo;        
        public PositionerController(ISwiftRepository repo) { _repo = repo; }

        [HttpGet]
        [GET("/api/positionersearch")]
        public HttpResponseMessage PositionerSearch([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal? Ref)
        {
            try
            {
                BarsSql sql = SqlCreatorPositioner.PositionerSearch(Ref);
                IEnumerable<PositionerData> data = _repo.SearchGlobal<PositionerData>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        [GET("/api/positionercorrespondentsearch")]
        public HttpResponseMessage PositionerCorrespondentSearch([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, int kv, byte pap)
        {
            try
            {
                BarsSql sql = SqlCreatorPositioner.PositionerCorrespondentSearch(kv, pap);
                IEnumerable<PositionerCorrespondentData> data = _repo.SearchGlobal<PositionerCorrespondentData>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/positioneraction")]
        public HttpResponseMessage PositionerAction(PositionerActionData obj)
        {
            try
            {
                decimal ref_nos = -1;
                if (obj.p_type == "PAYNOTACC")
                {
                    BarsSql sql = SqlCreatorPositioner.PayNotAcc(obj.p_ref);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                }
                else
                {
                    BarsSql sql = SqlCreatorPositioner.Action(obj.p_ref, obj.p_type, obj.p_acc);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                    if (obj.p_type == "PAY")
                    {
                        sql = SqlCreatorPositioner.RefNos(obj.p_ref);
                        ref_nos = _repo.ExecuteStoreQuery<decimal>(SqlCreatorPositioner.RefNos(obj.p_ref)).FirstOrDefault();
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, new { ref_nos = ref_nos });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }        
    }
}