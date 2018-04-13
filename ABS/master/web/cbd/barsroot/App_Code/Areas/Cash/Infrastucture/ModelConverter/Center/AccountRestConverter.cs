using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {
        public static IQueryable<AccountRest> ToViewModel(IQueryable<V_CLIM_ACC_ARC> dbModel)
        {
            return dbModel.Select(x => new AccountRest
            {
                AccountId = x.ACC_ID,
                // в БД значение хранится в копейках
                Balance = x.ACC_BAL == null ? 0 : x.ACC_BAL / 100,
                Mfo = x.KF,
                MfoName = x.RU_NAME,
                Currency = x.ACC_CURRENCY,
                Branch = x.ACC_BRANCH,
                AccountName = x.ACC_NAME,
                CashType = x.ACC_CASHTYPE,
                CloseDate = x.ACC_CLOSE_DATE,
                AccountNumber = x.ACC_NUMBER,
                AccountSourceId = x.ACC_SOURCEID,
                BalNumber = x.ACC_BALNUMBER,
                Ob22 = x.ACC_OB22,
                OpenDate = x.ACC_OPEN_DATE,
                BalanceDate = x.BALANCE_DATE
            });
        }
    }
}