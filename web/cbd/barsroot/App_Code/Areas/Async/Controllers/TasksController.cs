using System;
using System.Collections.Generic;
using System.Web.Mvc;
using BarsWeb.Areas.Async.Models.Binders;
using BarsWeb.Controllers;
using BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Async.Models;

namespace BarsWeb.Areas.Async.Controllers
{
    /// <summary>
    /// Списки тасків
    /// </summary>
    [AuthorizeUser]
    public class TasksController : ApplicationController
    {
        readonly ITasksRepository _tasksRepo;
        public TasksController(ITasksRepository tasksRepo)
        {
            _tasksRepo = tasksRepo;
        }

        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Start(string schedulerCode)
        {
            
            var result = new TaskParamViewModel
            {
                SchedelerCode = schedulerCode,
                Parameters = _tasksRepo.GetSсhedulerParameters(schedulerCode)
            };

            foreach (var item in result.Parameters)
            {
                var temp = Request.Params.Get(item.Name);
                if (!string.IsNullOrEmpty(temp))
                {
                    item.Value = temp;
                }
            }

            return View(result);
            
        }
        [HttpPost]
        public ActionResult Start(string schedulerCode, /*[ModelBinder(typeof(TaskParameterModelBinder))]*/ List<TaskParameter> parameters)
        {
            if (parameters == null)
            {
                throw new NotImplementedException();
            }
            string code = _tasksRepo.StartTask(schedulerCode, parameters);

            ViewBag.Code = code;

            var result = new TaskParamViewModel
            {
                SchedelerCode = schedulerCode, Parameters = parameters
            };

            return View(result);
        }
    }
}
