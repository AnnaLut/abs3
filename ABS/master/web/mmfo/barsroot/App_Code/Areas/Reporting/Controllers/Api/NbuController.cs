using System;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;
using System.Web;
using BarsWeb.Areas.Reporting.Models.PL;
using BarsWeb.Areas.Reporting.Models;
using System.Collections.Generic;
using BarsWeb.Areas.Kernel.Infrastructure;
using BarsWeb.Areas.Kernel.Models.KendoViewModels;
using BarsWeb.Infrastructure.Helpers;
using System.IO;

namespace BarsWeb.Areas.Reporting.Controllers.Api
{
    [Authorize]
    [AuthorizeApi]
    [CheckAccessPage]
    public class NbuController : ApiController
    {
        private readonly INbuRepository _repository;
        public NbuController(INbuRepository repository)
        {
            _repository = repository;
        }
        [GET("api/reporting/nbu")]
        public DataSourceResult Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            int id, string fileCodeBase64, string schemeCode, string kf, string date, string isCon)
        {
            try
            {
                DataRow dataTable = GetReportDataRow(fileCodeBase64, schemeCode, kf, date, isCon);
                if (dataTable != null)
                {
                    return dataTable.Table.ToDataSourceResult(request);
                }
            }
            catch (Exception e)
            {
                return new DataSourceResult
                {
                    Errors = e
                };
            }

            return new DataSourceResult();
        }

        [HttpPost]
        [POST("api/reporting/nbu/getrepodata")]
        public HttpResponseMessage GetRepoData(RepoDataRequest o)
        {
            try
            {
                decimal? versionId = null;
                if (!string.IsNullOrEmpty(o.versionId) && o.versionId != "null")
                {
                    versionId = Convert.ToDecimal(o.versionId);
                }
                DataRow Data = GetReportDataRow(o.fileCodeBase64, o.schemeCode, o.kf, o.date, o.isCon, versionId);
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = Data });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [Obsolete("Для динамической загрузки использовать GetDetaledRepData")]
        [GET("api/reporting/nbu/DetailedRep")]
        public HttpResponseMessage GetDetaledRep(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string fileCodeBase64,
            string kf,
            string reportDate,
            string schemeCode,
            string fieldCode = null)
        {
            try
            {
                var data = _repository.GetDetailedReport(request, ConvertFileCode(fileCodeBase64), reportDate, kf, fieldCode, schemeCode);
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = (request.Page * request.PageSize) + 1 });
            }
            catch (Exception ex)
            {
                 return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [GET("api/reporting/nbu/getdetailedrepdatacolumns")]
        public HttpResponseMessage GetDetaledRepDataСolumns(
            string fileCodeBase64,
            string kf,
            string reportDate,
            string schemeCode,
            bool isDtl,
            string nbuc = null,
            string fieldCode = null)
        {
            try
            {
                List<Columns> columns = new List<Columns>();

                string vn = _repository.GetViewName(ConvertFileCode(fileCodeBase64), isDtl);
                List<AllColComments> tc = _repository.GetTableComments(vn);

                foreach (AllColComments col in tc)
                {
                    columns.Add(new Columns { field= col.COLUMN_NAME , title = col.COMMENTS});
                }

                return Request.CreateResponse(HttpStatusCode.OK, new { Columns = columns });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [GET("api/reporting/nbu/getchklog")]
        public HttpResponseMessage GetChkLog(string fileCodeBase64, string kf, string reportDate, string schemeCode, decimal? versionId)
        {
            try
            {
                string fileCode = ConvertFileCode(fileCodeBase64);

                string log = _repository.GetChkLog(fileCode, reportDate, kf, schemeCode, versionId);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = log });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [GET("api/reporting/nbu/getdetailedrepdata")]
        public HttpResponseMessage GetDetaledRepData(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string fileCodeBase64,
            string kf,
            string reportDate,
            string schemeCode,
            bool isDtl,
            string nbuc = null,
            string fieldCode = null)
        {
            try
            {
                string vn = _repository.GetViewName(ConvertFileCode(fileCodeBase64), isDtl);
                List<AllColComments> tc = _repository.GetTableComments(vn);

                List<Dictionary<string, object>> result = _repository.GetDetailedReportDyn(request, vn, ConvertFileCode(fileCodeBase64), reportDate, kf, fieldCode, schemeCode, nbuc);
                return Request.CreateResponse(HttpStatusCode.OK, new
                {
                    Data = result,
                    Total = (request.Page * request.PageSize) + 1                
                });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //[GET("api/reporting/nbu/DetailedRepFile")]
        //public DataSourceResult GetDetaledRepFile(
        //    [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, 
        //    string fileCodeBase64, 
        //    string kf, 
        //    string reportDate,
        //    string schemeCode,
        //    string fieldCode = null)
        //{
        //    if (string.IsNullOrEmpty(fileCodeBase64) || fileCodeBase64 == "undefined")
        //    {
        //        return new DataSourceResult();
        //    }
        //    string fileCode = ConvertFileCode(fileCodeBase64);
        //    var data = _repository.GetDetailedReport(fileCode, reportDate, kf, fieldCode, schemeCode).Tables[0].AsEnumerable().FirstOrDefault();

        //    if (data != null)
        //    {
        //        var sourth = data.Table.ToDataSourceResult(request);
        //        return sourth;
        //    }

        //    return new DataSourceResult();
        //}

        [HttpGet]
        [GET("api/reporting/nbu/file")]
        public HttpResponseMessage GetFile(string fileCodeBase64, string reportDate, string kf, string schemeCode, decimal? versionId)
        {
            if (string.IsNullOrEmpty(fileCodeBase64) || fileCodeBase64 == "undefined")
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { reponseMessage = "немає коду файла" });
            string fileCode = ConvertFileCode(fileCodeBase64);

            string fBody;
            try
            {
                fBody = _repository.GenerateReportFromClob(reportDate, fileCode, kf, schemeCode, versionId);
            }
            catch (Exception e)
            {
                throw new Exception("Не вдалось отримати файл. Помилка: " + (e.InnerException == null ? e.Message : e.InnerException.Message));
            }
            //var textFile = _repository.GetReportFile(code, date);
            string fName;
            try
            {
                fName = _repository.GenerateReportFiltName(fileCode, reportDate, kf, schemeCode, versionId);
            }
            catch (Exception e)
            {
                throw new Exception("Не вдалось отримати назву файла. Помилка: " + (e.InnerException == null ? e.Message : e.InnerException.Message));
            }

            string fileFmt = string.Empty;
            try
            {
                fileFmt = _repository.GetFileFmt(fileCode, false);
            }
            catch (Exception e)
            {
                throw new Exception("Не вдалось отримати назву файла. Помилка: " + (e.InnerException == null ? e.Message : e.InnerException.Message));
            }

            HttpResponseMessage result = Request.CreateResponse(HttpStatusCode.OK);
            //for XML - use utf-8

            Encoding enc = fileFmt == "XML" ? Encoding.UTF8 : Encoding.GetEncoding(866);
            fName = fileFmt != "XML"
                ?fName
                :(fName[0]=='#')
                    ?string.Format("{0}X{1}.XML", fName.Substring(1, 2), fName.Substring(3).Replace(".",""))
                    :string.Format("{0}X{1}.XML", fName.Substring(0, 2), fName.Substring(3).Replace(".",""));
            result.Content = new StringContent(fBody, enc, "text/plain");
            result.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment")
            {
                FileName = Uri.EscapeDataString(fName)
            };

            return result;
        }

        [HttpPut]
        public HttpResponseMessage Put(string reportDate, string fileCodeBase64, string schemeCode, string fileType, string kf)
        {
            if (string.IsNullOrEmpty(fileCodeBase64) || fileCodeBase64 == "undefined")
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError,
                    new { reponseMessage = "немає коду файла" });
            }
            string fileCode = ConvertFileCode(fileCodeBase64);
            string message = _repository.StartCreateReport(reportDate, fileCode, schemeCode, fileType, kf);
            return Request.CreateResponse(HttpStatusCode.OK, new { reponseMessage = message });
        }
        [PUT("api/reporting/nbu/rowupdate")]
        public HttpResponseMessage PutRowUpdate(object newRow)
        {
            throw new NotImplementedException();
        }
        [HttpPost]
        [POST("api/reporting/nbu/blockFile")]
        public HttpResponseMessage BlockFile(FileRequestParameters parameters)
        {
            _repository.BlockFile(parameters.ReportDate, parameters.FileId, parameters.Kf, parameters.VersionId);
            return Request.CreateResponse(HttpStatusCode.OK, "Файл успішно заблоковано");
        }


        [GET("api/reporting/nbu/GetFileInfo")]
        public HttpResponseMessage GetFileInfo(string fileCodeBase64, string reportDate, string kf, decimal? versionId = null)
        {
            string fileCode = ConvertFileCode(fileCodeBase64);
            var fileInfo = _repository.GetNburListFromFinished(fileCode, reportDate, kf, versionId);

            return Request.CreateResponse(HttpStatusCode.OK, fileInfo);
        }

        [GET("api/reporting/nbu/getexcel")]
        public HttpResponseMessage GetExcel(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string gridData,
            string fileCodeBase64,
            string kf,
            string reportDate,
            string schemeCode,
            bool isDtl,
            string nbuc = null,
            string fieldCode = null)
        {
            try
            {
                DataSourceAdapter dataSourceAdapter = new DataSourceAdapter();
                WebDatasourceModel datasourceModel = Newtonsoft.Json.JsonConvert.DeserializeObject<WebDatasourceModel>(gridData);
                if (datasourceModel == null)
                {
                    datasourceModel = new WebDatasourceModel();
                }
                var req = dataSourceAdapter.ParsDataSours(datasourceModel);

                List<Columns> columns = new List<Columns>();

                string vn = _repository.GetViewName(Encoding.UTF8.GetString(Convert.FromBase64String(fileCodeBase64)), isDtl);
                List<AllColComments> tc = _repository.GetTableComments(vn);

                List<string[]> title = new List<string[]>();
                foreach (AllColComments col in tc)
                {
                    if (col.COLUMN_NAME != "DESCRIPTION")
                    {
                        title.Add(new string[] { col.COLUMN_NAME, col.COMMENTS });
                    }
                }
                AllColComments columnDesc = tc.Find((col) => col.COLUMN_NAME == "DESCRIPTION");
                if (columnDesc != null)
                {
                    title.Add(new string[] { columnDesc.COLUMN_NAME, columnDesc.COMMENTS });  // put comments to the end of list
                }

                List<Dictionary<string, object>> res = _repository.GetDetailedReportDyn(req, vn, Encoding.UTF8.GetString(Convert.FromBase64String(fileCodeBase64)), reportDate, kf, fieldCode, schemeCode, nbuc);

                List<TableInfo> ti = _repository.GetTableInfo(vn);

                var exel = new ExcelHelpers<List<Dictionary<string, object>>>(res, title, ti, null);

                // todo: add filters and sorts
                //List<DetailedReport> res = _repository.GetDetailedReportList(Encoding.UTF8.GetString(Convert.FromBase64String(fileCodeBase64)), reportDate, kf, fieldCode, schemeCode);
                //var exel = new ExcelHelpers<DetailedReport>(res, true);

                string fPath = string.Empty;
                using(var ms = exel.ExportToMemoryStream())
                {
                    fPath = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
                    File.WriteAllBytes(fPath, ms.ToArray());
                }

                return Request.CreateResponse(HttpStatusCode.OK, new { FileName = fPath });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        private string ConvertFileCode(string fileCodeBase64)
        {
            var bytesFileCodeBase64 = Convert.FromBase64String(fileCodeBase64);
            string fileCode = Encoding.UTF8.GetString(bytesFileCodeBase64);
            return fileCode;
        }

        DataRow GetReportDataRow(string fileCodeBase64, string schemeCode, string kf, string date, string isCon, decimal? versionId = null)
        {
            string fileCode = ConvertFileCode(fileCodeBase64);
            var data = _repository.GetReportData(fileCode, schemeCode, kf, date, isCon);
            if (data != null && data.Tables.Count > 0)
            {
                return data.Tables[0].AsEnumerable().FirstOrDefault();                
            }
            return null;
        }
    }
}