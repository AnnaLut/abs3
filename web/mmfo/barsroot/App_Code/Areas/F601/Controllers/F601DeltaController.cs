using BarsWeb.Areas.F601.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using System;
using System.Web.Mvc;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using BarsWeb.Areas.F601.Models;

namespace BarsWeb.Areas.F601.Controllers
{
    [AuthorizeUser]
    public class F601DeltaController : ApplicationController
    {
        private readonly IF601Repository _repository;
        public F601DeltaController(IF601Repository repository)
        {
            _repository = repository;

        }
        public ActionResult Index()
        {
            return View();
        }

    }
}