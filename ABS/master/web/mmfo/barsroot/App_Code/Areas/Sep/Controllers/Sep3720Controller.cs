using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Dapper;
using Newtonsoft.Json;
using Bars.Classes;
using Areas.Sep.Models;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.Sep.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class Sep3720Controller : ApplicationController
    {
        private readonly ISep3720Repository _repo;
        private readonly IErrorsRepository _errors;
        private readonly IParamsRepository _paramsRepo;
        private readonly ISepTZRepository _repoTz;
        public Sep3720Controller(ISep3720Repository repository, IErrorsRepository errorRepo, IParamsRepository paramsRepo, ISepTZRepository repoTz)
        {
            _repo = repository;
            _errors = errorRepo;
            _paramsRepo = paramsRepo;
            _repoTz = repoTz;
        }
        public ActionResult Index(AccessType accessType)
        {
            ViewBag.Ord902Param = _paramsRepo.GetParam("ORD902").Value;
            ViewBag.SumT902 = _repo.GetSumT902();
            ViewBag.SumT902Docs3720 = _repo.SumT902Docs3720();
            //ViewBag.RefCount = _repo.GetSep3720Count(accessType);
            return View(accessType);
        }
        public ActionResult GetSep3720List([DataSourceRequest] DataSourceRequest request, AccessType accessType)
        {
            IQueryable<Sep3720> fileList = _repo.GetSep3720List(request, accessType);
            decimal total = _repo.GetSep3720Count(accessType, request);
            return Json(new { Data = fileList, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DeleteRecord(string references)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                References[] refs = JsonConvert.DeserializeObject<References[]>(references);
                foreach (var item in refs)
                {
                    _repo.DeleteSep3720Record(item.Ref);
                }
                result.message = string.Format("Успішно видалено.");
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAccount(int accNumber)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var account = _repo.GetAccount().Where(acc => acc.ACC == accNumber).Select(acc => acc).SingleOrDefault();
                result.data = new { account.NLS, account.NMS, account.TIP };
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SetRequest(List<Sep3720> requestList)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var requestedDoc = _repo.SetRequest(requestList);
                if (requestedDoc.Count == 0)
                {
                    result.message = "Сформовано " + requestList.Count + " запитів";
                }
                else
                {
                    result.message = "Сформовано " + (requestList.Count - requestedDoc.Count) + " запитів.<br/>" +
                                     "Помилкових " + requestedDoc.Count + ":<br/>";
                    foreach (SetRequestResult model in requestedDoc)
                    {
                        result.message += "Номер документа: " + model.ND + "<br/>";
                        result.message += "Помилка: " + model.ERROR + "<br/>";
                    }
                }
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAltAccount(string nls, decimal kv)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var altAccount = _repo.GetAltAccount(nls, kv);
                result.data = altAccount;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetRefByRec(decimal? recId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                Sep3720Doc res = null;
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    res = connection.Query<Sep3720Doc>("select t.* from v_sep_docs t where t.rec = :recId", new { recId }).FirstOrDefault();
                }
                result.data = res;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        public ActionResult ViewRequest(decimal rec, string fname, decimal fln)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                decimal refDocument = 0;
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    string query = @"SELECT t.ref
                                     FROM arc_rrp t
                                     WHERE t.rec >= :rec
                                     AND t.d_rec LIKE '%#?' || :fa_name || LPAD (:fa_ln, 6, ' ') || '#%'";

                    refDocument = connection.Query<decimal>(query, new { rec = rec, fa_name = fname, fa_ln = fln }).SingleOrDefault();
                }
                result.data = refDocument;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ToAltAccounts(string docList, int rowSelected)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var successedDoc = _repo.SetToAltAccounts(docList);
                if (successedDoc == rowSelected)
                {
                    result.message = "Проведено всі " + successedDoc + " документів";
                }
                else
                {
                    result.message = "Не всі документи проведено";
                }
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = "Виникла помилка при проведенні документів";
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }

    public class References
    {
        public decimal Ref { get; set; }
    }
}