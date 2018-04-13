using System;
using System.Globalization;
using System.IO;
using System.Threading;
using System.Web.Mvc;
using BarsWeb.Models;


namespace BarsWeb.Controllers
{
    public abstract class ApplicationController : Controller
    {
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            string lang = Convert.ToString(filterContext.RequestContext.RouteData.Values["lang"]);
            ViewBag.lang = lang;
            if (string.IsNullOrWhiteSpace(lang))
            {
                lang = "uk";
            }
            /*if (Request.UserLanguages != null)
            {

                // Validate culture name
                string cultureName = Request.UserLanguages[0]; // obtain it from HTTP header AcceptLanguages
                if (!string.IsNullOrEmpty(cultureName))
                {
                    // Modify current thread's culture            
                    lang = cultureName;
                }
            }*/
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(lang);
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture(lang);
            base.OnActionExecuting(filterContext);
        }
        protected JsonResult ErrorJson(string message)
        {
            return Json(new JsonResponse(JsonResponseStatus.Error, message), JsonRequestBehavior.AllowGet);
        }

        protected JsonResult ErrorJson(string message, object data)
        {
            return ErrorJson(new JsonResponse(JsonResponseStatus.Error, message, data));
        }
        protected JsonResult ErrorJson(Exception exception)
        {
            var res = new JsonResponse(JsonResponseStatus.Error)
            {
                message = exception.InnerException == null ? exception.Message : exception.InnerException.Message
            };
            return ErrorJson(res);
        }
        protected JsonResult ErrorJson(JsonResponse response)
        {
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        protected string RenderPartialViewToString(string viewName, object model)
        {
            if (string.IsNullOrEmpty(viewName))
                viewName = ControllerContext.RouteData.GetRequiredString("action");

            ViewData.Model = model;

            using (var sw = new StringWriter())
            {
                ViewEngineResult viewResult = ViewEngines.Engines.FindPartialView(ControllerContext, viewName);
                var viewContext = new ViewContext(ControllerContext, viewResult.View, ViewData, TempData, sw);
                viewResult.View.Render(viewContext, sw);

                return sw.GetStringBuilder().ToString();
            }
        }

        [HttpPost]
        public ActionResult ConvertBase64ToFile(string base64, string contentType = "attachment", string fileName = "file")
        {
            if (string.IsNullOrEmpty(fileName))
            {
                fileName = "file";
            }
            if (string.IsNullOrEmpty(contentType))
            {
                contentType = "attachment";
            }
            var fileContents = Convert.FromBase64String(base64);

            return File(fileContents, contentType, fileName);
        }
    }
}



/*namespace ExcelHelper
{

    using System;
    using Excel = Microsoft.Office.Interop.Excel;
    using System.Collections;
    using System.Diagnostics;
    using System.IO;
    public class ExcelDocConverter
    {
        Hashtable myHashtable;
        int MyExcelProcessId;

        Excel.Application excel;
        Excel.Workbook wbk;
        Excel.Worksheet worksheet1;

        object missing = System.Reflection.Missing.Value;

        public enum FormatType
        {
            XLS,
            XLSX,
            PDF,
            XPS,
            CSV
        }

        public MemoryStream Convert(MemoryStream originalFile)
        {
            // Get content of your Excel file
            var ms = new MemoryStream();

            // Get temp file name
            var temp = Path.GetTempPath(); // Get %TEMP% path
            var file = Path.GetFileNameWithoutExtension(Path.GetRandomFileName()); // Get random file name without extension
            var path = Path.Combine(temp, file + ".xlsx"); // Get random file path

            var outFile = Path.GetFileNameWithoutExtension(Path.GetRandomFileName()); // Get random file name without extension
            var outPatch = Path.Combine(temp, outFile + ".xls"); // Get random file path

            using (var fs = new FileStream(path, FileMode.Create, FileAccess.Write))
            {
                // Write content of your memory stream into file stream
                ms.WriteTo(fs);
            }
            Convert(FormatType.XLS, path, outPatch);
            var fileStream = new FileStream(outPatch, FileMode.Open, FileAccess.Read);
            var result = new MemoryStream();
            fileStream.CopyTo(result);
            result.Position = 0;
            return result;
        }

        public void Convert(FormatType formatType, string originalFile, string targetFile)
        {
            CheckForExistingExcellProcesses();

            excel = new Microsoft.Office.Interop.Excel.Application();
            excel.Visible = false;
            excel.ScreenUpdating = false;
            excel.DisplayAlerts = false;

            GetTheExcelProcessIdThatUsedByThisInstance();

            wbk = excel.Workbooks.Open(originalFile, 0, true, 5, "", "", true, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);

            switch (formatType)
            {
                case FormatType.XLS:
                    {
                        wbk.SaveAs(targetFile, Excel.XlFileFormat.xlWorkbookNormal, missing, missing, missing, missing, Excel.XlSaveAsAccessMode.xlExclusive, missing, missing, missing, missing, missing);
                    }
                    break;
                case FormatType.XLSX:
                    {
                        wbk.SaveAs(targetFile, Excel.XlFileFormat.xlWorkbookDefault, missing, missing, missing, missing, Excel.XlSaveAsAccessMode.xlExclusive, missing, missing, missing, missing, missing);
                    }
                    break;
                case FormatType.PDF:
                    {
                        wbk.ExportAsFixedFormat(Microsoft.Office.Interop.Excel.XlFixedFormatType.xlTypePDF, targetFile, Microsoft.Office.Interop.Excel.XlFixedFormatQuality.xlQualityStandard, false, true, missing, missing, false, missing);
                    }
                    break;
                case FormatType.XPS:
                    {
                        wbk.ExportAsFixedFormat(Microsoft.Office.Interop.Excel.XlFixedFormatType.xlTypeXPS, targetFile, Microsoft.Office.Interop.Excel.XlFixedFormatQuality.xlQualityStandard, false, true, missing, missing, false, missing);
                    }
                    break;
                case FormatType.CSV:
                    {
                        wbk.SaveAs(targetFile, Excel.XlFileFormat.xlCSV, missing, missing, missing, missing, Excel.XlSaveAsAccessMode.xlExclusive, missing, missing, missing, missing, missing);
                    }
                    break;
                default:
                    break;
            }

            ReleaseExcelResources();
            KillExcelProcessThatUsedByThisInstance();
        }

        void ReleaseExcelResources()
        {
            try
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(worksheet1);
            }
            catch
            { }
            finally
            {
                worksheet1 = null;
            }

            try
            {
                if (wbk != null)
                    wbk.Close(false, missing, missing);
                System.Runtime.InteropServices.Marshal.ReleaseComObject(wbk);
            }
            catch
            { }
            finally
            {
                wbk = null;
            }

            try
            {
                excel.Quit();
                System.Runtime.InteropServices.Marshal.ReleaseComObject(excel);
            }
            catch
            { }
            finally
            {
                excel = null;
            }
        }

        void CheckForExistingExcellProcesses()
        {
            Process[] AllProcesses = Process.GetProcessesByName("excel");
            myHashtable = new Hashtable();
            int iCount = 0;

            foreach (Process ExcelProcess in AllProcesses)
            {
                myHashtable.Add(ExcelProcess.Id, iCount);
                iCount = iCount + 1;
            }
        }

        void GetTheExcelProcessIdThatUsedByThisInstance()
        {
            Process[] AllProcesses = Process.GetProcessesByName("excel");

            // Search For the Right Excel
            foreach (Process ExcelProcess in AllProcesses)
            {
                if (myHashtable == null)
                    return;

                if (myHashtable.ContainsKey(ExcelProcess.Id) == false)
                {
                    // Get the process ID
                    MyExcelProcessId = ExcelProcess.Id;
                }
            }

            AllProcesses = null;
        }

        void KillExcelProcessThatUsedByThisInstance()
        {
            Process[] AllProcesses = Process.GetProcessesByName("excel");

            foreach (Process ExcelProcess in AllProcesses)
            {
                if (myHashtable == null)
                    return;

                if (ExcelProcess.Id == MyExcelProcessId)
                    ExcelProcess.Kill();
            }

            AllProcesses = null;
        }
    }
}*/