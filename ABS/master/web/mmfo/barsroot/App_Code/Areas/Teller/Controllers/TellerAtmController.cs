using BarsWeb.Areas.Teller.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Teller.Model;
using BarsWeb.Controllers;
using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.Teller.Controllers
{
    [AuthorizeApi]
    [SessionState(System.Web.SessionState.SessionStateBehavior.ReadOnly)]
    public class TellerAtmController: ApplicationController
    {
        readonly ITellerRepository _repo;
        public TellerAtmController(ITellerRepository repo) { _repo = repo; }

        [HttpPost]
        public JsonResult GetATMStatus(Boolean http)
        {
            try
            {
                TellerStatusModel status = _repo.TellerStatus(http);
                return Json(new { statusCode = System.Net.HttpStatusCode.OK,  status });
            }
            catch (Exception ex)
            {
                return OnExceptionJsonResult(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult ChangeRequest(TellerWindowStatusModel data)
        {
            try
            {
                TellerResponseModel model = _repo.ChangeRequest(data);
                return Json(new { statusCode = System.Net.HttpStatusCode.OK, status = model });
            }
            catch (Exception ex)
            {
                return OnExceptionJsonResult(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult ATMRequest(ATMModel data)
        {
            TellerWindowStatusModel model = new TellerWindowStatusModel();
            try
            {
                model = _repo.ExecuteGetStatus(data);
                return Json(new { statusCode = System.Net.HttpStatusCode.OK,  model });
            }
            catch (Exception ex)
            {
                return OnExceptionJsonResult(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult Cashin(EncashmentModel data)
        {
            try
            {
                if (data.Method.ToLower() == "start_cashin")
                    data.Currency = _repo.GetCurrencyCode(data.Currency);
                TellerResponseModel model = _repo.Encashment(data);
                return Json(new { statusCode = System.Net.HttpStatusCode.OK,  model });
            }
            catch (Exception ex)
            {
                return OnExceptionJsonResult(ex.Message);
            }
        }

        /// <summary>
        /// Виконання операцій з вікном теллера
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult CancelATMWindowOperation(ATMModel data)
        {
            TellerWindowStatusModel model = _repo.ExecuteGetStatus(data);
            model = InitializeStatusModel(model, data);
            return Json(new { statusCode = System.Net.HttpStatusCode.OK, model });
        }

        /// <summary>
        /// Отримання статусу після проведення операції
        /// </summary>
        /// <param name="model"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        private TellerWindowStatusModel InitializeStatusModel(TellerWindowStatusModel model, ATMModel data)
        {
            data.RJ = true;
            data.Method = "getwindowstatus";
            TellerWindowStatusModel tmpModel = _repo.ExecuteGetStatus(data);
            model.Status = tmpModel.Status;
            return model;
        }

        private JsonResult OnExceptionJsonResult(String exceptionMessage)
        {
            return Json(new { statusCode = System.Net.HttpStatusCode.InternalServerError, p_errtxt = exceptionMessage });
        }
    }

}