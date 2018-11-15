using System;
using BarsWeb.Controllers;
using BarsWeb.Areas.Utilities.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Utilities.Models;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.Utilities.Controllers
{
    [AuthorizeUser]
    public class PayDocsController : ApplicationController
    {
        private readonly IPayDocsRepository _paydocsRepository;
        public PayDocsController(IPayDocsRepository paydocsRepository)
        {
            _paydocsRepository = paydocsRepository;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetKF([DataSourceRequest]DataSourceRequest request)
        {
            try
            {
                return Json(_paydocsRepository.GetKF().ToDataSourceResult(request), JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {
                return Json(new DataSourceResult { Errors = e.Message } , JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult PaySelectedDocs (string kf_list)
        {
            try
            {
                string error_message = _paydocsRepository.PaySelectedDocs(new JavaScriptSerializer().Deserialize<List<string>>(kf_list));
                if (error_message == "")
                    return Json(new { Message = "Ok" });
                else
                    return Json(new { Error = error_message });
            }
            catch(Exception e)
            {
                return Json(new { Error = e.Message });
            }
        }


    }
}