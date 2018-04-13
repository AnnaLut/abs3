using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Async.Models;
using BarsWeb.Areas.Async.Models.Binders;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Async.Controllers.Api
{
    /// <summary>
    /// Async Schedulers API
    /// </summary>
    [AuthorizeApi]
    public class TasksController : ApiController
    {
        private readonly ITasksRepository _taskRepository;
        public TasksController(ITasksRepository taskRepository)
        {
            _taskRepository = taskRepository;
        }

        public DataSourceResult Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            var tasks = _taskRepository.GetAllTasks().Where(i => i.State == "RUNNING");
            return tasks.ToDataSourceResult(request);
        }
        public HttpResponseMessage Get(int id)
        {
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        public HttpResponseMessage Post(string schedulerCode, [System.Web.Mvc.ModelBinder(typeof(TaskParameterModelBinder))] List<TaskParameter> parameters)
        {
            if (parameters == null)
            {
                throw new NotImplementedException();
            }
            string code = _taskRepository.StartTask(schedulerCode, parameters);

            var result = new TaskParamViewModel
            {
                SchedelerCode = schedulerCode,
                Parameters = parameters
            };
            return Request.CreateResponse(HttpStatusCode.OK, result );
        }
        public HttpResponseMessage Put()
        {
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        public HttpResponseMessage Delete(int id)
        {
            var tasks = _taskRepository.GetAllTasks().FirstOrDefault(i => i.Id == id);
            if (tasks != null)
            {
                _taskRepository.DropTask(tasks.JobName);                
            }
            return Request.CreateResponse(HttpStatusCode.OK, new { Message = "" });
        }
    }
}