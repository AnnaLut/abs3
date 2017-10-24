using BarsWeb.Areas.CTRV.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using System;
using System.IO;
using System.Text;
using System.Web.Mvc;

namespace BarsWeb.Areas.CTRV.Controllers
{
    [AuthorizeUser]
    public class CheckServerConnController : ApplicationController
    {
        private readonly ICheckServerConnRepository _repository;

        public CheckServerConnController(ICheckServerConnRepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index()
        {
            return View();
        }
    }
}
