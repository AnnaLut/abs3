using System.Collections.Generic;
using System.Web.Mvc;
using BarsWeb.Areas.Security.Infrastructure.Repository.Abstract;
using BarsWeb.Areas.Security.Models;
using BarsWeb.Core.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Ninject;

namespace BarsWeb.Areas.Security.Controllers
{
    [Authorize]
    public class AccountController : ApplicationController
    {
        [Inject]
        public IAuditRepository AuditRepository { get; set; }

        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        public ActionResult Audit(int pageNum = 1, int pageSize = 20)
        {
            var result = AuditRepository.GetAllMessages();
            var dataSourceResult = result.ToDataSourceResult(new DataSourceRequest() {Page = pageNum, PageSize = pageSize});
            ViewBag.count = dataSourceResult.Total;
            ViewBag.pageNum = pageNum;
            ViewBag.pageSize = pageSize;
            var audit = (IEnumerable<AuditMessage>)dataSourceResult.Data;
            return View(audit);
        }
    }
}
