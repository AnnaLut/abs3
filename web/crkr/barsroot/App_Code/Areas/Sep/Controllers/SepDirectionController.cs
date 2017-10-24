using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using System;
using System.IO;
using System.Web.Mvc;

namespace BarsWeb.Areas.Sep.Controllers
{
    // СЕП. Блокувати/Розблокувати напрямки.
    [CheckAccessPage]
    [Authorize]
    public class SepDirectionController : ApplicationController
    {
        private readonly ISepDirectionRepository _repo;
        private readonly ISepParams _repoSepParam;
        public SepDirectionController(ISepDirectionRepository repo, ISepParams repoSepParam)
        {
            _repo = repo;
            _repoSepParam = repoSepParam;
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult StartDirection([DataSourceRequest] DataSourceRequest request, string answer)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {  
                _repo.SetDirection(request, answer);
                var param = _repoSepParam.GetParam("INT_DIR");

                if (param.Value != null)
                {
                    var kFilePath = param.Value + "\\K";
                    FileStream kFile = new FileStream(kFilePath, FileMode.Create, FileAccess.ReadWrite);
                    kFile.Close();

                    result.data = new { param.Value };
                    result.status = JsonResponseStatus.Ok;
                }
                else {
                    result.data = new { param.Value }; //added
                    result.status = JsonResponseStatus.Error;
                }
            }
            catch (Exception e)
            {
                var param = _repoSepParam.GetParam("INT_DIR"); //added
                result.data = new { param.Value }; //added
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}
