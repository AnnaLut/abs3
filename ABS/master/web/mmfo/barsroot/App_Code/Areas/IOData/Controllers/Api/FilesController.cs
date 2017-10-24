using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.IOData.Infrastructure.DI.Abstract;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.IOData.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.IOData.Controllers.Api
{
    [AuthorizeApi]
    public class FilesController : ApiController
    {
        private readonly IIODataRepository _repository;
        public FilesController(IIODataRepository repository)
        {
            _repository = repository;
        }
        [HttpGet]
        public HttpResponseMessage GetFiles(string jobName)
        {
            try
            {
                var data = _repository.Files(jobName);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Message = "Processing success." });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
        [HttpPost]
        public HttpResponseMessage Upload(UploadRequestModel data)
        {
            try
            {
                _repository.UploadOneFile(data);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = "Вивантаження виконано успішно" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
    }
}