using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {
        public static IQueryable<Account> ToViewModel(IQueryable<V_CLIM_ACC> dbModel)
        {
            return dbModel.Select(x => new Account
            {
                AccountId = x.ACC_ID,
                AccountName = x.ACC_NAME,
                AccountNumber = x.ACC_NUMBER,
                BalNumber = x.ACC_BALNUMBER,
                // в БД значение хранится в копейках
                Balance = x.ACC_BAL == null ? 0 : x.ACC_BAL / 100,
                Branch = x.ACC_BRANCH,
                CashType = x.ACC_CASHTYPE,
                CashTypeName = x.NAME,
                Mfo = x.KF,
                MfoName = x.RU_NAME,
                Ob22 = x.ACC_OB22,
                Currency = x.ACC_CURRENCY,
                OpenDate = x.ACC_OPEN_DATE,
                CloseDate = x.ACC_CLOSE_DATE,
                AccountSourceId = x.ACC_SOURCEID,
                LastDate = x.LAST_DATE
            });
        }
    }
}