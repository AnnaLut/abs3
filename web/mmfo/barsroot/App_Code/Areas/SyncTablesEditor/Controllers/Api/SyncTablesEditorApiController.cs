using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.SyncTablesEditor.Infrastructure.DI.Abstract;
using BarsWeb.Areas.SyncTablesEditor.Infrastructure.DI.Implementation;
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
using Areas.SyncTablesEditor.Models;
using Bars.Classes;
using System.Linq;
using Dapper;
using System.Collections.Generic;
using System.Windows.Forms;

namespace BarsWeb.Areas.SyncTablesEditor.Controllers.Api
{
    public class SyncTablesEditorController : ApiController
    {
        readonly ISyncTablesEditorRepository _repo;
        public SyncTablesEditorController(ISyncTablesEditorRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMain();
                var data = _repo.SearchGlobal<SyncTables>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SetRow(SyncTables model)
        {
            try
            {
                ResponseSTE result = _repo.UpdateRecord(model);

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage DeleteRow(SyncTables model)
        {
            try
            {
                ResponseSTE result = _repo.DeleteRecord(model);

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SyncTab(SyncTables model)
        {
            try
            {
                ResponseSTE result = _repo.SynchronizeTable(model);

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SyncAllTabs()
        {
            try
            {
                ResponseSTE result = _repo.SynchronizeAllTables();

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage ExecuteSelect(SelectObj _sql)
        {
            ResponseSTE result = new ResponseSTE() { Result = "OK", ResultObj = "", ResultMsg = "" };
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    List<dynamic> list = connection.Query(_sql.sql).ToList();
                    if (list.Count > 0)
                        result.ResultObj = list;
                }
            }
            catch (Exception ex)
            {
                result.ErrorMsg = ex.Message;
                result.Result = "ERROR";
            }
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [HttpGet]
        public HttpResponseMessage GetFileFullName(int tabId)
        {
            try
            {
                ResponseSTE result = _repo.GetFullFilePath(tabId);

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetFileLastChangeDate(int tabId)
        {
            try
            {
                ResponseSTE result = _repo.GetFileLastChangeDate(tabId);

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage RecieveFile()
        {
            try
            {
                var httpRequest = HttpContext.Current.Request;
                if (httpRequest.Files.Count != 0)
                {
                    var uploadedFile = httpRequest.Files[0].FileName;
                    var httpPostedFile = HttpContext.Current.Request.Files[0];

                    if (httpPostedFile == null) return Request.CreateResponse(HttpStatusCode.OK, new ResponseSTE() { Result = "ERROR", ErrorMsg = "No file found." });

                    byte[] fileData = null;
                    using (var binaryReader = new BinaryReader(httpPostedFile.InputStream))
                    {
                        fileData = binaryReader.ReadBytes(httpPostedFile.ContentLength);
                    }
                    var fileDate = httpRequest.Form["lastModifDate"];
                    var tabId = httpRequest.Form["tabId"];

                    var result = _repo.UploadFileData(fileData, fileDate, Convert.ToInt32(tabId));
                    return Request.CreateResponse(HttpStatusCode.OK, result);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK, new ResponseSTE() { Result = "ERROR", ErrorMsg = "No file found." });
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSTE() { Result = "ERROR", ErrorMsg = ex.Message });
            }
        }

        [HttpPost]
        public HttpResponseMessage UploadFile(FileInput model)
        {
            try
            {
                ResponseSTE result = _repo.UploadFile(model);

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseSTE() { Result = "ERROR", ErrorMsg = ex.Message });
            }
        }

        [HttpPost]
        public HttpResponseMessage CheckFile(FileInput param)
        {
            try
            {
                FileCheckResponse result = _repo.CheckFile(new SyncTables() { TABID = param.TabId }, param.FilePath);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new FileCheckResponse() { Result = "ERROR", ErrorMsg = ex.Message });
            }
        }

        [HttpGet]
        public HttpResponseMessage ExportTableToSql(int tabId)
        {
            try
            {
                ResponseSTE result = _repo.ExportTableToSql(tabId);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new FileCheckResponse() { Result = "ERROR", ErrorMsg = ex.Message });
            }
        }
    }
}
