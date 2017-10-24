using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Areas.Admin.Models.Confirm;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Mvc;
using Areas.Admin.Models;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.Admin.Controllers
{
    //[CheckAccessPage]
    //[Authorize]
    public class ConfirmController : ApplicationController
    {
        private readonly IConfirmRepository _repo;
        public ConfirmController(IConfirmRepository repo)
        {
            _repo = repo;
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetConfirmTabs([DataSourceRequest] DataSourceRequest request)
        {
            try
            {
                IQueryable<V_APPROVABLE_RESOURCE_GROUP> data = _repo.ResourceConfirmTabsData();
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult GetConfirmResources([DataSourceRequest] DataSourceRequest request, string type)
        {
            var typeId = Decimal.Parse(type);
            try
            {
                IQueryable<V_APPROVABLE_RESOURCE> data = _repo.ResourceConfirmData();
                var dataList = data.Where(x => x.GRANTEE_TYPE_ID == typeId).ToList();

                return Json(dataList.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        private JsonResult DataSourceErrorResult(Exception ex)
        {
            return Json(new DataSourceResult
            {
                Errors = new
                {
                    message = ex.ToString()
                }
            }, JsonRequestBehavior.AllowGet);
        }
        /*
        public ActionResult GetUserConfirmGrid([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_USER_RESOURCES_CONFIRM> data = _repo.GetUserConfirmData(request);
            var total = _repo.CountUserConfirmData(request);
            return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAppConfirmGrid([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_APP_RESOURCES_CONFIRM> data = _repo.GetAppConfirmData(request);
            var total = _repo.CountAppConfirmData(request);
            return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UserApproveCommand(string userId, string resId, string obj)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.ConfirmUserApproving(userId, resId, obj);
                result.message = "Ресурс успішно додано!";
            }
            catch (Exception ex)
            {
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UserRevokeCommand(string userId, string resId, string obj)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.ConfirmUserRevoking(userId, resId, obj);
                result.message = "Ресурс успішно видалено!";
            }
            catch (Exception ex)
            {
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppApproveCommand(string id, string codeapp, string obj)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.ConfirmAppApproving(id, codeapp, obj);
                result.message = "Ресурс успішно додано!";
            }
            catch (Exception ex)
            {
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppRevokeCommand(string id, string codeapp, string obj)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.ConfirmAppRevoking(id, codeapp, obj);
                result.message = "Ресурс успішно видалено!";
            }
            catch (Exception ex)
            {
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        */
        // new functions:

        public ActionResult Editor()
        {
            return View();
        }

        public ActionResult EditorGrid([DataSourceRequest] DataSourceRequest request)
        {
            try
            {
                var data = new List<EditorData>
                {
                    new EditorData() { Id = 1, Name = "FirstTestItem", Type = "text", Value = "Test value of 1st Item"},
                    new EditorData() { Id = 2, Name = "SecondTestItem", Type = "number", Value = "1234567890" },
                    new EditorData() { Id = 3, Name = "ThirdTestItem", Type = "date", Value = "18/12/1986"},
                    new EditorData() { Id = 4, Name = "FourthTestItem", Type = "dropdown", Value = "Ford"},
                    new EditorData() { Id = 5, Name = "FifthTestItem", Type = "grid", Value = ""}
                };
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new DataSourceResult
                {
                    Errors = new
                    {
                        message = ex.Message
                    }
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }

    public class EditorData
    {
        public decimal Id { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Value { get; set; }
    }
}
