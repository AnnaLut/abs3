using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.SignStatFiles.Infrastructure.DI.Abstract;
using BarsWeb.Areas.SignStatFiles.Infrastructure.DI.Implementation;
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
using Areas.SignStatFiles.Models;
using BarsWeb.Areas.SignStatFiles.Models;
using BarsWeb.Core.Logger;
using System.Text;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Net.Http.Headers;

namespace BarsWeb.Areas.SignStatFiles.Controllers.Api
{
    [AuthorizeApi]
    public class SignFilesController : ApiController
    {
        readonly ISignStatFilesRepository _repo;
        private readonly IDbLogger _logger;
        public SignFilesController(ISignStatFilesRepository repo, IDbLogger logger) { _repo = repo; _logger = logger; }

        private string ExeptionProcessing(Exception ex)
        {
            string txt = "";
            var ErrorText = ex.Message.ToString();

            byte[] strBytes = Encoding.UTF8.GetBytes(ErrorText);
            ErrorText = Encoding.UTF8.GetString(strBytes);

            var x = ErrorText.IndexOf("ORA");
            if (x == -1) return ErrorText;

            var ora = ErrorText.Substring(x + 4, 5); //-20001

            if (x < 0)
                return ErrorText;

            decimal oraErrNumber;
            if (!decimal.TryParse(ora, out oraErrNumber))
                return ErrorText;

            if (oraErrNumber >= 20000)
            {
                var ora1 = ErrorText.Substring(x + 11);
                var y = ora1.IndexOf("ORA");
                if (x > -1 && y > 0)
                {
                    txt = ErrorText.Substring(x + 11, y - 1);
                }
                else
                {
                    txt = ErrorText;
                }

                string tmpResult = txt.Replace('ы', 'і');
                return tmpResult;
            }
            else
                return ErrorText;
        }
        private HttpResponseMessage Error(Exception ex)
        {
            _logger.Error(ex.Message + ex.StackTrace, "SignStatFiles");
            return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex));
        }

        [HttpPost]
        public HttpResponseMessage SearchAllFiles([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                KendoDataSource<StatFile> ds = _repo.GetAllFiles(request);
                return Request.CreateResponse(HttpStatusCode.OK, ds);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage SearchFileDetails(long fileId)
        {
            try
            {
                KendoDataSource<FileWorkflow> ds = _repo.GetFileDetails(fileId);
                return Request.CreateResponse(HttpStatusCode.OK, ds);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage GetAllowedExtensions()
        {
            try
            {
                IList<string> data = _repo.GetAllowedExtensions();
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage GetCurrentUserSubjectSN()
        {
            try
            {
                string key = _repo.GetCurrentUserSubjectSN();
                return Request.CreateResponse(HttpStatusCode.OK, key);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage GetFileHash(long storageId, bool isCAdES)
        {
            try
            {
                string res = string.Empty;
                if (isCAdES)
                    res = _repo.GetFileHashForCAdES(storageId);
                else
                    res = _repo.GetFileHash(storageId);

                if (string.IsNullOrWhiteSpace(res)) throw new Exception("Empty File hash.");

                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpPost]
        public HttpResponseMessage SetFileOperation(FileOperation data)
        {
            try
            {
                _repo.SetFileOperation(data);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage GetFilesForDownload(string fileTypes)
        {
            try
            {
                List<string> fTypes = JsonConvert.DeserializeObject<List<string>>(fileTypes);
                List<FileListRow> data = _repo.GetFilesList(fTypes);

                return Request.CreateResponse(HttpStatusCode.OK, new KendoDataSource<FileListRow>
                {
                    Data = data,
                    Total = data.Count
                });
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage UploadFileToDb(string path)
        {
            try
            {
                decimal a = _repo.UploadFileToDb(path);

                return Request.CreateResponse(HttpStatusCode.OK, a);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage DownloadResultFile(long fileId, string fileName)
        {
            try
            {
                byte[] fileContent = _repo.GetLastSignature(fileId);

                HttpResponseMessage result = new HttpResponseMessage(HttpStatusCode.OK);
                result.Content = new ByteArrayContent(fileContent);
                result.Content.Headers.ContentDisposition =
                new ContentDispositionHeaderValue("attachment")
                {
                    FileName = fileName + ".p7s"
                };
                result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");

                return result;
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage UploadResultFile(long fileId, string fileName)
        {
            try
            {
                _repo.UploadFileToResDir(fileName, fileId);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage SetFileDetailsId(long fileId)
        {
            try
            {
                _repo.SetFileDetailsId(fileId);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex) { return Error(ex); }
        }
    }
}
