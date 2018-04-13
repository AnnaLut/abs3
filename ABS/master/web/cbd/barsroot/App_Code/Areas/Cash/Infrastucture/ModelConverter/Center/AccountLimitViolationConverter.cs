using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {
        public static IQueryable<AccountLimitViolation> ToViewModel(IQueryable<V_CLIM_VIOLATIONS_LIM> dbModel)
        {
            return dbModel.Select(x => new AccountLimitViolation
            {
                AccountId = x.ACC_ID,
                // в БД значение хранится в копейках
                //
                CurrentLimit = x.LIM_CURRENT / 100,
                MaxLimit = x.LIM_MAX / 100,
                AccountName = x.ACC_NAME,
                Mfo = x.KF,
                CurrencyCode = x.ACC_CURRENCY,
                Branch = x.ACC_BRANCH,
                PrivateAccount = x.ACC_NUMBER,
                CashType = x.ACC_CASHTYPE,
                CashTypeName = x.NAME_CASHTYPE,
                Balance = x.ACC_BAL / 100,
                DateStart = x.DAT_BEGIN,
            });
        }
    }
}