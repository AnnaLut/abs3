using System;
using System.Globalization;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Finmon.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using clientregister;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web;
using System.IO;
using System.Data;
using System.Text;
using System.Net.Http;
using Areas.Finmon.Models;

namespace BarsWeb.Areas.Finmon.Controllers
{
    [AuthorizeUser]
    [CheckAccessPage]
    public class FinmonController : ApplicationController
    {
        private readonly IFinmonRepository _finmonRepository;
        public FinmonController(IFinmonRepository finmonRepository)
        {
            _finmonRepository = finmonRepository;
        }

        public ActionResult Index(int lastDays)
        {
            return View(model: lastDays);
        }

        /// <summary>
        /// Население грида из BARS.V_FM_OPER - "Анкети по операціям без відкриття рахунків"
        /// </summary>
        /// <param name="request"></param>
        /// <param name="lastDays"></param>
        /// <param name="dateFrom">Начало периода (oper.pdat)</param>
        /// <param name="dateTo">Конец периода (oper.pdat)</param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetFmData([DataSourceRequest] DataSourceRequest request, int lastDays, string dateFrom, string dateTo)
        {
            IQueryable<V_OPER_FM> data = null;
            DateTime fromDate = DateTime.Today.AddDays(lastDays * -1);

            if (dateFrom != String.Empty && dateTo != String.Empty)
            {
                DateTime _df = DateTime.Parse(dateFrom);
                DateTime _dt = DateTime.Parse(dateTo);

                data = _finmonRepository.GetOperFm().Where(o => o.PDAT >= _df && o.PDAT <= _dt);
            }
            else
            {
                data = _finmonRepository.GetOperFm().Where(o => o.PDAT >= fromDate);
            }
            return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult PrintFmForm(decimal refDoc)
        {
            var service = new defaultWebService();
            var serviceResult = service.GetFileForPrint(refDoc.ToString(CultureInfo.CurrentCulture), "OPER_REF_FM", null);

            string fileName = serviceResult.Text;
            return File(fileName, "application/force-download", String.Format("Finmon_{0}.rtf", refDoc));
        }

        /// <summary>
        /// Общая загрузка файлов
        /// </summary>
        /// <param name="fileType">Тип файла - Terr (список террористов), PEP (Публ. деятели pep.org.ua), KIS (Публ. деятели КИС)</param>
        /// <param name="result"></param>
        /// <returns></returns>
        public ActionResult ImportFile()
        {
            return View();
        }

        /// <summary>
        /// Общая загрузка файлов
        /// </summary>
        /// <param name="upload">Данные</param>
        /// <param name="fileType">Тип файла - Terr (список террористов), PEP (Публ. деятели pep.org.ua), KIS (Публ. деятели КИС)</param>
        /// <returns>JSON state = ("OK" | "Error"), data=(successMessage | exception.Message)</returns>
        [HttpPost]
        public ActionResult UploadFile(HttpPostedFileBase upload, string fileType)
        {
            HttpRequest httpRequest = System.Web.HttpContext.Current.Request;
            fileType = Request.UrlReferrer.ParseQueryString().Get("fileType");
            if (upload == null || upload.InputStream == null)
            {
                return Json(new { state = "Error", data = "Порожній файл" }, "text/plain", JsonRequestBehavior.AllowGet);
            }
            try
            {
                string data;
                string ds;
                //Хотя в файле указана кодировка UTF-8 для нормального отображения в базе файл считывается в кодировке Windows-1251
                using (StreamReader stream = new StreamReader(upload.InputStream, fileType != "PEP" ? Encoding.GetEncoding("Windows-1251") : Encoding.UTF8))
                {
                    data = stream.ReadToEnd();
                }
                ds = data.Substring(1, 2000);
                String importResult = _finmonRepository.ImportFile(fileType, data);
                return Json(new { state = "OK", data = importResult }, "text/plain", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { state = "Error", data = ex.Message }, "text/plain", JsonRequestBehavior.AllowGet);
            }
        }
    }
}