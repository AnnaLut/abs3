using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.Compare_351_601.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.Compare_351_601.Controllers
{
    [AuthorizeUser]
    public class Compare_351_601Controller : ApplicationController
    {

        private readonly ICompare_351_601Repository _351_601Repository; //_paydocsRepository;
        public Compare_351_601Controller(ICompare_351_601Repository Compare_351_601Repository)
        {
            _351_601Repository = Compare_351_601Repository;
        }
        public ActionResult Index()
        {
            return View();
        }
      
        public ActionResult consl()
        {
            try
            {
                _351_601Repository.execute_consolidate();

                return Json(new { Message = "Ok" });

            }
            catch (Exception e)
            {
                return Json(new { Error = e.Message });
            }
        }
    }

   
}
