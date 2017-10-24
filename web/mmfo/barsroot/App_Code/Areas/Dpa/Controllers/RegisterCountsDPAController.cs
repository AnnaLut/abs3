using BarsWeb.Areas.Dpa.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Dpa.Models;
using BarsWeb.Controllers;
using ICSharpCode.SharpZipLib.Zip;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Mvc;

namespace BarsWeb.Areas.Dpa.Controllers
{
    public class RegisterCountsDpaController : ApplicationController
    {
        private readonly IRegisterCountsDPARepository _repository;
        private RepositoryHelper _helper;

        public RegisterCountsDpaController(IRegisterCountsDPARepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult SaveFile(string fileName, string entereddate, string save_type)
        {
            string templateName = "";
            string app_type = "";
            string file_type = "";

            if (fileName == "@F")
            {
                templateName = "FReport.frx";
            }
            else if (fileName == "CA")
            {
                templateName = "CAReport.frx";
            }
            else if (fileName == "CV")
            {
                templateName = "CVReport.frx";
            }
            else if (fileName.Contains("@F2"))
            {
                templateName = "F2Report.frx";
            }
            else if (fileName.Contains("@F0"))
            {
                templateName = "F0Report.frx";
            }
            else if (fileName.Contains("@R0"))
            {
                templateName = "R0Report.frx";
            }

            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
            FrxParameters pars = new FrxParameters()
            {
                new FrxParameter("entereddate", TypeCode.String, entereddate),
                new FrxParameter("fileName", TypeCode.String, fileName)
            };
            FrxDoc doc = new FrxDoc(templatePath, pars, null);

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
                return File(str.ToArray(), app_type, string.Format("report_{0}" + file_type, fileName));
            }
        }
    }
}
