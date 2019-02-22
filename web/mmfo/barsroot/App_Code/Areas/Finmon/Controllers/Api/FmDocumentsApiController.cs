using System.Web.Http;
using BarsWeb.Core.Logger;
using BarsWeb.Areas.Finmon.Infrastructure.Repository.DI.Abstract;
using System.Net.Http;
using System.Net;
using System;
using System.Web.Http.ModelBinding;
using Areas.Finmom.Models;
using System.Collections.Generic;
using System.Net.Http.Headers;
using System.Web;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Finmon.Controllers.Api
{
    public class FmDocumentsApiController : ApiController
    {
        readonly IFmDocumentsRepository _repo;
        private readonly IDbLogger _logger;
        public FmDocumentsApiController(IFmDocumentsRepository repo, IDbLogger logger)
        {
            _logger = logger;
            _repo = repo;
        }

        /// <summary>
        /// Отримуємо список документів
        /// </summary>
        /// <param name="request"></param>
        /// <param name="_filter"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetDocuments([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string _filter)
        {
            DocsGridFilter filter = Newtonsoft.Json.JsonConvert.DeserializeObject<DocsGridFilter>(_filter);
            try
            {
                KendoGridDs<Document> result = _repo.GetDocuments(request, filter);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Кількість документів за встановленими фільтрами
        /// </summary>
        /// <param name="filter"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage GetDocumentsCount(DocsGridFilter filter)
        {
            try
            {
                int result = _repo.GetDocumentsCount(filter);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Довідник правил фінансового моніторингу
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetRulesList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                KendoGridDs<Filter<decimal>> result = _repo.GetRules(request);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Встановити фільтр по правилам фм
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SetRules(DocsGridFilter model)
        {
            try
            {
                _repo.SetRules(model);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Довідник статусів документів
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetDocumentStatusesList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                KendoGridDs<Filter<string>> result = _repo.GetDocumentStatuses(request);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Довідник "терористів" по документу
        /// </summary>
        /// <param name="request"></param>
        /// <param name="otm"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetTerroristsList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, int otm)
        {
            try
            {
                KendoGridDs<FmTerrorist> result = _repo.GetTerroristsList(request, otm);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Отримання даних з довідників типу k_dfm*
        /// </summary>
        /// <param name="request"></param>
        /// <param name="dictName"></param>
        /// <param name="Code"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetDict([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string dictName, string Code)
        {
            try
            {
                KendoGridDs<DictRow> result = _repo.GetDict(request, dictName, Code);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Метод перевірки існування кодів фінансового моніторингу
        /// <para>Повертає список не існуючих кодів</para>
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage CheckFmCodes([FromUri]List<CheckCodesModel> data)
        {
            try
            {
                List<string> result = new List<string>();
                foreach (CheckCodesModel item in data)
                {
                    result.AddRange(_repo.CheckDictCodes(item.Codes, item.DictName));
                }

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Довідник клієнтів
        /// </summary>
        /// <param name="request"></param>
        /// <param name="rnk"></param>
        /// <param name="okpo"></param>
        /// <param name="name"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetClientsDict([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, long? rnk, string okpo, string name)
        {
            try
            {
                KendoGridDs<ClientData> result = _repo.GetClientsDict(request, rnk, okpo, name);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Історія змін по документу
        /// </summary>
        /// <param name="request"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetDocumentHistory([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string id)
        {
            try
            {
                KendoGridDs<HistoryRow> result = _repo.GetHistory(request, id);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Отримання попередньої банківської дати
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetPreviousBankDate()
        {
            try
            {
                string result = _repo.GetPreviousBankDate();
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Встановлення документам статусу "Відправлено"
        /// </summary>
        /// <param name="documents"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SendDocuments(List<Document> documents)
        {
            try
            {
                //int res = _repo.SendDocuments(documents);
                //return Request.CreateResponse(HttpStatusCode.OK, res);
                _repo.SendDocumentsBulk(documents);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Встановлення документам статусу "Повідомлено"
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SetStatusReported(SetStatusReported data)
        {
            try
            {
                _repo.StatusReported(data.Documents, data.Comment);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Встановлення документам статусу "Відкладено"
        /// </summary>
        /// <param name="documents"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SetASide(List<Document> documents)
        {
            try
            {
                _repo.SetASide(documents);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Встановлення документам статусу "Вилучено"
        /// </summary>
        /// <param name="documents"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage ExcludeDocument(List<Document> documents)
        {
            try
            {
                _repo.Exclude(documents);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Розблокувати документи
        /// </summary>
        /// <param name="documents"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage Unblock(List<Document> documents)
        {
            try
            {
                int res = _repo.Unblock(documents);
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Вивантаження даних в ексель по встановленим фільтрам
        /// </summary>
        /// <param name="_filter"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage ExportToExcel(string _filter)
        {
            DocsGridFilter filter = Newtonsoft.Json.JsonConvert.DeserializeObject<DocsGridFilter>(_filter);
            try
            {
                byte[] file = _repo.ExportToExcel(filter);
                string fileName = "FmExport_" + DateTime.Now.ToString("dd.MM.yyyy_HH:mm:ss") + ".xlsx";
                HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);

                response.Content = new ByteArrayContent(file);
                response.Content.Headers.ContentLength = file.LongLength;

                //Set the Content Disposition Header Value and FileName.
                response.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment");
                response.Content.Headers.ContentDisposition.FileName = fileName;

                //Set the File Content Type.
                response.Content.Headers.ContentType = new MediaTypeHeaderValue(MimeMapping.GetMimeMapping(fileName));
                return response;
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Отримати параметри фінансового моніторингу по документу/документам
        /// </summary>
        /// <param name="refs">Список референсів документів</param>
        /// <param name="bulk">Признак роботи з 1ним документом або багатьма</param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetDocumentFmRules([FromUri]List<decimal> refs, bool bulk)
        {
            try
            {
                DocumentFmRules res = new DocumentFmRules();
                if (bulk)
                    res = _repo.GetDocumentsFmRules(refs);
                else
                    res = _repo.GetDocumentFmRules(refs[0]);

                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Збереження правил фінансового моніторингу
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage SaveFmRules(FmRulesSaveModel data)
        {
            try
            {
                if (data.Bulk)
                    _repo.SaveDocumentsFmRules(data);
                else
                    _repo.SaveDocumentFmRules(data);

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex) { return Error(ex); }
        }

        /// <summary>
        /// Отрмання даних для заповнення форми "коду фін моніторингу" (15 символів)
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetFmCodeTypeData(string code)
        {
            try
            {
                CodeType a = new CodeType(code);
                return Request.CreateResponse(HttpStatusCode.OK, a);
            }
            catch (Exception ex) { return Error(ex); }
        }

        #region private
        /// <summary>
        /// Метод повертає клієнту помилку(http-статус 500) і логує її з параметром rec_module = "FmDocuments"
        /// </summary>
        /// <param name="ex"></param>
        /// <returns></returns>
        private HttpResponseMessage Error(Exception ex)
        {
            _logger.Error(ex.Message + ex.StackTrace, "FmDocuments");
            return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        }
        #endregion
    }
}
