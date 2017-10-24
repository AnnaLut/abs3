using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.DownloadXsdScheme.Infrastructure.DI.Abstract;
using BarsWeb.Areas.DownloadXsdScheme.Infrastructure.DI.Implementation;
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
using Areas.DownloadXsdScheme.Models;
using BarsWeb.Core.Logger;

namespace BarsWeb.Areas.DownloadXsdScheme.Controllers.Api
{
    public class DownloadXsdSchemeController : ApiController
    {
        readonly IDownloadXsdSchemeRepository _repo;
        private readonly IDbLogger _logger;
        public DownloadXsdSchemeController(IDownloadXsdSchemeRepository repo, IDbLogger logger)
        {
            _logger = logger;
            _repo = repo;
        }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMain();
                var data = _repo.SearchGlobal<XsdSchemee>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage UploadFile(FileUploadModel model)
        {
            try
            {
                if (model.SelectedFileName.ToLower() != model.DesiredFileName.ToLower())
                    _logger.Info("При завантаженні схеми XSD у АБС по файлам стат.звітності(FileId=" + model.FileId + ") користувач обрав файл "
                        + model.SelectedFileName + " хоча налаштований шаблон файлу : " + model.DesiredFileName);

                _repo.UploadFileFromPathIE(model);

                return Request.CreateResponse(HttpStatusCode.OK, new ResponseXSD());
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseXSD() { Result = "ERROR", ErrorMsg = ex.Message });
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

                    if (httpPostedFile == null) return Request.CreateResponse(HttpStatusCode.OK, new ResponseXSD() { Result = "ERROR", ErrorMsg = "No file found." });

                    byte[] fileData = null;
                    using (var binaryReader = new BinaryReader(httpPostedFile.InputStream))
                    {
                        fileData = binaryReader.ReadBytes(httpPostedFile.ContentLength);
                    }
                    var Date = httpRequest.Form["Date"];
                    var fileId = httpRequest.Form["fileId"];
                    var selectedFileName = httpRequest.Form["selectedFileName"];
                    var desiderFileName = httpRequest.Form["desiderFileName"];

                    if (selectedFileName.ToLower() != desiderFileName)
                        _logger.Info("При завантаженні схеми XSD у АБС по файлам стат.звітності(FileId=" + fileId + ") користувач обрав файл "
                            + selectedFileName + " хоча налаштований шаблон файлу : " + desiderFileName);


                    _repo.UploadFileFromBytes(new FileUploadModel() { FileId = Convert.ToInt32(fileId), SelectedFileName = selectedFileName, DesiredFileName = desiderFileName, Date = Date }, fileData);

                    return Request.CreateResponse(HttpStatusCode.OK, new ResponseXSD());
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK, new ResponseXSD() { Result = "ERROR", ErrorMsg = "No file found." });
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ResponseXSD() { Result = "ERROR", ErrorMsg = ex.Message });
            }
        }

        [HttpPost]
        public HttpResponseMessage UploadToTempDir()
        {
            var httpRequest = HttpContext.Current.Request;
            var Data = httpRequest.Form;

            HttpPostedFile file = HttpContext.Current.Request.Files[0];

            if (file != null && file.ContentLength > 0)
            {
                string TempDir = Path.GetTempPath() + "BankFile\\";
                DirectoryInfo TmpDitInf = new DirectoryInfo(TempDir);
                //-- если дериктории нету, то создаем ее
                if (!TmpDitInf.Exists)
                    TmpDitInf.Create();
                else
                {
                    Directory.Delete(TempDir, true);
                    TmpDitInf.Create();
                }
                string posFileName = file.FileName;
                string TempFile = posFileName.Substring(posFileName.LastIndexOf("\\") + 1);
                string TempPath = TempDir + TempFile;

                file.SaveAs(TempPath);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            else
                return Request.CreateResponse(HttpStatusCode.BadRequest, "Некоректний файл.");
        }
    }
}
