using BarsWeb.Areas.PB1.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using System;
using System.IO;
using System.Web.Mvc;

namespace BarsWeb.Areas.PB1.Controllers
{
    [AuthorizeUser]
    public class PB1Controller: ApplicationController
    {
        public PB1Controller()
        {
        }

        public ActionResult FormingReport()
        {
            return View();
        }

        public ActionResult AddRequisites()
        {
            return View();
        }

        public ActionResult SaveFile(string par, string save_type)
        {
            string templateName = "PB1Report.frx";
            string app_type = "";
            string file_type = "";
            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
            FrxDoc doc = new FrxDoc(templatePath, null, null);

            using (var str = new MemoryStream())
            {
                if (save_type == "excel")
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Excel2007, str);
                    app_type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    file_type = ".xlsx";
                }
                if (save_type == "pdf")
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
                    app_type = "application/pdf";
                    file_type = ".pdf";
                }
                if (save_type == "word")
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Word2007, str);
                    app_type = "application/word";
                    file_type = ".doc";
                }
                if (save_type == "rtf")
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Rtf, str);
                    app_type = "application/rtf";
                    file_type = ".rtf";
                }
                if (save_type == "html")
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Html, str);
                    app_type = "text/html";
                    file_type = ".html";
                }
                if (save_type == "xmlexcel")
                {
                    doc.ExportToMemoryStream(FrxExportTypes.XmlExcel, str);
                    app_type = "application/vnd.ms-excel";
                    file_type = ".xls";
                }
                if (save_type == "text")
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Text, str);
                    app_type = "text/plain";
                    file_type = ".txt";
                }
                return File(str.ToArray(), app_type, "PB1_Report_" + DateTime.Now.ToString(@"ddMMyyy") + file_type);
            }
        }
    }
}