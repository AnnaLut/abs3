using AttributeRouting.Web.Http;
using BarsWeb.Areas.Dpa.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Dpa.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Runtime.InteropServices;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Dpa.Controllers.Api
{
    public class RegisterCountsDpaApiController : ApiController
    {
        private readonly IRegisterCountsDPARepository _repository;

        public RegisterCountsDpaApiController(IRegisterCountsDPARepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage GetDataForFileReport([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string date, string fileType)
        {
            if (date != null)
            {
                if (fileType == "CA")
                {
                    var fileList = _repository.GetFileReport<CAFile>(date, fileType);
                    return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
                }
                else if (fileType == "CV")
                {
                    var fileList = _repository.GetFileReport<CVFile>(date, fileType);
                    return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
                }
                else if (fileType == "F")
                {
                    var fileList = _repository.GetFileReport<FFile>(date, fileType);
                    return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
                }
                else if (fileType == "K")
                {
                    var fileList = _repository.GetFileReport<KFile>(date, fileType);
                    return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
                }
                else
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Запит у процесі обробки");
            }
            else
                return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        public HttpResponseMessage UploadGrid([FromBody] dynamic request)
        {
            FileResponse file = new FileResponse();

            string fileType = request.fileType;
            string date = request.date;

            try
            {
                object model = _repository.UploadGrid(request.grid, fileType, date);
                return Request.CreateResponse(HttpStatusCode.OK, model);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }

        }

        [HttpPost]
        public HttpResponseMessage DeleteRow([FromBody] dynamic request)
        {
            FileResponse file = new FileResponse();

            string fileType = request.fileType;

            _repository.DeleteRows(request.rows, fileType);
            return Request.CreateResponse(HttpStatusCode.OK);

        }

        [HttpPost]
        public HttpResponseMessage InsertTicket([FromBody] dynamic request)
        {
            string fileName = request.file.fileName;
            string fileBody = request.file.fileBody;
            string path = request.file.path;

            _repository.InsertTicket(path, "F", fileName, fileBody);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpGet]
        public HttpResponseMessage GetAllFiles(string fileType)
        {
            if (fileType != "")
            {
                var filesList = _repository.GetAllFiles(fileType);
                return Request.CreateResponse(HttpStatusCode.OK, filesList);
            }
            else
                return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpGet]
        public HttpResponseMessage GetCodesF2(string fileName)
        {
            var codesList = _repository.GetCodesF2(fileName);
            return Request.CreateResponse(HttpStatusCode.OK, codesList);
        }

        [HttpGet]
        public HttpResponseMessage ProcessFilesDPA(string fileName, string source_path)
        {
            try
            {
                var errorcode = _repository.ProcessFilesDPA(fileName, source_path);
                return Request.CreateResponse(HttpStatusCode.OK, errorcode);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetF2Archive()
        {
            var list = _repository.GetF2Archive();
            return Request.CreateResponse(HttpStatusCode.OK, list);
        }

        [HttpGet]
        public HttpResponseMessage GetK2Archive()
        {
            var list = _repository.GetK2Archive();
            return Request.CreateResponse(HttpStatusCode.OK, list);
        }

        [HttpGet]
        public HttpResponseMessage GetR0Archive()
        {
            var list = _repository.GetR0Archive();
            return Request.CreateResponse(HttpStatusCode.OK, list);
        }


        [HttpGet]
        public HttpResponseMessage GetF2Grid([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string fileName)
        {
            var list = _repository.GetF2Grid(fileName);
            return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
        }

        [HttpGet]
        public HttpResponseMessage GetK2Grid([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string fileName)
        {
            var list = _repository.GetK2Grid(fileName);
            return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
        }

        [HttpGet]
        public HttpResponseMessage GetR0Grid([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string fileName)
        {
            var list = _repository.GetR0Grid(fileName);
            return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
        }

        [HttpGet]
        public HttpResponseMessage DeleteFile(string fileName, string source_path)
        {
            _repository.DeleteFile(fileName, source_path);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpGet]
        public HttpResponseMessage GetFormedFilesF0Grid([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string file_type)
        {
            try
            { 
                var list = _repository.GetFormedFilesF0Grid<F0Arc>(file_type);
                return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetF0Grid([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string fileName)
        {
            if (Path.GetFileName(fileName).Contains("@F"))
            {
                var list = _repository.GetF0Grid<F0Grid>(fileName);
                return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
            }
            else if (Path.GetFileName(fileName).Contains("@K"))
            {
                var list = _repository.GetF0Grid<K0Grid>(fileName);
                return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
            }
            else
                return Request.CreateResponse(HttpStatusCode.BadRequest);
        }

        [HttpPost]
        public HttpResponseMessage InsertR0Ticket([FromBody] dynamic request)
        {
            string fileName = request.file.fileName;
            string fileBody = request.file.fileBody;
            string path = request.file.path;

            try
            {
                _repository.InsertTicket(path, "R0", fileName, fileBody);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }

        }

        [HttpPost]
        public HttpResponseMessage PrintF0Files([FromBody] dynamic request)
        {
            string fileName = request.fileName;
            List<F0Grid> gridList = request.grid.ToObject<List<F0Grid>>();
            _repository.FormF0Files(fileName, gridList);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpGet]
        public HttpResponseMessage GetPrintHeader([FromBody] dynamic request)
        {
            PrintHeader list = new PrintHeader();
            list = _repository.GetPrintHeader();
            return Request.CreateResponse(HttpStatusCode.OK, list);
        }

        [HttpGet]
        public HttpResponseMessage GetBranch()
        {
            string branch = _repository.GetBranch();
            return Request.CreateResponse(HttpStatusCode.OK, branch);
        }

        [HttpGet]
        public HttpResponseMessage GetBankDate()
        {
            DateTime bdate = _repository.GetBankDate();
            return Request.CreateResponse(HttpStatusCode.OK, bdate);
        }

        [HttpGet]
        public HttpResponseMessage GetKVs()
        {
            List<KVModel> list = _repository.GetKVs();
            return Request.CreateResponse(HttpStatusCode.OK, list);
        }

        [HttpGet]
        public HttpResponseMessage GetCountries()
        {
            List<KVModel> list = _repository.GetCountries();
            return Request.CreateResponse(HttpStatusCode.OK, list);
        }
    }
}