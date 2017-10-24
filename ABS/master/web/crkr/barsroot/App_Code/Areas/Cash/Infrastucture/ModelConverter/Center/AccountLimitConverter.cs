using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {
        public static CLIM_ACCOUNT_LIMIT ToDbModel(AccountLimit viewModel)
        {
            var dbModel = new CLIM_ACCOUNT_LIMIT
            {
                ACC_ID = viewModel.AccountId,
                // в БД значение хранится в копейках
                LIM_CURRENT = viewModel.CurrentLimit == null ? 0 : (decimal)viewModel.CurrentLimit * 100,
                LIM_MAX = viewModel.MaxLimit == null ? 0 : (decimal)viewModel.MaxLimit * 100,
            };
            return dbModel;
        }

        public static IQueryable<AccountLimit> ToViewModel(IQueryable<V_CLIM_ACCOUNT_LIMIT> dbModel)
        {
            return dbModel.Select(x => new AccountLimit
            {
                AccountId = x.ACC_ID,
                // в БД значение хранится в копейках
                //
                CurrentLimit = x.LIM_CURRENT / 100,
                MaxLimit = x.LIM_MAX / 100,
                Balance = x.ACC_BAL / 100,
                AccountName = x.ACC_NAME,
                Mfo = x.KF,
                MfoName = x.RU_NAME,
                CurrencyCode = x.ACC_CURRENCY,
                Branch = x.ACC_BRANCH,
                PrivateAccount = x.ACC_NUMBER,
                CashType = x.ACC_CASHTYPE,
                CashTypeName = x.NAME_CASHTYPE,
                LimitViolated = x.LIMIT_VIOLATION == 1,
                LimitViolatedName = x.LIMIT_VIOLATION_NAME
            });
        }

        public static IQueryable<AtmLimit> ToViewModel(IQueryable<V_CLIM_ATM_LIMIT> dbModel)
        {
            return dbModel.Select(i=> new AtmLimit
            {
                Id= i.ACC_ID,
                AtmCode = i.COD_ATM,
                Branch = i.ACC_BRANCH,
                Kf= i.KF,
                MfoName = i.NAME,
                AccNumber = i.ACC_NUMBER,
                Name = i.ACC_NAME,
                Currency = i.ACC_CURRENCY,
                Balance = i.ACC_BALANCE,
                LimitMaxLoad = i.LIM_MAXLOAD,
                CashType = i.ACC_CASHTYPE,
                ClosedDate = i.ACC_CLOSE_DATE,
                DaysShow = i.DAYS_SHOW,
                Colour = i.COLOUR
            });
        }
    }
}