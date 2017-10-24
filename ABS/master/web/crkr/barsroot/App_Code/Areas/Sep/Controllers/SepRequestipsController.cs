using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.IO;
using System.Net.Http;

namespace BarsWeb.Areas.Sep.Controllers
{

    [AuthorizeUser]
    public class SepRequestipsController : ApplicationController
    {
        private readonly ISepRequestipsRepository _repo;
        private readonly IErrorsRepository _errors;

        public SepRequestipsController(ISepRequestipsRepository repository, IErrorsRepository errorsRepo)
        {
            _repo = repository;
            _errors = errorsRepo;
        }

        public ActionResult Index([DataSourceRequest]DataSourceRequest request, SepRequestipsFilterParams fp)
        {           
            return View();
        }

        public ActionResult GetRequestips([DataSourceRequest]DataSourceRequest request, SepRequestipsFilterParams fp) 
        {
            var requestips = _repo.GetRequestips(fp, request);
            return Json(requestips.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
         
        public FileResult GetFile(SepRequestipsFilterParams fp)
        {
            using (var memoStream = new MemoryStream(1024 * 5))
            {
               using (StreamWriter writer = new StreamWriter(memoStream))
               {
                  _repo.WriteFile(fp, writer);
               }
               return File(new MemoryStream(memoStream.GetBuffer()),
                   System.Net.Mime.MediaTypeNames.Application.Octet,
                   fp.FN_QA.Replace("$", "Р") + ".txt");
            }
        }
   
        public ActionResult CRMSRV()
        {            
            return null;
        }
    }
}