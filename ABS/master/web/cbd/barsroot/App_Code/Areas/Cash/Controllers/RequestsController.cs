using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Cash.Infrastructure;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Cash.Controllers
{
    /// <summary>
    /// Заявки на изменение лимитов
    /// </summary>
    [AuthorizeUser]
    public class RequestsController : ApplicationController
    {
        private readonly IRequestRepository _requestRepository;
        private readonly IAccountRepository _accountRepository;
        private readonly IMfoRepository _mfoRepository;

        public RequestsController(IRequestRepository requestRepository, IMfoRepository mfoRepository, IAccountRepository accountRepository)
        {
            _requestRepository = requestRepository;
            _mfoRepository = mfoRepository;
            _accountRepository = accountRepository;
        }

        /// <summary>
        /// Заявки на изменение лимитов
        /// </summary>
        /// <returns></returns>
        public ViewResult Index(bool center = false)
        {
            ViewBag.ItIsCenter = center;
            List<Mfo> mfoList = null;
            if (center)
            {
                mfoList = _mfoRepository.GetMfos().
                    Select(x => new Mfo { Code = x.MFO, Name = x.NAME })
                    .OrderBy(x => x.Code).ToList();
            }
            return View(mfoList);
        }

        /// <summary>
        /// форма створення нової заявки ACC
        /// </summary>
        /// <returns></returns>
        public ActionResult CreateAcc()
        {
            return View();
        }

        /// <summary>
        /// форма створення нової заявки ATM
        /// </summary>
        /// <returns></returns>
        public ActionResult CreateAtm(int? id)
        {
            if (id == null)
            {
                return View(new Request());
            }
            var request = _requestRepository.GetRequestById(Convert.ToInt32(id));
            if (request == null)
            {
                return View(new Request());
            }
            ViewBag.AtmCode = _requestRepository.GetAtmCode(Convert.ToInt32(request.AccountId));
            return View(request);
        }
        [HttpPost]
        public ActionResult CreateAtm(int accountId, decimal maxLoadLimit)
        {
            try
            {
                var request = _requestRepository.CreateRequest(accountId, null, null, maxLoadLimit * 100);
                return Json(new { Status = "ok", Data = request }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(
                    new
                    {
                        Status = "error",
                        Message = e.InnerException == null ? e.Message : e.InnerException.Message
                    },
                    JsonRequestBehavior.AllowGet);
            }
        }


        [HttpPost]
        public ActionResult UpdateAtm(int id, decimal maxLoadLimit)
        {
            try
            {
                var request = _requestRepository.UpdateRequest(id, null, null, maxLoadLimit * 100);
                if (request == null)
                {
                    return Json(
                        new
                        {
                            Status = "error",
                            Message = "Заявка не знайдена або не в статусі \"NEW\""
                        },
                        JsonRequestBehavior.AllowGet);
                }
                return Json(new { Status = "ok", Data = request }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(
                    new
                    {
                        Status = "error",
                        Message = e.InnerException == null ? e.Message : e.InnerException.Message
                    },
                    JsonRequestBehavior.AllowGet);
            }
        }
        [HttpPost]
        public ActionResult Create(Request changeLimitRequest)
        {
            if (changeLimitRequest != null && ModelState.IsValid)
            {
                try
                {
                    //changeLimitRequest.AccountId = 
                    //    GetAccountId(changeLimitRequest);
                    // вернем созданную строку
                    Request newRequest = _requestRepository.CreateRequest(changeLimitRequest);
                    if (newRequest != null)
                    {
                        changeLimitRequest = newRequest;
                    }
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(changeLimitRequest);
        }


        /// <summary>
        /// Підтвердити обробку заявки
        /// </summary>
        [HttpPost]
        public JsonResult ApproveRequest(decimal requestId)
        {
            try
            {
                // переводим в копейки перед подтверждением
                _requestRepository.ApproveRequest(requestId);
                var result = new { Status = "ok", Message = "Заявка підтверджена" };
                return Json(result);
            }
            catch (Exception e)
            {
                var result = new { Status = false, Message = e.InnerException == null ? e.Message : e.InnerException.Message };
                return Json(result);
            }
        }

        /// <summary>
        /// Відхилити обробку заявки
        /// </summary>
        [HttpPost]
        public JsonResult RejectRequest(decimal requestId)
        {
            try
            {
                // переводим в копейки перед отклонением
                _requestRepository.RejectRequest(requestId);
                var result = new { Status = "ok", Message = "Заявка відхилена" };
                return Json(result);
            }
            catch (Exception e)
            {
                var result = new { Status = false, Message = e.InnerException == null ? e.Message : e.InnerException.Message };
                return Json(result);
            }
        }

        [HttpPost]
        public ActionResult DeleteRequest(int requestId)
        {
            try
            {
                _requestRepository.DeleteRequest(requestId);
                return Json(new { Status = "ok" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(
                    new
                    {
                        Status = "error",
                        Message = e.InnerException == null ? e.Message : e.InnerException.Message
                    },
                    JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult GetRequests(
            [DataSourceRequest] DataSourceRequest request,
            string requestStatus = null,
            bool exceptThisStatus = false, 
            string cashType = null,
            List<string> mfoList = null)
        {
            try
            {
                IQueryable<V_CLIM_REQUEST> dbRecords = _requestRepository.GetRequests();

                if (mfoList != null && mfoList.Count > 0)
                {
                    dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
                }

                if (requestStatus != null)
                {
                    dbRecords = exceptThisStatus
                        ? dbRecords.Where(x => x.REQ_STATUS != requestStatus)
                        : dbRecords.Where(x => x.REQ_STATUS == requestStatus);
                }
                if (cashType != null)
                {
                    dbRecords = dbRecords.Where(x => x.ACC_CASHTYPE == cashType);
                }
                IQueryable<Request> viewRecords = ModelConverter.ToViewModel(dbRecords);
                return Json(viewRecords.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        private decimal GetAccountId(Request changeLimitRequest)
        {
            V_CLIM_ACC acc = _accountRepository.GetAccounts().First(x =>
                x.ACC_NUMBER == changeLimitRequest.PrivateAccount &&
                x.ACC_CURRENCY == changeLimitRequest.CurrencyCode);
            return acc.ACC_ID;
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CreateRequest([DataSourceRequest] DataSourceRequest request, Request changeLimitRequest)
        {
            if (changeLimitRequest != null && ModelState.IsValid)
            {
                try
                {
                    //changeLimitRequest.AccountId = 
                    //    GetAccountId(changeLimitRequest);
                    // вернем созданную строку
                    Request newRequest = _requestRepository.CreateRequest(changeLimitRequest);
                    if (newRequest != null)
                    {
                        changeLimitRequest = newRequest;
                    }
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { changeLimitRequest }.ToDataSourceResult(request, ModelState));
        }

        /*[AcceptVerbs(HttpVerbs.Post)]
        public ActionResult UpdateRequest([DataSourceRequest] DataSourceRequest request, Request changeLimitRequest)
        {
            if (changeLimitRequest != null && ModelState.IsValid)
            {
                try
                {
                    //changeLimitRequest.AccountId = 
                    //   GetAccountId(changeLimitRequest);
                    _requestRepository.UpdateRequest(changeLimitRequest);
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { changeLimitRequest }.ToDataSourceResult(request, ModelState));
        }*/



        /* [AcceptVerbs(HttpVerbs.Post)]
         public ActionResult DeleteRequest([DataSourceRequest] DataSourceRequest request, Request changeLimitRequest)
         {
             if (changeLimitRequest != null)
             {
                 try
                 {
                     _requestRepository.DeleteRequest(changeLimitRequest.ID);
                 }
                 catch (Exception ex)
                 {
                     return DataSourceErrorResult(ex);
                 }
             }

             return Json(new[] { changeLimitRequest }.ToDataSourceResult(request, ModelState));
         }*/

        private JsonResult DataSourceErrorResult(Exception ex)
        {
            return Json(new DataSourceResult
            {
                Errors = new
                {
                    message = ex.ToString(),
                },
            });
        }
    }
}