using System.Web.Mvc;
using BarsWeb.Areas.Mbdk.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using System.IO;
using System;

namespace BarsWeb.Areas.Mbdk.Controllers
{
    public class NostroController : ApplicationController
    {
        private readonly INostroRepository _nostro;
        public NostroController(INostroRepository nostro)
        {
            _nostro = nostro;
        }

        public ActionResult Portfolio()
        {
            return View();
        }
    }
}