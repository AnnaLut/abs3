using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Cash.Infrastructure;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.Models;
using BarsWeb.Areas.Cash.Models.ExportToExcelModels;
using BarsWeb.Areas.Cash.ViewModels;
using BarsWeb.Controllers;
using BarsWeb.Infrastructure.Helpers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Cash.Controllers
{
    /// <summary>
    /// Лимиты на счета и МФО
    /// </summary>
    [AuthorizeUser]
    public class LimitsController : ApplicationController
    {
        private readonly ILimitRepository _limitRepository;
        private readonly IMfoRepository _mfoRepository;

        public LimitsController(ILimitRepository limitRepository, IMfoRepository mfoRepository)
        {
            _limitRepository = limitRepository;
            _mfoRepository = mfoRepository;
        }

        /// <summary>
        /// Лимиты (все)
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

        public ActionResult GetAccountLimits(
            [DataSourceRequest] DataSourceRequest request, 
            string limType = null, 
            List<string> mfoList = null)
        {
            try
            {
                IQueryable<V_CLIM_ACCOUNT_LIMIT> dbRecords = _limitRepository.GetAccountLimits();
                if (!string.IsNullOrEmpty(limType))
                {
                    dbRecords = dbRecords.Where(x => x.LIM_TYPE == limType);
                }

                if (mfoList != null && mfoList.Count > 0)
                {
                    dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
                }

                IQueryable<AccountLimit> viewRecords = ModelConverter.ToViewModel(dbRecords);
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult GetAccountLimitsFile(
            string limType = null,
            List<string> mfoList = null)
        {

            IQueryable<V_CLIM_ACCOUNT_LIMIT> dbRecords = _limitRepository.GetAccountLimits();
            if (!string.IsNullOrEmpty(limType))
            {
                dbRecords = dbRecords.Where(x => x.LIM_TYPE == limType);
            }

            if (mfoList != null && mfoList.Count > 0)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }

            IQueryable<AccountLimit> viewRecords = ModelConverter.ToViewModel(dbRecords);
            var excelRows = viewRecords.Select(i => new AccountLimitExcel
            {
                Mfo = i.Mfo,
                MfoName = i.MfoName,
                Branch = i.Branch,
                CashTypeName = i.CashTypeName,
                PrivateAccount = i.PrivateAccount,
                CurrencyCode = i.CurrencyCode,
                AccountName = i.AccountName,
                CurrentLimit = i.CurrentLimit,
                MaxLimit = i.MaxLimit,
                Balance = i.Balance,
                LimitViolatedName = i.LimitViolatedName
            });

            var header = "Ліміти Рахунки-Каса станом на " + DateTime.Now.ToShortDateString();
            var excel = new ExcelHelpers<AccountLimitExcel>(excelRows, true, header);
            return File(excel.ExportToMemoryStream(), "attachment", "LimitsAccCash.xlsx");
        }


        public ActionResult GetAtmLimits(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoList = null)
        {
            IQueryable<AtmLimit> dbRecords = _limitRepository.GetAtmLimits();
            if (mfoList != null && mfoList.Count > 0)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.Kf));
            }
            return Json(dbRecords.ToDataSourceResult(request));
        }

        public ActionResult GetAtmLimitsFile(List<string> mfoList = null)
        {
            IQueryable<AtmLimit> dbRecords = _limitRepository.GetAtmLimits();
            if (mfoList != null && mfoList.Count > 0)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.Kf));
            }

            var excelRows = dbRecords.Select(i=>new AtmLimitExcel
            {
                Kf = i.Kf,
                MfoName = i.MfoName,
                Branch = i.Branch,
                AtmCode = i.AtmCode,
                AccNumber = i.AccNumber,
                Currency = i.Currency,
                Name = i.Name,
                Balance = i.Balance,
                LimitMaxLoad = i.LimitMaxLoad ,
                LimitViolatedName = i.LimitViolatedName 
            }); 

            var header = "Ліміти Рахунки-Банкомати станом на " + DateTime.Now.ToShortDateString();
            var excel = new ExcelHelpers<AtmLimitExcel>(excelRows, true, header);
            return File(excel.ExportToMemoryStream(), "attachment", "LimitsAccAtm.xlsx");
        }

        public ActionResult GetAccMfoLimits(
            [DataSourceRequest] DataSourceRequest request, 
            string mfo,
            decimal? currencyCode,
            string limType = null)
        {
            IQueryable<V_CLIM_ACCOUNT_LIMIT> dbRecords = 
                _limitRepository.GetAccountLimits(mfo)
                    .Where(i=> i.ACC_CURRENCY == currencyCode);
            if (!string.IsNullOrEmpty(limType))
            {
                dbRecords = dbRecords.Where(x => x.LIM_TYPE == limType);
            }
            return Json(dbRecords.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAccBranchLimits(
            [DataSourceRequest] DataSourceRequest request, 
            string mfo, 
            string branch,
            decimal? currencyCode)
        {
            IQueryable<V_CLIM_ACCOUNT_LIMIT> dbRecords = _limitRepository.GetAccountLimits(mfo, branch, currencyCode);
            return Json(dbRecords.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAccBranchLimitsFile(List<string> mfoList = null)
        {
            IQueryable<V_CLIM_ACCOUNT_LIMIT> dbRecords = _limitRepository.GetAccountLimits();
            if (mfoList != null)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }

            var header = "Звіт про порушення лімітів на " + DateTime.Now;
            var excelData = dbRecords.OrderBy(i=>i.KF).ThenBy(i=>i.ACC_BRANCH).ThenBy(i=>i.ACC_CURRENCY).ToList();

            var row = excelData.Select(i => new V_CLIM_ACCOUNT_LIMIT_EXCEL
            {
                ACC_BRANCH = i.ACC_BRANCH,
                KF = i.KF,
                RU_NAME = i.RU_NAME,
                ACC_NUMBER = i.ACC_NUMBER,
                ACC_NAME = i.ACC_NAME,
                ACC_CURRENCY = i.ACC_CURRENCY,
                ACC_BAL = i.ACC_BAL,
                LIM_CURRENT = i.LIM_CURRENT,
                LIM_MAX = i.LIM_MAX,
                ACC_CASHTYPE = i.ACC_CASHTYPE,
                NAME_CASHTYPE = i.NAME_CASHTYPE,
                LIM_TYPE = i.LIM_TYPE,
                ACC_CLOSE_DATE = i.ACC_CLOSE_DATE,
                LIMIT_VIOLATION_NAME = i.LIMIT_VIOLATION_NAME,
                OVER_LIM = i.OVER_LIM,
                PRC_OVERLIM = i.PRC_OVERLIM
            }).ToList();

            var exel = new ExcelHelpers<V_CLIM_ACCOUNT_LIMIT_EXCEL>(row, true, header);

            return File(exel.ExportToMemoryStream(), "attachment", "AccoutsLimits.xlsx");
        }
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult UpdateAccountLimit([DataSourceRequest] DataSourceRequest request, AccountLimit limit)
        {
            if (limit != null && ModelState.IsValid)
            {
                try
                {
                    _limitRepository.SetAccountLimit(limit);
                    var accountLimits = _limitRepository.GetAccountLimits();
                    limit = ModelConverter.ToViewModel(accountLimits).First(x => x.AccountId == limit.AccountId);
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }
            return Json(new[] { limit }.ToDataSourceResult(request, ModelState));
        }

        public ActionResult GetMfoLimits(
            [DataSourceRequest] DataSourceRequest request, 
            string limType = null, 
            List<string> mfoList = null)
        {
            try
            {
                IQueryable<V_CLIM_MFOLIM> dbRecords = _limitRepository.GetMfoLimits();
                if (!string.IsNullOrEmpty(limType))
                {
                    dbRecords = dbRecords.Where(x => x.LIM_TYPE == limType);
                }

                if (mfoList != null && mfoList.Count > 0)
                {
                    dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
                }

                IQueryable<MfoLimit> viewRecords = ModelConverter.ToViewModel(dbRecords);
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }


        public ActionResult GetMfoLimitsFile(
            [DataSourceRequest] DataSourceRequest request,
            string limType = null,
            List<string> mfoList = null)
        {
            IQueryable<V_CLIM_MFOLIM> dbRecords = _limitRepository.GetMfoLimits();
            if (!string.IsNullOrEmpty(limType))
            {
                dbRecords = dbRecords.Where(x => x.LIM_TYPE == limType);
            }

            if (mfoList != null && mfoList.Count > 0)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }

            IQueryable<MfoLimit> viewRecords = ModelConverter.ToViewModel(dbRecords);

            var excelRows = viewRecords.Select(i => new MfoLimitExcel
            {
                Mfo = i.Mfo,
                MfoName = i.MfoName,
                LimitTypeName = i.LimitTypeName,
                CurrencyCode = i.CurrencyCode,
                CurrentLimit = i.CurrentLimit,
                MaxLimit = i.MaxLimit,
                Balance = i.Balance,
                LimitViolatedName = i.LimitViolatedName
            });

            var header = "Ліміти Мфо-Каса станом на " + DateTime.Now.ToShortDateString();

            var excel = new ExcelHelpers<MfoLimitExcel>(excelRows, true, header);

            return File(excel.ExportToMemoryStream(), "attachment", "LimitsMfoCash.xlsx");

        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult UpdateMfoLimit([DataSourceRequest] DataSourceRequest request, MfoLimit limit)
        {
            if (limit != null && ModelState.IsValid)
            {
                try
                {
                    _limitRepository.SetMfoLimit(limit);
                    var dbRows = _limitRepository.GetMfoLimits();
                    var viewRows = ModelConverter.ToViewModel(dbRows);
                    limit = viewRows.First(x => x.Mfo == limit.Mfo && x.LimitType == limit.LimitType && x.CurrencyCode == limit.CurrencyCode);
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { limit }.ToDataSourceResult(request, ModelState));
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