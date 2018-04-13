using System;
using System.Web.Mvc;
using BarsWeb.Areas.Arcs.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Arcs.Controllers
{ 
    [AuthorizeUser]
    //[CheckAccessPage]
    public class ArchivesController : ApplicationController
    {
        private readonly IArchivesRepository _repository;
        public ArchivesController(IArchivesRepository repository)
        {
            _repository = repository;
        }
        /// <summary>
        /// перегляд стану архівації
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult GetTableStateData([DataSourceRequest] DataSourceRequest request)
        {
            var accounts = _repository.GetTableState();
            return Json(accounts.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// детальна інформація по таблиці 
        /// </summary>
        /// <param name="id">ім"я таблиці</param>
        /// <returns></returns>
        public ActionResult DetailOnTable(string id)
        {
            return View(model: id); 
        }
        /// <summary>
        /// дані для наповнення детальної інформації
        /// </summary>
        /// <param name="request">параетри запиту</param>
        /// <param name="id"></param>
        /// <returns></returns>
        public JsonResult DetailOnTableData([DataSourceRequest] DataSourceRequest request,string id)
        {
            var detail = _repository.GetDeatilOnTable(id);
            return Json(detail.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public JsonResult MakeArcTable(string tableName, int year)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok,"Процедуру винесення розпочато");
            try
            {
                _repository.RemoveYear(tableName, year, true);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        public JsonResult DisableFile(string tableName, int year)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok, "Файли відключено");
            try
            {
                _repository.TakeArcdataOffline(tableName, year);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        public JsonResult RestoreData(string tableName, int year)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok, "Процедуру відновлення розпочато");
            try
            {
                _repository.RestoreYear(tableName, year, true);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
    }
}