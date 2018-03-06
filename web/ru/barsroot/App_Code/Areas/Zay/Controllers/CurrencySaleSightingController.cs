using System;
using System.IO;
using System.Web.Mvc;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Zay.Controllers
{
    /// <summary>
    /// Zay22. Візування заявок продажу валюти
    /// </summary>
    
    //[CheckAccessPage]
    //[Authorize]
    public class CurrencySaleSightingController : ApplicationController
    {
        private readonly ICurrencySightRepository _repo;
        public CurrencySaleSightingController(ICurrencySightRepository repo)
        {
            _repo = repo;
        }

        public ActionResult Index()
        {
            ViewBag.nReserve = _repo.IsReserved();
            ViewBag.nCovered = _repo.CoveredValue();
            return View();
        }

        public ActionResult ExportDoc(decimal id)
        {
            const string saleTemplateName = "zay_sal.frx";

            string templatePath = FrxDoc.GetTemplatePathByFileName(saleTemplateName);
            FrxParameters pars = new FrxParameters
            {
                new FrxParameter("ZAY_ID", TypeCode.Decimal, id)
            };
            FrxDoc doc = new FrxDoc(templatePath, pars, null);
            using (var str = new MemoryStream())
            {
                var name = "zay_{0}_sal.doc";
                doc.ExportToMemoryStream(FrxExportTypes.Word2007, str);
                return File(str.ToArray(), "application/msword", string.Format(name, id));
            }
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
    }
}