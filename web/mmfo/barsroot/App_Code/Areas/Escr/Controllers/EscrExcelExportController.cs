using System.Web.Mvc;
using System;

namespace BarsWeb.Areas.Escr.Controllers
{
    public partial class EscrExcelExportController : Controller
    {
        /*public ActionResult ExcelExport()
        {
            return View();
        }

        public ActionResult ExcelExport_Read([DataSourceRequest]DataSourceRequest request)
        {
            return Json(productService.Read().ToDataSourceResult(request));
        }*/

        [HttpPost]
        public ActionResult ExcelExport_Save(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);
            return File(fileContents, contentType, fileName);
        }
    }
}