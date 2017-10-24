using Bars.Classes;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Dapper;
using Kendo.Mvc.UI;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace BarsWeb.Areas.Sep.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class SepTZController : ApplicationController
    {
        private readonly ISepTZRepository _repoTZ;
        private readonly IParamsRepository _paramsRepo;
        public SepTZController(ISepTZRepository repoTZ, IParamsRepository paramsRepo)
        {
            _repoTZ = repoTZ;
            _paramsRepo = paramsRepo;
        }
        public ActionResult Index(AccessType accessType)
        {
            ViewBag.SepNum = _paramsRepo.GetParam("SEPNUM").Value;
            ViewBag.BankOKPO = _paramsRepo.GetParam("OKPO").Value;
            ViewBag.BankDate = _paramsRepo.GetParam("BANKDATE").Value;
            ViewBag.S902 = _repoTZ.GetS902().Select(s => s.NLS).SingleOrDefault();
            ViewBag.NMS902 = _repoTZ.GetS902().Select(n => n.NMS).SingleOrDefault();
            ViewBag.BankMFO = _paramsRepo.GetParam("MFO").Value;
            ViewBag.BankNAME = _paramsRepo.GetParam("NAME").Value;

            ViewBag.TitleType = accessType.Mode != null
                ? "Одержанi iнф-нi: Запити на уточ.рекв.по платежах"
                : "СЕП. Розбір картотеки запитів";

            return View(accessType);
        }
        public ActionResult GetSepTZList([DataSourceRequest] DataSourceRequest request, AccessType accessType, string parameters)
        {
            try
            {
                List<SepTZ> tzList = _repoTZ.GetSepTZList(request, accessType, parameters);
                decimal total = _repoTZ.GetSepTZCount(accessType, request, parameters);
                return Json(new { Data = tzList, Total = total }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { Error = e.InnerException == null ? e.Message : e.InnerException.Message}, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult DeleteRow(decimal rowRec)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoTZ.DeleteSepTZRow(rowRec);
                result.message = string.Format("Файл {0} успішно вилучено.", rowRec);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult RowReply(string dRec)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                IQueryable<ARC_RRP> rowReply = _repoTZ.GetRowReply(dRec);
                if (rowReply != null)
                {
                    result.data = rowReply;
                }
                else
                {
                    result.data = null;
                }
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetReport(string mode, DateTime dStart, DateTime dEnd, [DataSourceRequest] DataSourceRequest request)
        {

            IQueryable<ARC_RRP> report = _repoTZ.GetReport(mode, dStart, dEnd);
            decimal total = _repoTZ.GetReportCount(mode, dStart, dEnd, request);
            return Json(new { Data = report, Total = total }, JsonRequestBehavior.AllowGet);

        }
        public ActionResult GetZagA(decimal? rec)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            DateTime datA = new DateTime();
            try
            {
                //datA = DateTime.Parse(arcDate_a);
                //var zag = _repoTZ.GetZagA(arcFn, datA).SingleOrDefault();
                //result.data = zag;

                Sep3720Doc res = null;
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    res = connection.Query<Sep3720Doc>("select t.* from v_sep_docs t where t.rec = :rec", new { rec }).SingleOrDefault();
                }
                result.data = res;
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

