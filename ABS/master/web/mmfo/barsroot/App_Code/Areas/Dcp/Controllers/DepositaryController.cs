using BarsWeb.Areas.Dcp.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Dcp.Models;
using BarsWeb.Controllers;
using System;
using System.IO;
using System.Text;
using System.Web.Mvc;

namespace BarsWeb.Areas.Dcp.Controllers
{
    [AuthorizeUser]
    public class DepositaryController : ApplicationController
    {
        private readonly IDepositaryRepository _repository;

        public DepositaryController(IDepositaryRepository repository)
        {
            _repository = repository;
        }

        public ActionResult AcceptPFiles(decimal? nMode = null, decimal? nPar = null)
        {
            ViewBag.nMode = nMode;
            ViewBag.nPar = nPar;
            return View();
        }

        public ActionResult SaveFile(string par, string save_type)
        {
            string templateName = "";
            string app_type = "";
            string file_type = "";
            if (par == "archive")
                templateName = "DCP_ReportArch.frx";
            else
            {
                templateName = "DCP_Report.frx";
            }
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
                return File(str.ToArray(), app_type, "DCPReport" + file_type);
            }
        }

        public Object CreateFile(string save_type, string fn)
        {
            string app_type = "";
            string file_type = "";
            string templateName = "DCP_Report.frx";
            //HeaderData header_data = GetHeaderFromFile(GetPath() + "/&" + fn);
            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
            FrxParameters pars = new FrxParameters()
            {
                new FrxParameter("p_fn", TypeCode.String, fn)
            };
            FrxDoc doc = new FrxDoc(templatePath, pars, null);

            using (var str = new MemoryStream())
            {
                if (save_type == "txt")
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Text, str);
                    app_type = "text/plain";
                    file_type = ".txt";
                }
                string TempDir = Path.GetTempPath();
                DirectoryInfo TmpDitInf = new DirectoryInfo(TempDir);
                if (!TmpDitInf.Exists)
                    TmpDitInf.Create();
                string TempPath = TempDir + "DCPReport" + file_type;

                string buffer = Encoding.UTF8.GetString(str.ToArray());
                buffer = buffer.Replace("\f\r", string.Empty);
                var utf8bytes = Encoding.UTF8.GetBytes(buffer);
                var win1252Bytes = Encoding.Convert(Encoding.UTF8, Encoding.GetEncoding("windows-1251"), utf8bytes);
                for (int i = 0; i < win1252Bytes.Length; i++)
                {
                    if (win1252Bytes[i] == 76)//L
                        win1252Bytes[i] = 45;// space
                    if (win1252Bytes[i] == 84)//T
                        win1252Bytes[i] = 43;//124+
                    if (win1252Bytes[i] == 63)//?
                        win1252Bytes[i] = 45;//space
                }

                System.IO.File.WriteAllBytes(TempPath, win1252Bytes);
                return new { tempDir = TempDir, name = "DCPReport" + file_type };
            }
        }
    }
}
