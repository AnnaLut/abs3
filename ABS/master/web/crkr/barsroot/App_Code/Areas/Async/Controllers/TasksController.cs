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
        private readonly ISchedulersRepository _schedulersRepository;
        public TasksController(ITasksRepository tasksRepo, ISchedulersRepository schedulersRepository)
        {
            _tasksRepo = tasksRepo;
            _schedulersRepository = schedulersRepository;
        }

        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Start(string schedulerCode)
        {
            var scheduler = _schedulersRepository.GetByCode(schedulerCode);
            var result = new TaskParamViewModel
            {
                SchedelerCode = schedulerCode,
                Name = scheduler.Name,
                Description = scheduler.Description,
                Parameters = scheduler.ParametersList
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
            string code = _tasksRepo.StartTask(schedulerCode, parameters);

            var scheduler = _schedulersRepository.GetByCode(schedulerCode);
            ViewBag.Code = code;

            var result = new TaskParamViewModel
            {
                SchedelerCode = schedulerCode,
                Name = scheduler.Name,
                Description = scheduler.Description,
                Parameters = scheduler.ParametersList
            };

            return View(result);
        }
    }
}
