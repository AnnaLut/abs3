using System.Collections.Generic;
using System.Web.Mvc;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Linq;
using System;
using BarsWeb.Areas.Wcs.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Wcs.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Wcs.Models;
using System.IO;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Drawing;

namespace BarsWeb.Areas.Wcs.Controllers
{
    public partial class ExcelExportController : Controller
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
        public ActionResult ExcelExport_Save(string contentType, string base64, string fileName, string rObu, string rNbu)
        {
            var fileContents = Convert.FromBase64String(base64);

            Stream fileStream = new MemoryStream(fileContents);
            MemoryStream fileOutStream = new MemoryStream();
            using (var package = new ExcelPackage(fileStream))
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.First();
                worksheet.Cells["A26"].Value = "Внутрішній кредитний рейтинг Позичальника: " + rObu;
                worksheet.Cells["A26"].Style.Font.Bold = true;
                worksheet.Cells["A26"].Style.Fill.PatternType = ExcelFillStyle.Solid;
                worksheet.Cells["A26"].Style.Fill.BackgroundColor.SetColor(Color.LightGreen);
                worksheet.Cells["A27"].Value = "Клас Позичальника (відповідно до класифікації НБУ): " + rNbu;
                worksheet.Cells["A27"].Style.Font.Bold = true;
                worksheet.Cells["A27"].Style.Fill.PatternType = ExcelFillStyle.Solid;
                worksheet.Cells["A27"].Style.Fill.BackgroundColor.SetColor(Color.LightGreen);
                package.SaveAs(fileOutStream);
            }
            fileContents = fileOutStream.ToArray();

            return File(fileContents, contentType, fileName);
        }
    }
}