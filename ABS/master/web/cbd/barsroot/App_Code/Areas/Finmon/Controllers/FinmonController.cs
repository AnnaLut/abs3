using System;
using System.Globalization;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Finmom.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using clientregister;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

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

        public ActionResult GetFmData([DataSourceRequest] DataSourceRequest request, int lastDays)
        {
            DateTime fromDate = DateTime.Today.AddDays(lastDays*-1);
            var data = _finmonRepository.GetOperFm().Where(o => o.PDAT >= fromDate);
            return Json(data.ToDataSourceResult(request));
        }

        public ActionResult PrintFmForm(decimal refDoc)
        {
            var service = new defaultWebService();
            string fileName = service.GetFileForPrint(refDoc.ToString(CultureInfo.CurrentCulture), "OPER_REF_FM", null);
            return File(fileName, "application/force-download", String.Format("Finmon_{0}.rtf", refDoc));
        }
    }
}