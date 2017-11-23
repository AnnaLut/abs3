using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.AccountRestore.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.AccountRestore.Controllers
{
    [AuthorizeUser]
    public class AccountRestoreController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
