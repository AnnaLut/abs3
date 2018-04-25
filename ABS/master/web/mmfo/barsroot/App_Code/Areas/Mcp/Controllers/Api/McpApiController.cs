using BarsWeb.Areas.Mcp.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Mcp.Infrastructure.DI.Implementation;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Areas.Mcp.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.Mcp.Controllers.Api
{
    [AuthorizeApi]
    public class McpController: ApiController
    {
        readonly IMcpRepository _repo;
        public McpController(IMcpRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchFiles([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, 
            string DateRegister, string PaymentType, string FileNameRegister, 
            int? ReceiverMFO, long? IDRegister, short? StateRegister)
        {
            if (string.IsNullOrEmpty(DateRegister) && string.IsNullOrEmpty(PaymentType) && 
                string.IsNullOrEmpty(FileNameRegister) && !ReceiverMFO.HasValue && !IDRegister.HasValue &&
                !StateRegister.HasValue)
            {
                var f = new List<Files>();
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = f, Total = 0 });
            }

            try
            {
                var sql = SqlCreator.SearchFiles(DateRegister, PaymentType, FileNameRegister, 
                    ReceiverMFO, IDRegister, StateRegister);
                var data = _repo.SearchGlobal<Files>(request, sql);
                var dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchInfoLines([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, long? FileId)
        {
            if (!FileId.HasValue)
            {
                var d = new List<InfoLines>();
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = d, Total = 0 });
            }

            try
            {
                var sql = SqlCreator.SearchInfoLines(FileId.Value);
                var data = _repo.SearchGlobal<InfoLines>(request, sql);
                var dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage FileStates()
        {
            try
            {
                var sql = SqlCreator.FileStates();
                var data = _repo.ExecuteStoreQuery<RegisterStates>(sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage InfoLineStates()
        {
            try
            {
                var sql = SqlCreator.InfoLineStates();
                var data = _repo.ExecuteStoreQuery<RegisterStates>(sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage BalanceRu(List<BalanceRuData> o)
        {
            try
            {
                var errors = new List<string>();
                foreach (var v in o)
                {
                    try
                    {
                        var sql = SqlCreator.BalanceRu(v.id, v.accNum2560, v.receiverMfo);
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

        [HttpGet]
        public HttpResponseMessage BlockTypes()
        {
            try
            {
                var sql = SqlCreator.BlockTypes();
                var data = _repo.ExecuteStoreQuery<RegisterStates>(sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage VerifyFileAndPreparePayment(VerifyFileData o)
        {
            try
            {
                var sql = SqlCreator.VerifyFile(o.id);
                //_repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);    // todo: add

                sql = SqlCreator.PreparePayment(o.id);
                var data = _repo.ExecuteStoreQuery<Payment>(sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage Pay(VerifyFileData o)
        {
            try
            {
                var sql = SqlCreator.Pay(o.id);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
       
        [HttpPut]
        public HttpResponseMessage SetFileRecordsPayed(FileRecordsPayedVM fr)
        {
            try
            {
                if(fr.FileRecords == null) return Request.CreateResponse(HttpStatusCode.InternalServerError, "The list of rows to change the status is empty.");
                for (int i = 0; i < fr.FileRecords.Length; i++)
                {
                    var sql = SqlCreator.SetFileRecordPayed(fr.FileRecords[i], fr.Date);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                }

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        [HttpPut]
        public HttpResponseMessage SetFileRecordsReverted(decimal[] fileRecordIds)
        {
            try
            {
                if (fileRecordIds == null || fileRecordIds.Length == 0) return Request.CreateResponse(HttpStatusCode.InternalServerError, "The list of rows to change the status is empty.");
                for (int i = 0; i < fileRecordIds.Length; i++)
                {
                    var sql = SqlCreator.SetFileRecordsReverted(fileRecordIds[i]);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                }

                return Request.CreateResponse(HttpStatusCode.OK);
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
    }
}
