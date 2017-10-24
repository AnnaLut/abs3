using System;
using System.Collections.Generic;
using System.Web.Mvc;
using BarsWeb.Areas.Wcs.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Wcs.Infrastructure.DI.Implementation;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Wcs.Controllers
{
    [AuthorizeUser]
    public class CreditServiceController : ApplicationController
    {
        private readonly IWcsRepository _csRepository;
        public CreditServiceController(IWcsRepository cfRepository)
        {
            _csRepository = cfRepository;
        }
        public ActionResult CoiceOfServices()
        {
            return View();
        }
        public string GetValue(string bid_id, string question_id)
        {
            var val = _csRepository.GetValue(bid_id, question_id);
            return val;
        }
    }
}