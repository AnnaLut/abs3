using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.IOData.Infrastructure.DI.Abstract;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.IOData.Models;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json.Linq;

namespace BarsWeb.Areas.IOData.Controllers.Api
{
    [AuthorizeApi]
    public class StatisticController : ApiController
    {
        private readonly IStatisticRepozitory _repository;
        public StatisticController(IStatisticRepozitory repository)
        {
            _repository = repository;
        }


        [HttpGet]
        public HttpResponseMessage GetJobs(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repository.ShedulerJobs();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Message = "Processing success." });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    exception.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetLogRecords(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repository.JobLogRecords();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Message = "Processing success." });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    exception.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage ChangeJobState(string JobName, string JobEnabled)
        {
            try
            {
                _repository.ChangeJobState(JobName, JobEnabled);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = JobName + JobEnabled });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    exception.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetEnabledjobs([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repository.EnabledJobs();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Message = "Processing success." });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    exception.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage RecreateJob(string JobName)
        {
            try
            {
                _repository.RecreateJob(JobName);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = "Перестворення завдання пройшло успішно" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    exception.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetJobParams(string JobName)
        {
            try
            {
                var data = _repository.JobParams(JobName);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Message = "Processing success." });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    exception.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetAvailableJobParams(string JobName)
        {
            try
            {
                var data = _repository.AvailableJobParams(JobName);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Message = "Processing success." });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    exception.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage UpdateJobParams([FromBody] JObject updatingParams)
        {
            try
            {
                var jobName = updatingParams["jobName"].ToObject<string>();
                var jobParams = updatingParams["jobParams"].Select(jToken => jToken.ToObject<JobParameter>());
                _repository.UpdateJobParams(jobName, jobParams);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = "Processing success." });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    exception.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage DeleteJobParams([FromBody] JObject deletingParams)
        {
            try
            {
                var jobName = deletingParams["jobName"].ToObject<string>();
                var jobParams = deletingParams["jobParams"].Select(jToken => jToken.ToObject<JobParameter>());
                _repository.DeleteJobParams(jobName, jobParams);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = "Processing success." });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    exception.Message);
            }
        }
        [HttpPost]
        public HttpResponseMessage InsertJobParams([FromBody] JObject insertingParams)
        {
            try
            {
                var jobName = insertingParams["jobName"].ToObject<string>();
                var jobParams = insertingParams["jobParams"].Select(jToken => jToken.ToObject<JobParameter>());
                _repository.InsertJobParams(jobName, jobParams);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = "Processing success." });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    exception.Message);
            }
        }
    }
}