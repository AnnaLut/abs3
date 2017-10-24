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

namespace BarsWeb.Areas.Sep.Controllers
{
    /// <summary>
    /// Технологические флаги
    /// </summary>
    public class SepTechFlagController : ApplicationController
    {
        private readonly ISepTechFlagRepository _repo;
        private readonly ISepParams _repoSepParam;
        private readonly IErrorsRepository _errors;

        public SepTechFlagController(ISepTechFlagRepository repository, IErrorsRepository errorsRepo, ISepParams repoSepParam) 
        {
            _repo = repository;
            _repoSepParam = repoSepParam;
            _errors = errorsRepo;
        }

        public ActionResult Index(SepTechFlagFilterParams p)
        {
          _repo.GetNModel();
           return View();
        }

        public ActionResult SetFlag([DataSourceRequest]DataSourceRequest request, SepTechFlagFilterParams p)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var param = _repoSepParam.GetParam("INT_DIR");
                if (param.Value != null)
                {
                    var kFilePath = param.Value + "\\"+ GetParam(p.radioVal);
                    FileStream kFile = new FileStream(kFilePath, FileMode.Create, FileAccess.ReadWrite);
                    kFile.Close();

                    result.data = new { param.Value };
                    result.status = JsonResponseStatus.Ok;
                }
                else
                {
                    result.data = new { param.Value }; //added
                    result.status = JsonResponseStatus.Error;
                }
            }
            catch (Exception exc) 
            {
                var param = _repoSepParam.GetParam("INT_DIR"); //added
                result.data = new { param.Value }; //added
                result.status = JsonResponseStatus.Error;
                result.message = exc.InnerException ==
                    null ? exc.Message : exc.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public string GetParam(string p)
        {
            string result = "K";
            switch (p) {
                case "rbZ": return "FILE_Z";
                case "cb01": return "Z001";
                case "rbZ3": return "Z3";
                case "rbVall": return "FILE_V";
                case "rbVbank": return "FILE_V";
                case "rbK0": return "FILE_K0";
                case "rbIpsInt": return "FILE_Q";
                case "rbIpsExt": return "FILE_Q";
                case "rbPauseInt": return "FILE_PAUSE";
                case "rbPauseExt": return "FILE_PAUSE";
                case "rbLimits": return "FL";
                default: break;
            }
            return result;
        }
    }
}