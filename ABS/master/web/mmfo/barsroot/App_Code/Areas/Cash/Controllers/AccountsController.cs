using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Cash.Infrastructure;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.Models.ExportToExcelModels;
using BarsWeb.Areas.Cash.ViewModels;
using BarsWeb.Controllers;
using BarsWeb.Infrastructure.Helpers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Cash.Controllers
{


    /// <summary>
    /// Списки счетов
    /// </summary>
    [AuthorizeUser]
    public class AccountsController : ApplicationController
    {
        private readonly ICenterAccountRepository _centerAccountRepository;
        private readonly IMfoRepository _mfoRepository;

        public AccountsController(ICenterAccountRepository centerAccountRepository, IMfoRepository mfoRepository)
        {
            _centerAccountRepository = centerAccountRepository;
            _mfoRepository = mfoRepository;
        }

        public ViewResult Index()
        {
            List<Mfo> mfoList = _mfoRepository.GetMfos().
                    Select(x => new Mfo { Code = x.MFO, Name = x.NAME })
                    .OrderBy(x => x.Code).ToList();
            return View(mfoList);
        }

        /// <summary>
        /// Cписок счетов
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAccounts([DataSourceRequest] DataSourceRequest request, List<string> mfoList = null)
        {
            try
            {
                // отображаем только открытые счета
                IQueryable<V_CLIM_ACC> dbRecords = _centerAccountRepository.GetAccounts().Where(x => x.ACC_CLOSE_DATE == null);

                if (mfoList != null && mfoList.Count > 0)
                {
                    dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
                }

                IQueryable<Account> viewRecords = ModelConverter.ToViewModel(dbRecords);
                var res = Json(viewRecords.ToDataSourceResult(request));
                res.MaxJsonLength = int.MaxValue;
                return res;
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        /// <summary>
        /// Список остатков по счетам
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAccountsRest(
            [DataSourceRequest] DataSourceRequest request,
            decimal? accountId = null, 
            List<string> mfoList = null,
            string date = "")
        {
            try
            {
                IQueryable<V_CLIM_ACC_ARC> dbRecords = _centerAccountRepository.GetAccountsRest();
                if (mfoList != null && mfoList.Count > 0)
                {
                    dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
                }

                if (accountId.HasValue)
                {
                    dbRecords = dbRecords.Where(x => x.ACC_ID == accountId);
                }

                if (!string.IsNullOrEmpty(date))
                {
                    var balDate = ConvertToDate(date);
                    dbRecords = dbRecords.Where(x => x.BALANCE_DATE == balDate);
                }
                else
                {
                    var balDate = Convert.ToDateTime(DateTime.Today.ToString("dd-MM-yyyy"));
                    dbRecords = dbRecords.Where(x => x.BALANCE_DATE == balDate);
                }

                IQueryable<AccountRest> viewRecords = ModelConverter.ToViewModel(dbRecords);
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }


        public ActionResult GetAccountsRestFile(
            [DataSourceRequest] DataSourceRequest request,
            decimal? accountId = null,
            List<string> mfoList = null,
            string date = "")
        {

            IQueryable<V_CLIM_ACC_ARC> dbRecords = _centerAccountRepository.GetAccountsRest();

            if (mfoList != null && mfoList.Count > 0)
            {
                dbRecords = dbRecords.Where(x => mfoList.Contains(x.KF));
            }

            if (accountId.HasValue)
            {
                dbRecords = dbRecords.Where(x => x.ACC_ID == accountId);
            }

            if (!string.IsNullOrEmpty(date))
            {
                var balDate = ConvertToDate(date);
                dbRecords = dbRecords.Where(x => x.BALANCE_DATE == balDate);
            }
            else
            {
                var balDate = Convert.ToDateTime(DateTime.Today.ToString("dd-MM-yyyy"));
                dbRecords = dbRecords.Where(x => x.BALANCE_DATE == balDate);
            }

            IQueryable<AccountRest> viewRecords = ModelConverter.ToViewModel(dbRecords);

            var listToDataSource = viewRecords.ToDataSourceResult(request);
            List<AccountRest> readyList = new List<AccountRest>();
            foreach (AccountRest item in listToDataSource.Data)
            {
                readyList.Add(item);
            }

            var excelRows = readyList.Select(i => new AccountRestExcel
            {
                Mfo = i.Mfo,
                MfoName = i.MfoName,
                Branch = i.Branch,
                CashType = i.CashType,
                BalNumber = i.BalNumber,
                AccountNumber = i.AccountNumber,
                Ob22 = i.Ob22,
                Currency = i.Currency,
                Balance = i.Balance,
                OpenDate = i.OpenDate,
                BalanceDate = i.BalanceDate
            });

            var header = "Архів залишків по рахунках";
            if (!string.IsNullOrEmpty(date))
            {
                header += " станом на " + ConvertToDate(date).ToShortDateString();
            }
            else
            {
                header += " за весь період";
            }
            var excel = new ExcelHelpers<AccountRestExcel>(excelRows, true, header);
            return File(excel.ExportToMemoryStream(), "attachment", "AccountsRest.xlsx");

        }



        [HttpPost]
        public JsonResult GetAccountsRestData(decimal accountId)
        {
            IQueryable<V_CLIM_ACC_ARC> dbRecords = _centerAccountRepository.GetAccountsRest();
            dbRecords = dbRecords.Where(x => x.ACC_ID == accountId);
            IQueryable<AccountRest> viewRecords = ModelConverter.ToViewModel(dbRecords);
            return Json(viewRecords);
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
        private DateTime ConvertToDate(string date)
        {
            var array = date.Split(' ')[0].Replace(".", "/").Split('/');
            var result = new DateTime(Convert.ToInt32(array[2]),Convert.ToInt32(array[1]), Convert.ToInt32(array[0]));
            return result;
        }

        public ActionResult GetAccountsFile(
            [DataSourceRequest] DataSourceRequest request,
            List<string> mfoStrList,
            string limType = null)
        {
            IQueryable<V_CLIM_ACC> dbRecords = _centerAccountRepository.GetAccounts().Where(x => x.ACC_CLOSE_DATE == null);

            if (mfoStrList != null && mfoStrList.Count > 0)
            {
                dbRecords = dbRecords.Where(x => mfoStrList.Contains(x.KF));
            }

            IQueryable<Account> viewRecords = ModelConverter.ToViewModel(dbRecords);

            var listToDataSource = viewRecords.ToDataSourceResult(request);
            List<Account> readyList = new List<Account>();
            foreach (Account item in listToDataSource.Data)
            {
                readyList.Add(item);
            }

            var excelRows = readyList.Select(i => new AccountRestExcel
            {
                Mfo = i.Mfo,
                MfoName = i.MfoName,
                Branch = i.Branch,
                CashType = i.CashTypeName,
                BalNumber = i.BalNumber,
                AccountNumber = i.AccountNumber,
                Ob22 = i.Ob22,
                Currency = i.Currency,
                Balance = i.Balance,
                OpenDate = i.OpenDate,
                BalanceDate = i.LastDate
            });

            var header = "Рахунки станом на " + DateTime.Now.ToShortDateString();
            var excel = new ExcelHelpers<AccountRestExcel>(excelRows, true, header);
            return File(excel.ExportToMemoryStream(), "attachment", "LimitsAccCash.xlsx");
        }
    }
}