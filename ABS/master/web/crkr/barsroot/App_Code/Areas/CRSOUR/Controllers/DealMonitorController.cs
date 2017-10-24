using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.CRSOUR.Infrastructure.Repository.DI.Abstract;
using Areas.CRSOUR.Models;
using BarsWeb.Areas.CRSOUR.ViewModels;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.CRSOUR.Controllers
{
    [AuthorizeUser]
    public class DealMonitorController : ApplicationController
    {
        private readonly IDealsRepository _dealsRepository;

        public DealMonitorController(IDealsRepository dealsRepository)
        {
            _dealsRepository = dealsRepository;
        }

        /// <summary>
        /// Спрощений список заявок для акцепту
        /// </summary>
        /// <returns></returns>
        public ViewResult SimpleAcceptList()
        {
            return View();
        }

        /// <summary>
        /// Повний список заявок для акцепту
        /// </summary>
        /// <returns></returns>
        public ViewResult AcceptList()
        {
            var model = new StartOptions
            {
                StartWindow = WindowType.FullAcceptList,
                FunctionName = "Повний список заявок від Аллегро"
            };
            return View(model);
        }

        /// <summary>
        /// Повний список транзакций АБС
        /// </summary>
        /// <returns></returns>
        public ViewResult TranasactionList()
        {
            var model = new StartOptions
            {
                StartWindow = WindowType.FullTransactionList,
                FunctionName = "Повний список транзакцій АБС"
            };
            return View("AcceptList", model);
        }

        /// <summary>
        /// Получить простой список заявок
        /// </summary>
        /// <param name="request"></param>
        /// <param name="currencyCode">Фильтр на код валюты</param>
        /// <param name="exceptThisCode">Отобрать с отличным от заданного кодом валюты (по умолчанию - с заданным)</param>
        public ActionResult GetSimpleClaims([DataSourceRequest] DataSourceRequest request, string currencyCode = null, bool exceptThisCode = false)
        {
            try
            {
                IQueryable<V_CDB_CLAIM_DATA_TO_ACCEPT> dbRecords = _dealsRepository.GetSimpleClaims();
                if (currencyCode != null)
                {
                    dbRecords = exceptThisCode
                        ? dbRecords.Where(x => x.CURRENCY_ID != currencyCode)
                        : dbRecords.Where(x => x.CURRENCY_ID == currencyCode);
                }
                IQueryable<SimpleClaim> viewRecords = dbRecords.Select(
                    f => new SimpleClaim
                    {
                        Id = f.ID,
                        ClaimType = f.CLAIM_TYPE,
                        DealNumber = f.DEAL_NUMBER,
                        LenderCode = f.LENDER_CODE,
                        BorrowerCode = f.BORROWER_CODE,
                        StartDate = f.START_DATE,
                        EndDate = f.END_DATE,
                        Sum = f.AMOUNT,
                        Currency = f.CURRENCY_ID,
                        RateDate = f.INTEREST_RATE_DATE,
                        Rate = f.INTEREST_RATE,
                        EndDateFlag = f.END_DATE_FLAG,
                        SumFlag = f.AMOUNT_FLAG,
                        RateDateFlag = f.INTEREST_DATE_FLAG,
                        RateFlag = f.INTEREST_RATE_FLAG,
                        Comment = f.COMMENT_TEXT,
                    });
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Получить полный список заявок
        /// </summary>
        public ActionResult GetComplexClaims([DataSourceRequest] DataSourceRequest request, int? claimId = null)
        {
            try
            {
                IQueryable<V_CDB_CLAIM> dbRecords = _dealsRepository.GetComplexClaims();
                IQueryable<ComplexClaim> viewRecords = dbRecords.Select(
                    f => new ComplexClaim
                    {
                        Id = f.ID,
                        DealNumber = f.DEAL_NUMBER,
                        Type = f.CLAIM_TYPE,
                        ClaimTypeId = f.CLAIM_TYPE_ID,
                        State = f.CLAIM_STATE,
                        Comment = f.LAST_TRACKING_MESSAGE,
                        Mfo = f.REGION_MFO
                    });
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Подтвердить обработку заявки
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult SubmitClaim(int claimId)
        {
            try
            {
                string message;
                bool success = _dealsRepository.SubmitClaim(claimId, out message);
                var result = new { success = success, message = success ? "Обробка підтверджена" : message };
                return Json(result);
            }
            catch (Exception e)
            {
                var result = new { success = false, message = e.ToString() };
                return Json(result);
            }
        }

        /// <summary>
        /// Отменить обработку заявки
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult CancelProcessClaim(int claimId, string comment)
        {
            try
            {
                string message;
                bool success = _dealsRepository.CancelClaim(claimId, comment, out message);
                var result = new { success = success, message = success ? "Заявка відмінена" : message };
                return Json(result);
            }
            catch (Exception e)
            {
                var result = new { success = false, message = e.ToString() };
                return Json(result);
            }
        }

        /// <summary>
        /// Повторно выполнить заявку
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult RepeatClaim(int claimId)
        {
            try
            {
                string message;
                bool success = _dealsRepository.RepeatClaim(claimId, out message);
                var result = new { success = success, message = success ? "Заявка повторно виконана" : message };
                return Json(result);
            }
            catch (Exception e)
            {
                var result = new { success = false, message = e.ToString() };
                return Json(result);
            }
        }

        /// <summary>
        /// Получить детали заявки типа Новая сделка
        /// </summary>
        public ActionResult GetClaimDetailsNewDeal([DataSourceRequest] DataSourceRequest request, int? claimId = null)
        {
            try
            {
                IQueryable<V_CDB_NEW_DEAL_CLAIM> dbClaim = _dealsRepository.GetClaimDetailsNewDeal();
                if (claimId != null)
                {
                    dbClaim = dbClaim.Where(x => x.ID == claimId);
                }
                IQueryable<ClaimDetailsNewDeal> viewClaim = dbClaim.Select(f => new ClaimDetailsNewDeal
                {
                    Id = f.ID,
                    DealNumber = f.DEAL_NUMBER,
                    StartDate = f.OPEN_DATE,
                    EndDate = f.EXPIRY_DATE,
                    LenderCode = f.LENDER_CODE,
                    LenderName = f.LENDER_NAME,
                    BorrowerCode = f.BORROWER_CODE,
                    BorrowerName = f.BORROWER_NAME,
                    Sum = f.AMOUNT,
                    Currency = f.CURRENCY_ID,
                    InterestRate = f.INTEREST_RATE,
                    InterestCalendar = f.INTEREST_CALENDAR,
                    AllegroComment = f.ALLEGRO_COMMENT,
                    AllegroId = f.ALLEGRO_CLAIM_ID,
                    SysTime = f.SYS_TIME,
                    ClaimState = f.CLAIM_STATE
                });
                return Json(viewClaim.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Получить детали заявки типа Изменение даты погашения
        /// </summary>
        public ActionResult GetClaimDetailsChangeExpireDate([DataSourceRequest] DataSourceRequest request, int? claimId = null)
        {
            try
            {
                IQueryable<V_CDB_SET_EXPIRY_DATE_CLAIM> dbClaim = _dealsRepository.GetClaimDetailsChangeExpireDate();
                if (claimId != null)
                {
                    dbClaim = dbClaim.Where(x => x.ID == claimId);
                }
                IQueryable<ClaimDetailsChangeExpireDate> viewClaim = dbClaim.Select(f => new ClaimDetailsChangeExpireDate
                {
                    Id = f.ID,
                    DealNumber = f.DEAL_NUMBER,
                    ExpireDate = f.EXPIRY_DATE,
                    AllegroComment = f.ALLEGRO_COMMENT,
                    AllegroId = f.ALLEGRO_CLAIM_ID,
                    SysTime = f.SYS_TIME,
                    ClaimState = f.CLAIM_STATE
                });
                return Json(viewClaim.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Получить детали заявки типа Изменение процентной ставки
        /// </summary>
        public ActionResult GetClaimDetailsChangeRate([DataSourceRequest] DataSourceRequest request, int? claimId = null)
        {
            try
            {
                IQueryable<V_CDB_SET_INT_RATE_CLAIM> dbClaim = _dealsRepository.GetClaimDetailsChangeRate();
                if (claimId != null)
                {
                    dbClaim = dbClaim.Where(x => x.ID == claimId);
                }
                IQueryable<ClaimDetailsChangeRate> viewClaim = dbClaim.Select(f => new ClaimDetailsChangeRate
                {
                    Id = f.ID,
                    DealNumber = f.DEAL_NUMBER,
                    StartDate = f.INTEREST_RATE_DATE,
                    Rate = f.INTEREST_RATE,
                    AllegroComment = f.ALLEGRO_COMMENT,
                    AllegroId = f.ALLEGRO_CLAIM_ID,
                    SysTime = f.SYS_TIME,
                    ClaimState = f.CLAIM_STATE
                });
                return Json(viewClaim.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Получить детали заявки типа Изменение суммы
        /// </summary>
        public ActionResult GetClaimDetailsChangeSum([DataSourceRequest] DataSourceRequest request, int? claimId = null)
        {
            try
            {
                IQueryable<V_CDB_CHANGE_AMOUNT_CLAIM> dbClaim = _dealsRepository.GetClaimDetailsChangeSum();
                if (claimId != null)
                {
                    dbClaim = dbClaim.Where(x => x.ID == claimId);
                }
                IQueryable<ClaimDetailsChangeSum> viewClaim = dbClaim.Select(f => new ClaimDetailsChangeSum
                {
                    Id = f.ID,
                    DealNumber = f.DEAL_NUMBER,
                    NewSum = f.NEW_DEAL_AMOUNT,
                    AllegroComment = f.ALLEGRO_COMMENT,
                    AllegroId = f.ALLEGRO_CLAIM_ID,
                    SysTime = f.SYS_TIME,
                    ClaimState = f.CLAIM_STATE
                });
                return Json(viewClaim.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Получить детали заявки типа Закрытие сделки
        /// </summary>
        public ActionResult GetClaimDetailsCloseDeal([DataSourceRequest] DataSourceRequest request, int? claimId = null)
        {
            try
            {
                IQueryable<V_CDB_CLOSE_DEAL_CLAIM> dbClaim = _dealsRepository.GetClaimDetailsCloseDeal();
                if (claimId != null)
                {
                    dbClaim = dbClaim.Where(x => x.ID == claimId);
                }
                IQueryable<ClaimDetailsCloseDeal> viewClaim = dbClaim.Select(f => new ClaimDetailsCloseDeal
                {
                    Id = f.ID,
                    AllegroComment = f.ALLEGRO_COMMENT,
                    AllegroId = f.ALLEGRO_CLAIM_ID,
                    ClaimState = f.CLAIM_STATE,
                    CloseDate = f.CLOSE_DATE,
                    DealNumber = f.DEAL_NUMBER,
                    SysTime = f.SYS_TIME,

                });
                return Json(viewClaim.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Получить историю обработки заявки
        /// </summary>
        public ActionResult GetClaimHistory([DataSourceRequest] DataSourceRequest request, int? claimId = null)
        {
            try
            {
                IQueryable<V_CDB_CLAIM_TRACK> dbRecords = _dealsRepository.GetClaimHistory();
                if (claimId != null)
                {
                    dbRecords = dbRecords.Where(x => x.CLAIM_ID == claimId);
                }
                IQueryable<ClaimHistory> viewRecords = dbRecords.Select(f => new ClaimHistory
                {
                    Id = f.CLAIM_ID,
                    ClaimState = f.CLAIM_STATE,
                    Comment = f.TRACKING_COMMENT,
                    SysTime = f.SYS_TIME
                });
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }

        }

        /// <summary>
        /// Получить историю обработки транзакции
        /// </summary>
        public ActionResult GetTransactionHistory([DataSourceRequest] DataSourceRequest request, int? transactionId = null)
        {
            try
            {
                IQueryable<V_CDB_TRANSACTION_TRACK> dbRecords = _dealsRepository.GetTransactionHistory();
                if (transactionId != null)
                {
                    dbRecords = dbRecords.Where(x => x.TRANSACTION_ID == transactionId);
                }
                IQueryable<TransactionHistory> viewRecords = dbRecords.Select(f => new TransactionHistory
                {
                    Id = f.TRANSACTION_ID,
                    TransactionState = f.CLAIM_STATE,
                    Comment = f.TRACKING_COMMENT,
                    SysTime = f.SYS_TIME
                });
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Получить список транзакции
        /// </summary>
        public ActionResult GetTransactions([DataSourceRequest] DataSourceRequest request, int? claimId = null)
        {
            try
            {
                IQueryable<V_CDB_BARS_TRANSACTION> dbRecords = _dealsRepository.GetTransactions();
                if (claimId != null)
                {
                    dbRecords = dbRecords.Where(x => x.CLAIM_ID == claimId);
                }
                IQueryable<Transaction> viewRecords = dbRecords.Select(f => new Transaction
                {
                    TransactionId = f.ID,
                    ClaimId = f.CLAIM_ID,
                    ClaimType = f.CLAIM_TYPE,
                    ClaimTypeId = f.CLAIM_TYPE_ID,
                    MfoCode = f.MFO,
                    TransactionType = f.TRANSACTION_TYPE,
                    TransactionTypeId = f.TRANSACTION_TYPE_ID,
                    Object = f.OBJECT,
                    Priority = f.PRIORITY_GROUP,
                    FailCounter = f.FAIL_COUNTER,
                    TransactionState = f.TRANSACTION_STATE,
                    Comment = f.LAST_TRACKING_MESSAGE
                });
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Отменить обработку транзакции
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult CancelTransaction(int transactionId, string comment)
        {
            try
            {
                string message;
                bool success = _dealsRepository.CancelTransaction(transactionId, comment, out message);
                var result = new { success = success, message = success ? "Транзакція відмінена" : message };
                return Json(result);
            }
            catch (Exception e)
            {
                var result = new { success = false, message = e.ToString() };
                return Json(result);
            }
        }

        /// <summary>
        /// Повторно отправить транзакцию в АБС
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult RepeatTransactionSending(int transactionId)
        {
            try
            {
                string message;
                bool success = _dealsRepository.RepeatTransactionSending(transactionId, out message);
                var result = new { success = success, message = success ? "Транзакція відправлена" : message };
                return Json(result);
            }
            catch (Exception e)
            {
                var result = new { success = false, message = e.ToString() };
                return Json(result);
            }
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