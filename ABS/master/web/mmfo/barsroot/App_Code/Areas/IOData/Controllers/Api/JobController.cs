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
    public class JobController : ApiController
    {
        private readonly IIODataRepository _repository;
        public JobController(IIODataRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage GetJobs(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repository.ActiveJobs();
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
        public HttpResponseMessage Post(Job item)
        {
            try
            {
                var data = _repository.CheckJob(item);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Message = "Checked success." });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }

        [HttpPut]
        public HttpResponseMessage Put(Job item)
        {
            try
            {
                _repository.UpdateJob(item);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = "Завдання на вивантаження даних створено успішно" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
        [HttpPost]
        public HttpResponseMessage Delete(Job item)
        {
            try
            {
                _repository.RemoveJob(item);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = "Інформацію про статус було виладено. Можливий повторний запуск вивантаження." });
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