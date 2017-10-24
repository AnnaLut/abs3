using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using Areas.AdmSecurity.Models;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.AdmSecurity.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class ConfirmController : ApplicationController
    {
        private readonly ISecurityConfirmRepository _repo;
        public ConfirmController(ISecurityConfirmRepository repo)
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
    }
}