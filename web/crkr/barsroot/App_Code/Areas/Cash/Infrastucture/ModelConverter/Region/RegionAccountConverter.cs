using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.Sync;
using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {
        public static IQueryable<RegionAccount> ToViewModel(IQueryable<V_CLIM_ACCOUNTS> dbModel)
        {
            return dbModel.Select(x => new RegionAccount
            {
                AccountId = x.ACC_ID,
                AccountName = x.ACC_NAME,
                AccountNumber = x.ACC_NUMBER,
                BalNumber = x.ACC_BALNUMBER,
                Balance = x.ACC_BALANCE,
                Branch = x.BRANCH,
                CashType = x.ACC_CASHTYPE,
                Mfo = x.MFO,
                Ob22 = x.ACC_OB22,
                Currency = x.ACC_CURRENCY,
                //AccMaxLoad = x.ACC_MAXLOAD,
                OpenDate = x.ACC_OPEN_DATE,
                CloseDate = x.ACC_CLOSE_DATE,
                LastUpdateDate = x.ACC_DAPP
            });
        }
    }
}