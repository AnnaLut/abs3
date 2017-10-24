using Bars.Areas.DptSocial.Models;
using BarsWeb.Areas.DptSocial.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.DptSocial.Controllers.Api
{
    public class ImportFilesApiController : ApiController
    {
        private readonly IImportFilesRepository _repository;

        public ImportFilesApiController(IImportFilesRepository repository)
        {
            _repository = repository;
        }

        //api to get data for filesGrid by file_tp and file_data
        [HttpGet]
        public HttpResponseMessage GetImportedFilesGridData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, Int32 file_tp, String file_date)
        {
            try
            {
                //get data from DB
                List<V_DPT_FILE_IMPR> data = _repository.GetImportedFilesGridData(file_tp, file_date);
                return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message + (ex.InnerException == null ? "" : ". " + ex.InnerException.Message));
            }
        }

        //api to get data for detailGrid
        [HttpGet]
        public HttpResponseMessage GetImportedFileDetailGridData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string file_dt, Int32 file_tp)
        {
            try
            {
                //get data from DB
                List<V_DPT_FILE_IMPR_DTL> data = _repository.GetImportedFileDetailGridData(file_dt, file_tp);
                return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message + (ex.InnerException == null ? "" : ". " + ex.InnerException.Message));
            }
        }

        [HttpGet]
        public HttpResponseMessage ProcessFiles(String path, Int32 file_tp)
        {
            try
            {
                Result result = _repository.ProcessFiles(path, file_tp);
                String response_message = String.Format("Знайдено файлів: {0}<br/>Оброблено файлів: {1}<br/>Помилкових: {2}<br/>", 
                                                        result.FILE_AMNT, 
                                                        (result.FILE_AMNT - result.ERRORS_FILES.Count),
                                                        result.ERRORS_FILES.Count);
                if (result.ERRORS_FILES.Count > 0)
                {
                    foreach (ProcessFileResult model in result.ERRORS_FILES)
                    {
                        response_message += String.Format("Ім'я файлу: {0}<br/>Помилка: {1}<br/>", model.FILE_NAME, model.ERORR);
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, response_message);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message + (ex.InnerException == null ? "" : ". " + ex.InnerException.Message));
            }
        }

        [HttpGet]
        public HttpResponseMessage GetPath()
        {
            List<PATH> list = new List<PATH>();
            try
            {
                list.Add(new PATH(Bars.Configuration.ConfigurationSettings.AppSettings["SOC.PensionDir"], 1));
                list.Add(new PATH(Bars.Configuration.ConfigurationSettings.AppSettings["SOC.SocialDir"], 2));
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message + (ex.InnerException == null ? "" : ". " + ex.InnerException.Message));
            }
        }
    }
}
