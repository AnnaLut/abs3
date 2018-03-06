using System;
using System.IO;
using System.Linq;
using BarsWeb.Controllers;
using System.Web.Mvc;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;
using Kendo.Mvc.UI;
using BarsWeb.Models;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.Zay.Controllers
{
    /// <summary>
    /// Zay21. Візування заявок покупки валюти
    /// </summary>
    
    //[CheckAccessPage]
    [Authorize]
    public class CurrencyBuySightingController : ApplicationController
    {
        private readonly ICurrencySightRepository _repo;
        public CurrencyBuySightingController(ICurrencySightRepository repo)
        {
            _repo = repo;
        }

        public ActionResult Index(CurrencyMode mode)
        {
            ViewBag.nReserve = _repo.IsReserved();
            ViewBag.nCovered = _repo.CoveredValue();
            return View(mode);
        }
        public ActionResult ClobCorp(decimal id)
        {
            try
            {
                var fileData = _repo.GetFileCorpData(id);
                var result = new FileContentResult(fileData, "text/plain");
                result.FileDownloadName = "Z_" + id + "000000.doc";
                return result;
            }
            catch (Exception ex)
            {
                var errText = "Обраний файл не містить інформації.";
                return Json(errText, JsonRequestBehavior.AllowGet);
                // what about partialView ???
            }
        }

        public ActionResult ExportDoc(decimal id)
        {
            const string buyTemplateName = "zay_buy.frx";

            string templatePath = FrxDoc.GetTemplatePathByFileName(buyTemplateName);
            FrxParameters pars = new FrxParameters
            {
                new FrxParameter("ZAY_ID", TypeCode.Decimal, id)
            };
            FrxDoc doc = new FrxDoc(templatePath, pars, null);
            using (var str = new MemoryStream())
            {
                var name = "zay_{0}_buy.doc";
                doc.ExportToMemoryStream(FrxExportTypes.Word2007, str);
                return File(str.ToArray(), "application/msword", string.Format(name, id));
            }
        }

        public ActionResult ExportDoc1(decimal rf)
        {
            const string payTemplateName = "payment_message.frx";

            string templatePath = FrxDoc.GetTemplatePathByFileName(payTemplateName);
            FrxParameters pars = new FrxParameters
            {
                new FrxParameter("p_ref", TypeCode.Decimal, rf)
            };
            FrxDoc doc = new FrxDoc(templatePath, pars, null);
            using (var str = new MemoryStream())
            {
                var name = "payment_{0}_message.doc";
                doc.ExportToMemoryStream(FrxExportTypes.Word2007, str);
                return File(str.ToArray(), "application/msword", string.Format(name, rf));
            }
        }
    }
}