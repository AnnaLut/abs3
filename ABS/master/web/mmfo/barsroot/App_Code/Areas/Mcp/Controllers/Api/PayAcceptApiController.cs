using Areas.Mcp.Models;
using BarsWeb.Areas.Mcp.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Mcp.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Mcp.Controllers.Api
{
    [AuthorizeApi]
    public class PayAcceptApiController : ApiController
    {
        readonly IMcpRepository _repo;
        public PayAcceptApiController(IMcpRepository repo) { _repo = repo; }

        #region Pay Accept
        [HttpGet]
        public HttpResponseMessage GetPaymentTypes()
        {
            try
            {
                var data = _repo.GetPaymentTypes().Where(s => !String.IsNullOrEmpty(s));

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetPaymentPeriods()
        {
            try
            {
                var data = _repo.GetPaymentPeriods().Where(s => !String.IsNullOrEmpty(s));

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage SearchPayAccept([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, short kvitId)
        {
            try
            {
                var sql = SqlCreator.SearchPayAccept(kvitId);
                var data = _repo.SearchGlobal<PayAccept>(request, sql);
                var dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SetFileState(FileState o)
        {
            try
            {
                var sql = SqlCreator.SetFileState(o.id, o.stateId);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchEnvelopes([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, short kvitId)
        {
            try
            {
                var sql = SqlCreator.SearchEnvelopes(kvitId);
                var data = _repo.SearchGlobal<Envelopes>(request, sql);
                var dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchFileForMatch([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal? envelopeFileId)
        {
            try
            {
                if (!envelopeFileId.HasValue)
                {
                    var d = new List<File4Match>();
                    return Request.CreateResponse(HttpStatusCode.OK, new { Data = d, Total = 0 });
                }

                var sql = SqlCreator.SearchFile4Match(envelopeFileId.Value);
                var data = _repo.SearchGlobal<File4Match>(request, sql);
                var dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchFileRecForMatch([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal? fileId)
        {
            if (!fileId.HasValue)
            {
                var d = new List<FileRec4Match>();
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = d, Total = 0 });
            }

            try
            {
                var sql = SqlCreator.SearchFileRecForMatch(fileId.Value);
                var data = _repo.SearchGlobal<FileRec4Match>(request, sql);
                var dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage GetBuffer(SignData o)
        {
            try
            {
                var sql = SqlCreator.GetBuffer(o.id, o.kvitId, o.type);
                var data = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();

                return Request.CreateResponse(HttpStatusCode.OK, string.IsNullOrEmpty(data) ? "" : data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SaveSign(SignData o)
        {
            try
            {
                var sql = SqlCreator.SaveSign(o.id, o.kvitId, o.sign);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage Send(List<SignData> o)
        {
            try
            {
                var errors = new List<string>();
                foreach (var v in o)
                {
                    try
                    {
                        var sql = SqlCreator.Send(v.id, v.kvitId);
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
        [HttpPost]
        public HttpResponseMessage SendALL(SignDataAll data)
        {
            try
            {
                var errors = new List<string>();
                try
                {
                    var sql = SqlCreator.Send(data.paymentType, data.paymentPeriod);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                }
                catch (Exception e)
                {
                    errors.Add(e.InnerException != null ? e.InnerException.Message : e.Message);
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
