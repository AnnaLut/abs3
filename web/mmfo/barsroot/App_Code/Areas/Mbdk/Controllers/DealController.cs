using System.Web.Mvc;
using BarsWeb.Areas.Mbdk.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using System.IO;
using System;

namespace BarsWeb.Areas.Mbdk.Controllers
{
    public class DealController : ApplicationController
    {
        private readonly IDealRepository _deal;
        public DealController(IDealRepository deal)
        {
            _deal = deal;
        }

        /// <summary>
        /// Повертає форму введення угоди, якщо параметр відсутній, 
        /// в іншому разі повертає форму зі збереженою угодою
        /// </summary>
        /// <param name="id">Номер договору угоди</param>
        /// <returns></returns>
        public ActionResult Index(string id)
        {
            ViewBag.ID = id;
            if (!string.IsNullOrEmpty(id))
            {
                var mdoel = _deal.ReadReal(id);
                ViewBag.Model = mdoel;
                return View(mdoel);
            }
            return View();
        }

        public ActionResult MbdkWrite(string id)
        {
            return View();
        }

        public ActionResult TransactionParams()
        {
            return View();
        }
        public ActionResult MbdkModal(int id, string date, decimal sum, string text_reason)
        {
            ViewBag.ID = id;
            ViewBag.date = date;
            ViewBag.sum = sum;
            ViewBag.reason = text_reason;
            return View();
        }
        public FileResult ExportDoc(decimal ND)
        {

            const string mbdkTemplateName = "mbdk_tic.frx";

            string templatePath = FrxDoc.GetTemplatePathByFileName(mbdkTemplateName);
            FrxParameters pars = new FrxParameters
            {
                new FrxParameter("ND", TypeCode.Int64, ND)
            };
            FrxDoc doc = new FrxDoc(templatePath, pars, null);
            using (var str = new MemoryStream())
            {
                
                var name = "mbdk_{0}.pdf";
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
                Response.ClearHeaders();
                Response.AddHeader("Content-Disposition", "inline; filename=" + string.Format(name, ND));
                Response.AddHeader("Content-Type", "application/pdf; filename=" + string.Format(name, ND));
                return File(str.ToArray(), "application/pdf");
            }
        }

    }
}