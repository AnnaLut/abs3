using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.SalaryBag.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.IO;
using FastReport.Utils;
using FastReport.Web;
using System.Web.UI.HtmlControls;
using System.Globalization;
using System.Web;
using Newtonsoft.Json;
using Areas.SalaryBag.Models;
using System.Text;

namespace BarsWeb.Areas.SalaryBag.Controllers
{
    [AuthorizeUser]
    public class SalaryBagController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Acc2625()
        {
            return View();
        }

        public ActionResult SalaryProcessing()
        {
            return View();
        }

        public ActionResult SalaryPayroll()
        {
            return View();
        }

        [HttpGet]
        public ActionResult ReportExport(string template, string rnk, string fileName, int type, string dateFrom, string dateTo, string payRollId)
        {
            JsonResult res = new JsonResult()
            {
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                ContentType = "text/json"
            };

            try
            {
                fileName = HttpUtility.UrlDecode(fileName);

                CultureInfo ci;
                ci = CultureInfo.CreateSpecificCulture("en-GB");
                ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                ci.DateTimeFormat.DateSeparator = ".";

                FrxParameters pars = new FrxParameters();
                if (!string.IsNullOrWhiteSpace(rnk))
                    pars.Add(new FrxParameter("p_rnk", TypeCode.Int32, rnk));

                if (!string.IsNullOrWhiteSpace(dateTo) && !string.IsNullOrWhiteSpace(dateFrom))
                {
                    pars.Add(new FrxParameter("sFdat1", TypeCode.String, Convert.ToDateTime(dateFrom, ci).ToString("dd.MM.yyyy")));
                    pars.Add(new FrxParameter("sFdat2", TypeCode.String, Convert.ToDateTime(dateTo, ci).ToString("dd.MM.yyyy")));
                }
                if (!string.IsNullOrWhiteSpace(payRollId))
                    pars.Add(new FrxParameter("zp_id", TypeCode.Int32, payRollId));

                string templatePath = FrxDoc.GetTemplatePathByFileName(template);

                FrxDoc doc = new FrxDoc(templatePath, pars, null);

                byte[] content = null;
                using (var str = new MemoryStream())
                {
                    doc.ExportToMemoryStream((FrxExportTypes)type, str);
                    //return File(str.ToArray(), "attachment", fileName);
                    content = str.ToArray();
                }

                res.Data = new ResponseSB()
                {
                    ResultMsg = Convert.ToBase64String(content)
                };
            }
            catch (Exception e)
            {
                res.Data = new ResponseSB()
                {
                    Result = "ERROR",
                    ResultMsg = ExeptionProcessing(e)
                };
            }

            return res;
        }

        [HttpGet]
        public FileResult GetExcelTemplate()
        {
            var filePath = System.Web.Hosting.HostingEnvironment.MapPath(@"~\Areas\SalaryBag\Content\example.xlsx");
            byte[] content = System.IO.File.ReadAllBytes(filePath);
            return File(content, "attachment", "Шаблон_іморт_ЗП_відомості.xlsx");
        }

        [HttpPost]
        public ActionResult ConvertBase64ToFileUrlDecoded(string base64, string contentType = "attachment", string fileName = "file")
        {
            fileName = HttpUtility.UrlDecode(fileName);

            return ConvertBase64ToFile(base64, contentType, fileName);
        }

        #region private methods
        private string ExeptionProcessing(Exception ex)
        {
            string txt = "";
            var ErrorText = ex.Message.ToString();

            byte[] strBytes = Encoding.UTF8.GetBytes(ErrorText);
            ErrorText = Encoding.UTF8.GetString(strBytes);

            var x = ErrorText.IndexOf("ORA");
            var ora = ErrorText.Substring(x + 4, 5); //-20001

            if (x < 0)
                return ErrorText;

            decimal oraErrNumber;
            if (!decimal.TryParse(ora, out oraErrNumber))
                return ErrorText;

            if (oraErrNumber >= 20000)
            {
                var ora1 = ErrorText.Substring(x + 11);
                var y = ora1.IndexOf("ORA");
                if (x > -1 && y > 0)
                {
                    txt = ErrorText.Substring(x + 11, y - 1);
                }
                else
                {
                    txt = ErrorText;
                }

                string tmpResult = txt.Replace('ы', 'і');
                return tmpResult;
            }
            else
                return ErrorText;
        }
        #endregion
    }
}
