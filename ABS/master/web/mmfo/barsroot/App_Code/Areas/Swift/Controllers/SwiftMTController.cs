using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Swift.Infrastructure.DI.Implementation;
using System.Linq;
using BarsWeb.Models;

namespace BarsWeb.Areas.Swift.Controllers
{
    [AuthorizeUser]
    public class SwiftMTController : ApplicationController
    {

        readonly ISwiftRepository _repo;
        public SwiftMTController(ISwiftRepository repo)
        {
            _repo = repo;
        }

        public ActionResult Index(bool IsRejectView)
        {
            ViewBag.IsRejectView = IsRejectView;
            return View();
        }

        public ActionResult GetSWREF(string UETR)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                BarsSql sql = SqlCreatorMT.GetSWREFValue(UETR);
                var code = _repo.ExecuteStoreQuery<double?>(sql).FirstOrDefault();
                result.data = (code == null) ? code : code.Value;
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SendReject(string UETR)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                BarsSql sql = SqlCreatorMT.GenerateReject(UETR);
                var retValue = _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SendGenerateACSC(string UETR)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                BarsSql sql = SqlCreatorMT.GenerateACSC(UETR);
                var retValue = _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}
