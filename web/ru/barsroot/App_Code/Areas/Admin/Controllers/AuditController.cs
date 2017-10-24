using System.Web.Http;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web.Mvc;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Controllers
{
    public class AuditController : Controller
    {
        private readonly ISecAuditRepository _secAuditRepository;
        public AuditController(ISecAuditRepository auditRepository)
        {
            _secAuditRepository = auditRepository;
        }

        public ActionResult index()
        {
            return View();
        }

        public ActionResult GetSecAuditDate(DataSourceRequest request, string filter)
        {
            var data = _secAuditRepository.GetSecAuditData(request, filter);
            var total = _secAuditRepository.GetSecAuditCount(request, filter);
            return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
        }
    }
}