using Areas.Mcp.Models;
using BarsWeb.Areas.Mcp.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Mcp.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Mcp.Controllers.Api
{
    [AuthorizeApi]
    public class ErrorsRecordsApiController : ApiController
    {
        readonly IMcpRepository _repo;
        public ErrorsRecordsApiController(IMcpRepository repo) { _repo = repo; }

        #region Errors files
        [HttpGet]
        public HttpResponseMessage SearchFileRecordsErr([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string KF_BANK, decimal? FILE_ID, short? STATE_ID)
        {
            if (!FILE_ID.HasValue && !STATE_ID.HasValue && string.IsNullOrEmpty(KF_BANK))
            {
                var d = new List<FileRecordsErr>();
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = d, Total = 0 });
            }

            try
            {
                var sql = SqlCreator.SearchFileRecordsErr(KF_BANK, FILE_ID, STATE_ID);
                var data = _repo.SearchGlobal<FileRecordsErr>(request, sql);
                var dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage Set2Pay(List<decimal> o)
        {
            try
            {
                var errors = new List<string>();
                foreach (var id in o)
                {
                    try
                    {
                        var sql = SqlCreator.Set2Pay(id);
                        _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                    }
                    catch (Exception e)
                    {
                        errors.Add(string.Format("{0} : {1}", id, e.InnerException != null ? e.InnerException.Message : e.Message));
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, new { Errors = errors });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage RemoveFromPay(List<RemoveFromPayData> o)
        {
            try
            {
                var errors = new List<string>();
                foreach (var v in o)
                {
                    try
                    {
                        var sql = SqlCreator.RemoveFromPay(v.id, v.comment, v.block_type);
                        _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                    }
                    catch (Exception e)
                    {
                        errors.Add(string.Format("{0} : {1}", v.id, e.InnerException != null ? e.InnerException.Message : e.Message));
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, new { Errors = errors });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        #endregion
    }
}
