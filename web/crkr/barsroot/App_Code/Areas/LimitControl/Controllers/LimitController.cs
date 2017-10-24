using System;
using System.Collections.Generic;
using System.Web.Mvc;
using BarsWeb.Areas.LimitControl.Infrastucture.DI.Abstract;
using BarsWeb.Areas.LimitControl.Infrastucture.DI.Implementation;
using BarsWeb.Areas.LimitControl.ViewModels;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.LimitControl.Controllers
{
    [AuthorizeUser]
    public class LimitController : ApplicationController
    {
        readonly ILimitRepository _repository = new LimitServiceRepository();

        /// <summary>
        /// Проверка статуса документа
        /// </summary>
        /// <returns></returns>
        public ViewResult DocumentStatus()
        {
            var docStatus = new DocStatus
            {
                SearchInfo = new LimitSearchInfo()
            };
            return View(docStatus);
        }

        /// <summary>
        /// Возвращает результат поиска
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult GetDocumentStatus(LimitSearchInfo searchInfo)
        {
            try
            {
                LcsServices.LimitStatus limitStatus = _repository.GetLimitStatus(searchInfo);
                var result = new { success = true, limitStatus };
                return Json(result);
            }
            catch (Exception e)
            {
                var result = new { success = false, errorMessage = e.Message };
                return Json(result);
            }
        }

        /// <summary>
        /// Подтверждение переводов
        /// </summary>
        /// <returns></returns>
        public ViewResult ConfirmTransfers()
        {
            return View(new TransferSearchInfo());
        }

        /// <summary>
        /// Получить список переводов
        /// </summary>
        /// <param name="request"></param>
        /// <param name="searchInfo"></param>
        /// <returns></returns>
        public ActionResult GetTransfers([DataSourceRequest] DataSourceRequest request, TransferSearchInfo searchInfo)
        {
            try
            {
                List<Transfer> tranfers = _repository.GetTransfers(searchInfo);
                return Json(tranfers.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Подтвердить переводы
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult ConfirmTransfers(ConfirmTransfersViewModel viewModel)
        {
            try
            {
                ConformationResponse response = _repository.ConfirmTransfers(viewModel.SearchInfo, viewModel.Transfers, System.Web.HttpContext.Current.User.Identity.Name.ToLower());
                var result = new { success = true, response };
                return Json(result);
            }
            catch (Exception e)
            {
                var result = new { success = false, errorMessage = e.Message };
                return Json(result);
            }
        }

        public class ConfirmTransfersViewModel
        {
            public TransferSearchInfo SearchInfo { get; set; }
            public List<string> Transfers { get; set; }
        }

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