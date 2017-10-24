using System;
using System.Linq;
using BarsWeb.Models;
using BarsWeb.Controllers;
using System.Web.Mvc;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.UI;
using Areas.Admin.Models;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.Admin.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class BaxController : ApplicationController
    {
        private readonly IADMURepository _admRepo;
        private readonly IBaxRepository _baxRepo;

        public BaxController(IADMURepository admRepo, IBaxRepository baxRepo)
        {
            _admRepo = admRepo;
            _baxRepo = baxRepo;
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAllUsers([DataSourceRequest] DataSourceRequest request, string parameter)
        {
            try
            {
                IQueryable<V_STAFF_USER_ADM> data = _admRepo.GetADMUList(parameter);
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new {Error = ex.Message});
            }
        }

        public ActionResult PostUserIncome(decimal userId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _baxRepo.BaxUserIncome(userId);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}

