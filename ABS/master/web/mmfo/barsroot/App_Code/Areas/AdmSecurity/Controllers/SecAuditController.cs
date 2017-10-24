using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using BarsWeb.Models;

namespace BarsWeb.Areas.AdmSecurity.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class SecAuditController : ApplicationController
    {
        private readonly ISecAuditRepository _repo;
        public SecAuditController(ISecAuditRepository repo)
        {
            _repo = repo;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAuditData([DataSourceRequest] DataSourceRequest request, string startDate, string endDate)
        {
            try
            {
                if (_repo.SeedSecAuditTable(startDate, endDate))
                {
                    var data = _repo.GetGridData().ToList();
                    return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var result = new JsonResponse(JsonResponseStatus.Ok);
                    result.message = "Виникли помилки при спробі сформувати журнал аудиту.";
                    return Json(result, JsonRequestBehavior.AllowGet); 
                }
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
                Errors = new { message = ex.Message }
            }, 
            JsonRequestBehavior.AllowGet);
        }
    }
}