using Areas.Pfu.Models;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Pfu.Models.Grids;
using Ionic.Zip;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Pfu.Controllers.Api
{
    /// <summary>
    /// FilesGrid Data
    /// </summary>
    public class FilesGridController : ApiController
    {
        private readonly IGridRepository _repo;
        private readonly IPfuToolsRepository _repoTools;
        public FilesGridController(IGridRepository repo, IPfuToolsRepository repoTools)
        {
            _repo = repo;
            _repoTools = repoTools;
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/filesdata")]
        public HttpResponseMessage FilesData(decimal Id, [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.FilesData(Id, request);
                var dataCount = _repo.CountFiles(Id, request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Total = dataCount });
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
        //[GET("/api/pfu/filesgrid/envelopedata")]
        public HttpResponseMessage EnvelopeData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.EnvelopesData(request);
                var dataCount = _repo.CountEnvelopes(request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Total = dataCount });
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
        //[GET("/api/pfu/filesgrid/blocktypes")]
        public HttpResponseMessage BlockTypes()
        {
            try
            {
                var data = _repo.GetPensionerBlockType();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/GetSignsEPC")]
        public HttpResponseMessage GetSignsEPC()
        {
            try
            {
                var data = _repo.GetSignsEPC();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/searchpensioner")]
        public HttpResponseMessage SearchPensioner(string qv, [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                string _qv = FromHex(qv);
                SearchQuery search = JsonConvert.DeserializeObject<SearchQuery>(_qv);
                var dataCount = _repo.CountSearch(search, request);
                var data = _repo.Search(search, request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError,
                    ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/blockpensioner")]
        public HttpResponseMessage BlockPensioner(IList<BlockPensioner> pensioners)
        {
            try
            {
                _repo.BlockPensioner(pensioners);
                return Request.CreateResponse(HttpStatusCode.OK, "OK");
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError,
                    ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/removefrompaypensioner")]
        public HttpResponseMessage RemoveFromPayPensioner(IList<BlockPensioner> pensioners)
        {
            try
            {
                _repo.RemoveFromPayPensioner(pensioners);
                return Request.CreateResponse(HttpStatusCode.OK, "OK");
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError,
                    ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/destroyEpc")]
        public HttpResponseMessage DestroyEpc(IList<DestroyEpc> pensioners)
        {
            try
            {
                _repo.DestroyEpc(pensioners);
                return Request.CreateResponse(HttpStatusCode.OK, "OK");
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/readyforsign")]
        public HttpResponseMessage ReadyForSign([FromUri] decimal id)
        {
            try
            {
                _repo.SetReadyForSignStatus(id);
                return Request.CreateResponse(HttpStatusCode.OK, id);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/SetCheckingPayStatus")]
        public HttpResponseMessage SetCheckingPayStatus([FromUri] decimal id, [FromUri] decimal docRef)
        {
            try
            {
                _repo.SetCheckingPayStatus(id, docRef);
                return Request.CreateResponse(HttpStatusCode.OK, id);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/VerifyFile")]
        public HttpResponseMessage VerifyFile([FromUri] decimal id)
        {
            try
            {
                var data = _repo.VerifyFile(id);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/readyformatching")]
        public HttpResponseMessage ReadyForMatching(FileForMatchingKvit1And2 data)
        {
            try
            {
                _repo.SetReadyForMatchingStatus(data);
                return Request.CreateResponse(HttpStatusCode.OK, data.Id);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/regenmatching")]
        public HttpResponseMessage Regenmatching(FileForMatchingKvit1And2 data)
        {
            try
            {
                _repo.SetRegenMatchingStatus(data);
                return Request.CreateResponse(HttpStatusCode.OK, data.Id);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/prepareformatchingstatus")]
        public HttpResponseMessage PrepareForMatchingStatus(FileForMatching data)
        {
            try
            {
                var result = _repo.PrepareForMatchingStatus(data);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/readyformatchingstatus2")]
        public HttpResponseMessage ReadyForMatchingStatus2(IList<FileForMatching> data)
        {
            try
            {
                foreach (FileForMatching f in data) { _repo.SetReadyForMatchingStatus2(f.ID); }
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/readypaybackkvit2")]
        public HttpResponseMessage ReadyPaybackKvit2(IList<PaybackKvit2> data)
        {
            try
            {
                foreach (PaybackKvit2 f in data) { _repo.SetPaybackKvit2(f.id, f.NUM_PAYM, f.DATE_PAYBACK); }
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/pfufilestatus")]
        public HttpResponseMessage PfuFileStatus()
        {
            try
            {
                var data = _repo.PfuFileStatus();
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

        [HttpGet]
        //[GET("/api/pfu/filesgrid/pfuenvelopstate")]
        public HttpResponseMessage PfuEnvelopState()
        {
            try
            {
                var data = _repo.PfuEnvelopState();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/recordstatus")]
        public HttpResponseMessage RecordStatus()
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.RecordStatus();
                IEnumerable<RecordStatus> data = _repo.ExecuteStoreQuery<RecordStatus>(sql);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/searchcatalog")]
        public HttpResponseMessage SearchCatalog([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string State, decimal? IdCatalog, string Mfo, DateTime? CatalogDate, decimal? EnvelopeId, DateTime? PayDate, string fileType)
        {
            try
            {
                if (State == "null")
                    State = null;
                var search = new SearchCatalog { State = State, IdCatalog = IdCatalog, Mfo = Mfo, CatalogDate = CatalogDate, PayDate = PayDate, EnvelopeId = EnvelopeId, FileType = fileType };
                var dataCount = _repo.CountCatalog(search, request);
                var data = _repo.Catalog(search, request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Total = dataCount });
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
        //[GET("/api/pfu/filesgrid/searchcataloginpay")]
        public HttpResponseMessage SearchCatalogInPay([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal? IdCatalog, string Mfo, DateTime? CatalogDate, DateTime? PayDate)
        {
            try
            {
                var search = new SearchCatalog { IdCatalog = IdCatalog, Mfo = Mfo, CatalogDate = CatalogDate, PayDate = PayDate };
                var dataCount = _repo.CountCatalogInPay(search, request);
                var data = _repo.CatalogInPay(search, request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError,
                    ex.Message);
                return response;
            }
        }
        [HttpPost]
        //[POST("/api/pfu/filesgrid/processregistres")]
        public HttpResponseMessage ProcessRegistres(int[] ids)
        {
            try
            {
                _repo.ProcessRegistres(ids);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
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
        //[GET("/api/pfu/filesgrid/searchcataloghistory")]
        public HttpResponseMessage SearchCatalogHistory([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var dataCount = _repo.CountCatalogHistory(request);
                var data = _repo.CatalogHistory(request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/searchregisterepc")]
        public HttpResponseMessage SearchRegisterEpc([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal? RegisterId = null, DateTime? RegisterDate = null)
        {
            try
            {
                var search = new SearchRegisterEpc { RegisterId = RegisterId, RegisterDate = RegisterDate };
                var data = _repo.SearchRegisterEpc(search, request);
                var dataCount = _repo.CountRegisterEpc(search, request);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/searchregisterlinesepc")]
        public HttpResponseMessage SearchRegisterLinesEpc([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string FullName, string TaxID, string EpcId, decimal? State)
        {
            try
            {
                var search = new SearchRegisterLinesEpc { FullName = FullName, TaxID = TaxID, EpcId = EpcId, State = State };


                var data = _repo.SearchRegisterEpcLine(search, request);
                var dataCount = _repo.CountRegisterEpcLine(search, request);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }


        [HttpPost]
        //[POST("/api/pfu/filesgrid/destroyedepcinfo")]
        public HttpResponseMessage DestroyedEpcInfo([FromUri] string epcId)
        {
            try
            {
                var data = _repo.GetDestroyedEpcInfo(epcId);


                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/pfuepclinestatus")]
        public HttpResponseMessage PfuEpcLineStatus()
        {
            try
            {
                var data = _repo.PfuEpcLineeStatus();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/GetSentConvert")]
        public HttpResponseMessage GetSentConvert([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetSentConvert();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.NoContent, ex.Message);
                return response;
            }
        }


        [HttpGet]
        //[GET("/api/pfu/filesgrid/searchenvelop")]
        public HttpResponseMessage SearchEnvelop([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string State, decimal? Id, DateTime? CreatingDate)
        {
            try
            {
                var search = new SearchEnvelop { Id = Id, State = State, CreatingDate = CreatingDate };
                var dataCount = _repo.CountEnvelopes(search, request);
                var data = _repo.Envelopes(search, request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.NoContent, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/linecatalog")]
        public HttpResponseMessage LineCatalog(decimal Id, [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var dataCount = _repo.CountLineCatalog(Id, request);
                var data = _repo.LineCatalog(Id, request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Total = dataCount });
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
        //[GET("/api/pfu/filesgrid/linecataloginpay")]
        public HttpResponseMessage LineCatalogInPay(decimal? id, [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var dataCount = _repo.CountLineCatalogInPay(id, request);
                var data = _repo.LineCatalogInPay(id, request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError,
                    ex.Message);
                return response;
            }
        }
        [HttpPost]
        //[POST("/api/pfu/filesgrid/ProcessRecords")]
        public HttpResponseMessage ProcessRecords(dynamic data)
        {
            try
            {
                string stateName = data["stateName"];
                int[] ids = ((JArray)data["ids"]).Select(jv => (int)jv).ToArray();
                _repo.ProcessRecords(ids, stateName);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
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
        public HttpResponseMessage GetStatesFromLine(decimal Id)
        {
            try
            {
                var data = _repo.GetStatesFromLine(Id);
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
        //[GET("/api/pfu/filesgrid/pfufile")]
        public HttpResponseMessage PfuFile(decimal Id)
        {
            try
            {
                var pfuBlob = _repoTools.GetPfuFileBlob(Id);
                var stream = new MemoryStream(pfuBlob.file_data);
                var fileName = "attachment; filename=PfuFile_" + pfuBlob.file_name + ".txt";

                HttpResponseMessage result = new HttpResponseMessage(HttpStatusCode.OK);
                result.Content = new StreamContent(stream);
                result.Content.Headers.Add("Content-Disposition", fileName);
                result.Content.Headers.Add("Content-Type", "application/octet-stream");
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError,
                    "Обраний файл не містить інформації.<br>" + ex.Message);
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/pfuenvelope")]
        public HttpResponseMessage PfuEnvelope(decimal Id)
        {
            try
            {
                var files = _repo.FilesData(Id, new DataSourceRequest());
                ZipFile zip = new ZipFile();
                foreach (var file in files)
                {
                    V_PFUFILE_BLOB fileBlob = _repoTools.GetPfuFileBlob(file.id);
                    if (fileBlob != null && !zip.ContainsEntry(fileBlob.file_name))
                    {
                        zip.AddEntry(file.file_name, new MemoryStream(fileBlob.file_data));
                    }
                }

                var stream = new MemoryStream();
                zip.Save(stream);
                stream.Seek(0, SeekOrigin.Begin);
                var fileName = "attachment; filename=PfuEnvelope_" + Id + ".zip";

                HttpResponseMessage result = new HttpResponseMessage(HttpStatusCode.OK);
                result.Content = new StreamContent(stream);
                result.Content.Headers.Add("Content-Disposition", fileName);
                result.Content.Headers.Add("Content-Type", "application/zip");
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError,
                    "Обраний файл не містить інформації.<br>" + ex.Message);
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/SearchDestroyedEpc")]
        public HttpResponseMessage SearchDestroyedEpc(string qv, [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                string _qv = FromHex(qv);
                SearchDestroyedEpcQuery search = JsonConvert.DeserializeObject<SearchDestroyedEpcQuery>(_qv);

                var dataCount = _repo.CountSearchDestroyedEpc(search, request);
                var data = _repo.SearchDestroyedEpc(search, request);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        #region KVIT 2
        [HttpGet]
        //[GET("/api/pfu/filesgrid/searchkvitsend")]
        public HttpResponseMessage SearchKvitSend([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.SearchGlobal<V_PFU_KVIT_2>(request, SqlCreator.InitSearchKvitSend());
                var dataCount = _repo.CountGlobal(request, SqlCreator.InitSearchKvitSend());

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/searchkvitsendhistory")]
        public HttpResponseMessage SearchKvitSendHistory([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.InitSearchKvitSendHistory();
                IEnumerable<V_PFU_KVIT_2> data = _repo.SearchGlobal<V_PFU_KVIT_2>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }
        #endregion

        [HttpGet]
        //[GET("/api/pfu/filesgrid/searchsync")]
        public HttpResponseMessage SearchSync([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string KF = null, decimal? CURSTATE = null)
        {
            try
            {
                var search = new SearchSyncPensioners { KF = KF, CURSTATE = CURSTATE };
                var data = _repo.SearchSync(search, request);
                var dataCount = _repo.CountSync(search, request);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/sync")]
        public HttpResponseMessage Sync(IList<SyncPensioners> data)
        {
            try
            {
                _repo.SyncPensioners(data);
                return Request.CreateResponse(HttpStatusCode.OK, "OK");
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        //[GET("/api/pfu/filesgrid/syncstatus")]
        public HttpResponseMessage SyncStatus()
        {
            try
            {
                var data = _repo.PfuSyncStatus();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        //[POST("/api/pfu/filesgrid/BalanceRequest")]
        public HttpResponseMessage BalanceRequest(string acc, decimal id, decimal p_kf)
        {
            try
            {
                _repo.BalanceRequest(acc, id, p_kf);
                return Request.CreateResponse(HttpStatusCode.OK, "OK");
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchRecBlocked([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                Kernel.Models.BarsSql sql = SqlCreator.RecBlocked();
                IEnumerable<RecBlockedResult> data = _repo.SearchGlobal<RecBlockedResult>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        string FromHex(string hex)
        {
            var bytes = new byte[hex.Length / 2];
            for (var i = 0; i < bytes.Length; i++)
            {
                bytes[i] = Convert.ToByte(hex.Substring(i * 2, 2), 16);
            }
            return HttpUtility.UrlDecode(bytes, Encoding.UTF8);
            //return Encoding.UTF8.GetString(bytes);
        }

        [HttpGet]
        public HttpResponseMessage GetFileTypes()
        {
            try
            {
                IEnumerable<FileType> _data = _repo.GetFileTypes();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = _data });
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}