using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Cash.Infrastructure;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.Models;
using BarsWeb.Areas.Cash.Models.ExportToExcelModels;
using BarsWeb.Areas.Cash.Models.ViewModels;
using BarsWeb.Areas.Cash.ViewModels;
using BarsWeb.Controllers;
using BarsWeb.Core.Attributes;
using BarsWeb.Infrastructure.Helpers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Cash.Controllers
{
    /// <summary>
    /// Лимиты на счета
    /// </summary>
    [AuthorizeUser]
    public class ViolationsController : ApplicationController
    {
        private readonly ILimitRepository _limitRepository;
        private readonly IMfoRepository _mfoRepository;

        public ViolationsController(ILimitRepository limitRepository, IMfoRepository mfoRepository)
        {
            _limitRepository = limitRepository;
            _mfoRepository = mfoRepository;
        }

        /// <summary>
        /// Нарушения лимитов
        /// </summary>
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

        public ActionResult SelectHistoryPeriodAtm()
        {
            return View();
        }

        public ActionResult SelectHistoryPeriodMfo()
        {
            return View();
        }

        public ActionResult SelectHistoryPeriodBranch()
        {
            return View();
        }
        public ActionResult GetAccountViolations(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoList = null)
        {
            try
            {
                IQueryable<V_CLIM_VIOLATIONS_LIM> dbRecords = _limitRepository.GetAccountLimitViolations();

                if (mfoList != null)
                {
                    dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
                }


                IQueryable<AccountLimitViolation> viewRecords = ModelConverter.ToViewModel(dbRecords);
                return Json(viewRecords.ToDataSourceResult(request),JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult GetAccountViolationsGrp(
            [DataSourceRequest] DataSourceRequest request,
            string branch,
            decimal kv)
        {
            IQueryable<V_CLIM_ACCOUNT_LIMIT> dbRecords = _limitRepository.GetAccountLimits()
                .Where(i=> i.LIM_TYPE == "CASH" && i.ACC_BRANCH == branch && i.ACC_CURRENCY == kv && i.LIMIT_VIOLATION ==1);

            var rows = dbRecords.Select(i => new V_CLIM_ACCOUNT_LIMIT_MD
            {
                ACC_ID = i.ACC_ID,
                ACC_BRANCH = i.ACC_BRANCH,
                KF = i.KF,
                RU_NAME = i.RU_NAME,
                ACC_NUMBER = i.ACC_NUMBER,
                ACC_NAME = i.ACC_NAME,
                ACC_CURRENCY = i.ACC_CURRENCY,
                ACC_BAL = i.ACC_BAL / 100,
                LIM_CURRENT = i.LIM_CURRENT / 100,
                LIM_MAX = i.LIM_MAX / 100,
                ACC_CASHTYPE = i.ACC_CASHTYPE,
                NAME_CASHTYPE = i.NAME_CASHTYPE,
                LIM_TYPE = i.LIM_TYPE,
                //CHECK_FLAG = i.CHECK_FLAG,
                ACC_CLOSE_DATE = i.ACC_CLOSE_DATE,
                PRC_OVERLIM = i.PRC_OVERLIM,
                LIMIT_VIOLATION_NAME = i.LIMIT_VIOLATION_NAME,
                OVER_LIM = i.OVER_LIM / 100
            });

            return Json(rows.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAccountViolationsGrpFile(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoList = null)
        {
            IQueryable<V_CLIM_ACCOUNT_LIMIT> dbRecords = _limitRepository.GetAccountLimits()
                .Where(i=> i.LIM_TYPE == "CASH" && i.LIMIT_VIOLATION == 1);

            if (mfoList != null)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }

            var row = dbRecords.Select(i => new V_CLIM_ACCOUNT_LIMIT_MD
            {
                ACC_ID = i.ACC_ID,
                ACC_BRANCH = i.ACC_BRANCH,
                KF = i.KF,
                RU_NAME = i.RU_NAME,
                ACC_NUMBER = i.ACC_NUMBER,
                ACC_NAME = i.ACC_NAME,
                ACC_CURRENCY = i.ACC_CURRENCY,
                ACC_BAL = i.ACC_BAL / 100,
                LIM_CURRENT = i.LIM_CURRENT / 100,
                LIM_MAX = i.LIM_MAX / 100,
                ACC_CASHTYPE = i.ACC_CASHTYPE,
                NAME_CASHTYPE = i.NAME_CASHTYPE,
                LIM_TYPE = i.LIM_TYPE,
                //CHECK_FLAG = i.CHECK_FLAG,
                ACC_CLOSE_DATE = i.ACC_CLOSE_DATE,
                PRC_OVERLIM = i.PRC_OVERLIM,
                LIMIT_VIOLATION_NAME = i.LIMIT_VIOLATION_NAME,
                OVER_LIM = i.OVER_LIM / 100
            }).OrderBy(i=>i.ACC_BRANCH).ThenBy(i=>i.ACC_CURRENCY).ToList();

            var header = "Звіт про порушення в розрізі рахунків станом на "+ DateTime.Now.ToShortDateString();
            var exel = new ExcelHelpers<V_CLIM_ACCOUNT_LIMIT_MD>(row, true, header);

            return File(exel.ExportToMemoryStream(), "attachment", "MfoAccountsViolations.xlsx");
        }
        public ActionResult GetAtmViolationsTreshold(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoList = null)
        {
            IQueryable<V_CLIM_VIOLATIONS_TRESHOLD> dbRecords =
                _limitRepository.GetAccountViolationsTresholds();
                    //.Where(i=>i.LIM_TYPE == );

                if (mfoList != null)
                {
                    dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
                }

                return Json(dbRecords.ToDataSourceResult(request),JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAtmViolations(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoList = null)
        {
            IQueryable<V_CLIM_ATM_VIOLATION> dbRecords =
                        _limitRepository.GetAtmViolations();

            if (mfoList != null)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }

            var rows = dbRecords.Select(i=> new V_CLIM_ATM_VIOLATION_VM
            {
                ACC_BRANCH = i.ACC_BRANCH,
                ACC_CURRENCY = i.ACC_CURRENCY,
                ACC_ID = i.ACC_ID,
                ACC_NUMBER = i.ACC_NUMBER,
                COD_ATM = i.COD_ATM,
                COLOUR = i.COLOUR,
                FDAT = i.FDAT,
                KF = i.KF,
                LIM_MAXLOAD = i.LIM_MAXLOAD / 100,
                MAXLOAD_VIOLATION = i.MAXLOAD_VIOLATION,
                NAME = i.NAME,
                NAME_VIOLATION = i.NAME_VIOLATION,
                OVER_MAXLOAD = i.OVER_MAXLOAD / 100,
                REF = i.REF,
                S = i.S / 100
            });

            return Json(rows.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAtmViolationsFile(List<string> mfoList = null)
        {
            IQueryable<V_CLIM_ATM_VIOLATION> dbRecords =
                        _limitRepository.GetAtmViolations();

            if (mfoList != null)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }
            var header = "Звіт про порушення по банкоматах на " + DateTime.Now;
            var excelData = dbRecords.Select(i => new AtmViolation
            {
                Colour = i.COLOUR,
                AtmCode = i.COD_ATM,
                Mfo = i.KF,
                MfoName = i.NAME,
                Branch = i.ACC_BRANCH,
                AccNumber = i.ACC_NUMBER,
                AccCurrency = i.ACC_CURRENCY,
                TransactionSumma = i.S / 100,
                Date = i.FDAT,
                LimitMaxLoad = i.LIM_MAXLOAD / 100,
                OverSumma = i.OVER_MAXLOAD / 100//,
                //Balance = i.ACC_BALANCE
            });

            var exel = new ExcelHelpers<AtmViolation>(excelData, true, header);

            return File(exel.ExportToMemoryStream(), "attachment", "AtmViolations.xlsx");
        }
        public ActionResult GetCashViolations(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoList = null)
        {
            IQueryable<V_CLIM_CASH_VIOLATION> dbRecords =
                        _limitRepository.GetCashViolations();

            if (mfoList != null)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }

            return Json(dbRecords.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetCashViolationsFile(List<string> mfoList = null)
        {
            IQueryable<V_CLIM_CASH_VIOLATION> dbRecords =
                        _limitRepository.GetCashViolations();

            if (mfoList != null)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }
            var header = "Звіт про порушення по каса - МФО на " + DateTime.Now;

            var excelData = dbRecords.Select(i => new CashViolation
            {
                Colour = i.COLOUR,
                Mfo = i.KF,
                LimitType = i.LIM_TYPE,
                Currency = i.ACC_CURRENCY,
                LimitCurrent = i.LIM_CURRENT,
                LimitMax = i.LIM_MAX,
                Balance = i.ACC_BAL,
                LimitViolationText = i.LIMIT_VIOLATION == 1 ? "Так" : "Ні",
                OverLimit = i.OVER_LIM 
            }).ToList();

            var exel = new ExcelHelpers<CashViolation>(excelData, true, header);

            return File(exel.ExportToMemoryStream(), "attachment", "CashViolations.xlsx");
        }

        public ActionResult GetCashViolationsBranchKv(
            [DataSourceRequest] DataSourceRequest request,
            string branch,
            decimal? kv)
        {
            IQueryable<V_CLIM_ACCOUNT_LIMIT> dbRecords = _limitRepository.GetAccountLimits()
                .Where(i => i.ACC_BRANCH == branch && i.ACC_CURRENCY == kv);

            var rows = dbRecords.Select(i=>new V_CLIM_ACCOUNT_LIMIT_VM
            {
                ACC_ID = i.ACC_ID,
                KF = i.KF,
                RU_NAME = i.RU_NAME,
                ACC_BRANCH = i.ACC_BRANCH,
                LIM_TYPE = i.LIM_TYPE,
                ACC_NUMBER = i.ACC_NUMBER,
                ACC_NAME = i.ACC_NAME,
                ACC_CURRENCY = i.ACC_CURRENCY,
                LIM_CURRENT = i.LIM_CURRENT / 100,
                LIM_MAX = i.LIM_MAX / 100,
                ACC_BAL = i.ACC_BAL / 100,
                OVER_LIM = i.OVER_LIM / 100,
                PRC_OVERLIM = i.PRC_OVERLIM,
                ACC_CASHTYPE = i.ACC_CASHTYPE,
                NAME_CASHTYPE = i.NAME_CASHTYPE,
                ACC_CLOSE_DATE = i.ACC_CLOSE_DATE,
                LIMIT_VIOLATION = i.LIMIT_VIOLATION,
                LIMIT_VIOLATION_NAME = i.LIMIT_VIOLATION_NAME,


                ACC_BALANCE = i.ACC_BALANCE,
                ACC_OB22 = i.ACC_OB22,
                ACC_OPEN_DATE = i.ACC_OPEN_DATE,
                CHECK_FLAG = i.CHECK_FLAG
            });

            return Json(rows.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);

        }

        public ActionResult GetCashViolationsBranchKvConsolidateFile()
        {

            IQueryable<V_CLIM_ACCOUNT_LIMIT> dbRecords = _limitRepository.GetAccountLimits();

            var excelData = dbRecords.Select(i => new V_CLIM_CASH_VIOLATION_EXCEL
            {
                MFO = i.KF,
                NAME = i.RU_NAME,
                ACC_BRANCH = i.ACC_BRANCH,
                LIM_TYPE = i.LIM_TYPE,
                ACC_NUMBER = i.ACC_NUMBER,
                ACC_NAME = i.ACC_NAME,
                ACC_CURRENCY = i.ACC_CURRENCY,
                ACC_BAL = i.ACC_BAL / 100,
                LIM_CURRENT = i.LIM_CURRENT / 100,
                LIM_MAX = i.LIM_MAX / 100,
                OVER_LIM = i.OVER_LIM / 100,
                PRC_OVERLIM = i.PRC_OVERLIM /*,
                DIFF_DAYS = i.DIFF_DAYS ,
                PERCENT_DEV = i.PERCENT_DEV ,
                DAYS_VIOL = i.DAYS_VIOL*/
            }).ToList().OrderBy(i => i.ACC_BRANCH).ThenBy(i => i.ACC_CURRENCY);

            var header = "Звіт про порушення в розрізі рахунків станом на " + DateTime.Now.ToShortDateString();
            var exel = new ExcelHelpers<V_CLIM_CASH_VIOLATION_EXCEL>(excelData, true, header);

            return File(exel.ExportToMemoryStream(), "attachment", "BranchAccountsViolations.xlsx");
        }

        public ActionResult GetCashBranchViolations(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoList = null)
        {
            IQueryable<V_CLIM_CASHBRANCH_VIOLATION> dbRecords =
                        _limitRepository.GetCashBranchViolations();

            if (mfoList != null)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }

            var rows = dbRecords.Select(i=> new V_CLIM_CASHBRANCH_VIOLATION_VM
            {
                STARTD_VIOL = i.STARTD_VIOL,
                MAXD_VIOL = i.MAXD_VIOL,
                DIFF_DAYS = i.DIFF_DAYS,
                KF = i.KF,
                RU_NAME = i.RU_NAME,
                ACC_BRANCH = i.ACC_BRANCH,
                ACC_CURRENCY = i.ACC_CURRENCY,
                ACC_CNT = i.ACC_CNT,
                SUM_BAL = i.SUM_BAL / 100,
                SUM_LIM = i.SUM_LIM /100,
                SUM_LIMMAX = i.SUM_LIMMAX / 100,
                PERCENT_DEV = i.PERCENT_DEV,
                DAYS_VIOL = i.DAYS_VIOL,
                COLOUR = i.COLOUR,
                PERIOD_START = i.PERIOD_START,
                TRESHOLD_VIOLATION = i.TRESHOLD_VIOLATION,
                SUM_OVERTRESHOLD = i.SUM_OVERTRESHOLD / 100,
                BDATE = i.BDATE,
                PRC_OVERLIM = i.PRC_OVERLIM
            });

            return Json(rows.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetCashBranchViolationsFile(List<string> mfoList = null)
        {
            IQueryable<V_CLIM_CASHBRANCH_VIOLATION> dbRecords =
                        _limitRepository.GetCashBranchViolations();

            if (mfoList != null)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }
            var header = "Звіт про порушення по каса - ТВБВ на " + DateTime.Now;

            var excelData = dbRecords.Select(i => new CashBranchViolation
            {
                Colour = i.COLOUR,
                Mfo = i.KF,
                RuName = i.RU_NAME,
                Branch = i.ACC_BRANCH,
                Currency = i.ACC_CURRENCY,
                AccCount = i.ACC_CNT,
                Balance = i.SUM_BAL / 100,
                LimitCurrent = i.SUM_LIM / 100,
                LimitMax = i.SUM_LIMMAX / 100,
                PercentDev = i.PERCENT_DEV,
                PrcOverLim = i.PRC_OVERLIM,
                DaysCountViolation = i.DIFF_DAYS,
                DaysViol = i.DAYS_VIOL,
                LimitViolationText = i.TRESHOLD_VIOLATION == 1 ? "Так" : "Ні",
                OverLimit = i.SUM_OVERTRESHOLD / 100
            }).ToList();

            var exel = new ExcelHelpers<CashBranchViolation>(excelData, true, header);

            return File(exel.ExportToMemoryStream(), "attachment", "CashBranchViolations.xlsx");
        }

        public ActionResult GetAccountViolationsTreshold(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoList = null)
        {
            //try
            //{
                IQueryable<V_CLIM_VIOLATIONS_TRESHOLD> dbRecords = _limitRepository.GetAccountViolationsTresholds();

                if (mfoList != null)
                {
                    dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
                }

                return Json(dbRecords.ToDataSourceResult(request),JsonRequestBehavior.AllowGet);
            /*}
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }*/
            }

        public ActionResult GetAccountViolationsTresholdFile(List<string> mfoList = null)
        {
            string filename = "AccountViolationsTreshold.xlsx";
            var limDist = _limitRepository.GetAccountViolationsTresholds()
                .Select(i=>new V_CLIM_VIOLATIONS_TRESHOLD
                {
                    ACC_ID = i.ACC_ID,
                    KF = i.KF
                })
                .OrderBy(i => i.ACC_BRANCH)
                .ToList();

            var exel = new ExcelHelpers<V_CLIM_VIOLATIONS_TRESHOLD>(limDist, c => c.KF, true);

            return File(exel.ExportToMemoryStream(), "attachment" ,filename);
        }

        public ActionResult GetMfoViolations(
            [DataSourceRequest] DataSourceRequest request, 
            List<string> mfoList = null, 
            bool? violationStatus = null)
        {
            //try
            //{
                IQueryable<V_CLIM_MFOLIM> dbRecords = _limitRepository.GetMfoLimits();

                if (mfoList != null && mfoList.Count > 0)
                {
                    dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
                }

                IQueryable<MfoLimit> viewRecords = ModelConverter.ToViewModel(dbRecords);

                if (violationStatus.HasValue)
                {
                    viewRecords = viewRecords.Where(x => x.LimitViolated == violationStatus.Value);
                }

                return Json(viewRecords.ToDataSourceResult(request));
            /*}
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }*/
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult UpdateAccountLimit([DataSourceRequest] DataSourceRequest request, AccountLimitViolation limit)
        {
            if (limit != null && ModelState.IsValid)
            {
                try
                {
                    _limitRepository.SetAccountLimit(limit.AccountId, limit.CurrentLimit, limit.MaxLimit);
                    var dbRows = _limitRepository.GetAccountLimitViolations();
                    var viewRows = ModelConverter.ToViewModel(dbRows);
                    var updatedRow = viewRows.First(x => x.AccountId == limit.AccountId);
                    limit = updatedRow;
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { limit }.ToDataSourceResult(request, ModelState));
        }

        public JsonResult GetCashViolGrpMfoKv(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoList = null)
        {
            IQueryable<V_CLIM_MFOLIM> dbRecords =
            _limitRepository.GetCashViolGrpMfoKv();

            if (mfoList != null)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }

            var rows = dbRecords.Select(i => new V_CLIM_MFOLIM_MD
            {
                KF = i.KF,
                RU_NAME = i.RU_NAME,
                LIM_NAME = i.LIM_NAME,
                KV = i.KV,
                LIM_CURRENT = i.LIM_CURRENT / 100,
                LIM_MAX = i.LIM_MAX / 100,
                SUM_BAL = i.SUM_BAL / 100,
                OVER_LIM = i.OVER_LIM / 100,
                PRC_OVER_LIM = i.PRC_OVER_LIM,
                LIMIT_VIOLATION_NAME = i.LIMIT_VIOLATION_NAME
            });

            return Json(rows.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetCashViolGrpMfoKvFile(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoList = null)
        {
            var filename = "CashViolGrpMfoKv.xlsx";

            IQueryable<V_CLIM_MFOLIM> dbRecords =
            _limitRepository.GetCashViolGrpMfoKv();

            if (mfoList != null)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }

            var rows = dbRecords.Select(i=>new V_CLIM_MFOLIM_MD
            {
                KF = i.KF,
                RU_NAME = i.RU_NAME,
                LIM_NAME = i.LIM_NAME,
                KV = i.KV,
                LIM_CURRENT = i.LIM_CURRENT / 100,
                LIM_MAX = i.LIM_MAX / 100,
                SUM_BAL = i.SUM_BAL / 100,
                OVER_LIM = i.OVER_LIM / 100,
                PRC_OVER_LIM = i.PRC_OVER_LIM,
                LIMIT_VIOLATION_NAME = i.LIMIT_VIOLATION_NAME
            });
            var header = "Порушення Каса - МФО станом на " + DateTime.Now.ToShortDateString();
            var exel = new ExcelHelpers<V_CLIM_MFOLIM_MD>(rows,true, header);

            return File(exel.ExportToMemoryStream(), "attachment", filename);
        }

        public JsonResult GetCashViolGrpBranchKv(
            [DataSourceRequest] DataSourceRequest request,
            string kf,
            decimal kv)
        {
            IQueryable<V_CLIM_CASHVIOL_GRPBRANCHKV> dbRecords =
                _limitRepository.GetCashViolGrpBranchKv(kf,kv);
            var rows = dbRecords.Select(i => new V_CLIM_CASHVIOL_GRPBRANCHKV_VM
                    {
                        KF = i.KF,
                        RU_NAME = i.RU_NAME,
                        ACC_BRANCH = i.ACC_BRANCH,
                        ACC_CURRENCY = i.ACC_CURRENCY,
                        SUM_BAL = i.SUM_BAL /100,
                        SUM_LIM = i.SUM_LIM / 100,
                        SUM_LIMMAX = i.SUM_LIMMAX /100,
                        SUM_OVERLIM = i.SUM_OVERLIM / 100,
                        CNT_ACCS = i.CNT_ACCS,
                        PRC_OVER_LIM = i.PRC_OVER_LIM
                    });

            return Json(rows.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Отримати історію порушень на МФО
        /// </summary>
        /// <param name="request"></param>
        /// <param name="mfo">МФО</param>
        /// <param name="currencyCode">код валюти</param>
        /// <returns></returns>
        public ActionResult GetMfoLimitArc(
            [DataSourceRequest] DataSourceRequest request,
            string mfo,
            decimal? currencyCode)
        {
            var result = _limitRepository.GetMfoLimitArc(mfo);
            if (currencyCode != null)
            {
                result = result.Where(i => i.KV == currencyCode);
            }
            return Json(result.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetMfoLimitArcPeriodFile(
            [DataSourceRequest] DataSourceRequest request,
            [DateBinder] DateTime? dateStart,
            [DateBinder] DateTime? dateEnd)
        {
            dateStart = dateStart ?? DateTime.Now.Date;
            dateEnd = dateEnd ?? DateTime.Now.Date;

            var result = _limitRepository.GetMfoLimitArc(dateStart, dateEnd);
            var rows = result.Select(i => new V_CLIM_MFO_LIMIT_ARC_MD
            {
                KF = i.KF,
                KV = i.KV,
                LIM_DATE = i.LIM_DATE,
                SUM_BAL_SHARE = i.SUM_BAL_SHARE,
                LIM_CURRENT_SHARE = i.LIM_CURRENT_SHARE,
                LIM_MAX_SHARE = i.LIM_MAX_SHARE,
                NAME_VIOLATION = i.NAME_VIOLATION
            }).OrderBy(i=>i.KF).ThenBy(i=>i.KV).ThenBy(i=>i.LIM_DATE);


            var header = string.Format("Історія порушень по відділенніях за період з {0} по {1}",
                dateStart == null ? "" : dateStart.Value.ToShortDateString(),
                dateEnd == null ? "" : dateEnd.Value.ToShortDateString());

            var exel = new ExcelHelpers<V_CLIM_MFO_LIMIT_ARC_MD>(rows, true, header);

            return File(exel.ExportToMemoryStream(), "attachment", "BranchLimitArcPeriod.xlsx");
        }

        /// <summary>
        /// Отримати історію порушень на Бранч
        /// </summary>
        /// <param name="request"></param>
        /// <param name="branch">Бранч</param>
        /// <param name="currencyCode">код валюти</param>
        /// <returns></returns>
        public ActionResult GetBranchLimitArc(
            [DataSourceRequest] DataSourceRequest request,
            string branch,
            decimal? currencyCode)
        {
            var result = _limitRepository.GetBranchLimitArc(branch);
            if (currencyCode != null)
            {
                result = result.Where(i => i.ACC_CURRENCY == currencyCode);
            }
            return Json(result.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Get branches limits archive
        /// </summary>
        /// <param name="request"></param>
        /// <param name="dateStart">Date start</param>
        /// <param name="dateEnd">Date end</param>
        /// <returns></returns>
        public ActionResult GetBranchLimitArcPeriodFile(
            [DataSourceRequest] DataSourceRequest request,
            [DateBinder] DateTime? dateStart,
            [DateBinder] DateTime? dateEnd)
        {
            dateStart = dateStart ?? DateTime.Now.Date;
            dateEnd = dateEnd ?? DateTime.Now.Date;

            var result = _limitRepository.GetBranchLimitArc(dateStart, dateEnd);
            var rows = result.Select(i=> new V_CLIM_BRANCH_LIMIT_ARC_MD
            {
                KF=i.KF,
                ACC_BRANCH = i.ACC_BRANCH,
                ACC_CURRENCY = i.ACC_CURRENCY,
                LDAT = i.LDAT,
                SUM_BAL_SHARE = i.SUM_BAL_SHARE,
                SUM_LIM_SHARE = i.SUM_LIM_SHARE,
                SUM_LIMMAX_SHARE = i.SUM_LIMMAX_SHARE,
                SUM_OVERTRESHOLD_SHARE = i.SUM_OVERTRESHOLD_SHARE,
                NAME_VIOLATION = i.NAME_VIOLATION,
				PRC_OVERLIM = i.PRC_OVERLIM,
				DIFF_DAYS = i.DIFF_DAYS,
				PERCENT_DEV = i.PERCENT_DEV,
				DAYS_VIOL = i.DAYS_VIOL,
                DIFF_DAYS_LIM = i.DIFF_DAYS_LIM
            }).OrderBy(i => i.KF).ThenBy(i => i.ACC_BRANCH).ThenBy(i => i.ACC_CURRENCY).ThenBy(i=>i.LDAT);


            var header = string.Format("Історія порушень по відділенніях за період з {0} по {1}",
                dateStart == null ? "" : dateStart.Value.ToShortDateString(),
                dateEnd == null ? "" : dateEnd.Value.ToShortDateString());

            var exel = new ExcelHelpers<V_CLIM_BRANCH_LIMIT_ARC_MD>(rows, true, header);

            return File(exel.ExportToMemoryStream(), "attachment", "BranchLimitArcPeriod.xlsx");
        }

        /// <summary>
        /// Отримати історію порушень по рахунку
        /// </summary>
        /// <param name="request"></param>
        /// <param name="accId"></param>
        /// <returns></returns>
        public ActionResult GetAccountLimitArc(
            [DataSourceRequest] DataSourceRequest request,
            decimal accId)
        {
            var result = _limitRepository.GetAccountLimitArc(accId);

            return Json(result.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAtmLimitArc(
            [DataSourceRequest] DataSourceRequest request,
            string atmCode)
        {
            var result = _limitRepository.GetAtmLimitArc(atmCode);

            return Json(result.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAtmLimitArcPeriodFile(
            [DataSourceRequest] DataSourceRequest request,
            [DateBinder] DateTime? dateStart,
            [DateBinder] DateTime? dateEnd)
        {
            dateStart = dateStart ?? DateTime.Now.Date;
            dateEnd = dateEnd ?? DateTime.Now.Date;

            var dbRecords = _limitRepository.GetAtmLimitArc(dateStart, dateEnd);
            var excelData = dbRecords.Select(i => new AtmViolation
            {
                Mfo = i.KF,
                MfoName = i.NAME,
                Branch = i.ACC_BRANCH,
                AtmCode = i.COD_ATM,
                AccNumber = i.ACC_NUMBER,
                AccCurrency = i.ACC_CURRENCY,
                TransactionSumma = i.S_SHARE,
                Date = i.FDAT,
                LimitMaxLoad = i.LIM_MAXLOAD_SHARE,
                OverSumma = i.OVER_MAXLOAD_SHARE//,
                //Balance = i.ACC_BALANCE
            });


            var header = string.Format("Історія порушень по банкоматах за період з {0} по {1}",
                dateStart == null ? "" : dateStart.Value.ToShortDateString(),
                dateEnd == null ? "" : dateEnd.Value.ToShortDateString());

            var exel = new ExcelHelpers<AtmViolation>(excelData, true, header);

            return File(exel.ExportToMemoryStream(), "attachment", "BranchLimitArcPeriod.xlsx");
        }

        public ActionResult GetAcctLimitArcPeriodFile(
            [DataSourceRequest] DataSourceRequest request,
            [DateBinder] DateTime? dateStart,
            [DateBinder] DateTime? dateEnd)
        {
            dateStart = dateStart ?? DateTime.Now.Date;
            dateEnd = dateEnd ?? DateTime.Now.Date;

            var result = _limitRepository.GetAccountLimitArc(dateStart, dateEnd);
            var rows = result.Select(i => new V_CLIM_ACCOUNT_LIMIT_ARC_MD
            {
                KF = i.KF,
                KF_NAME = i.KF_NAME,
                ACC_BRANCH = i.ACC_BRANCH,
                ACC_NUMBER = i.ACC_NUMBER,
                ACC_NAME = i.ACC_NAME,
                ACC_CURRENCY = i.ACC_CURRENCY,
                LDAT = i.LDAT,
                LIM_CURRENT_SHARE = i.LIM_CURRENT_SHARE,
                LIM_MAX_SHARE = i.LIM_MAX_SHARE,
                ACC_BAL_SHARE = i.ACC_BAL_SHARE,
                SUM_OVERTRESHOLD_SHARE = i.SUM_OVERTRESHOLD_SHARE,
                PRC_OVERLIM = i.PRC_OVERLIM,
                NAME_VIOLATION = i.NAME_VIOLATION,
                DIFF_DAYS = i.DIFF_DAYS
            }).OrderBy(i => i.KF).ThenBy(i => i.ACC_BRANCH).ThenBy(i=>i.ACC_NUMBER).ThenBy(i => i.ACC_CURRENCY).ThenBy(i => i.LDAT);


            var header = string.Format("Історія порушень по рахунках за період з {0} по {1}",
                dateStart == null ? "" : dateStart.Value.ToShortDateString(),
                dateEnd == null ? "" : dateEnd.Value.ToShortDateString());

            var exel = new ExcelHelpers<V_CLIM_ACCOUNT_LIMIT_ARC_MD>(rows, true, header);

            return File(exel.ExportToMemoryStream(), "attachment", "AccountsLimitArcPeriod.xlsx");
        }

        private JsonResult DataSourceErrorResult(Exception ex)
        {
            return Json(new DataSourceResult
            {
                Errors = new
                {
                    message = ex.ToString()
                }
            });
        }
    }
}