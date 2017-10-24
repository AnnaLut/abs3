using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {
        public static CLIM_MFO_LIMIT ToDbModel(MfoLimit viewModel)
        {
            var dbModel = new CLIM_MFO_LIMIT
            {
                KV = viewModel.CurrencyCode,
                KF = viewModel.Mfo,
                LIM_TYPE = viewModel.LimitType,
                // в БД значение хранится в копейках
                LIM_CURRENT = viewModel.CurrentLimit == null ? 0 : (decimal)viewModel.CurrentLimit * 100,
                LIM_MAX = viewModel.MaxLimit == null ? 0 : (decimal)viewModel.MaxLimit * 100
            };
            return dbModel;
        }

        public static IQueryable<MfoLimit> ToViewModel(IQueryable<V_CLIM_MFOLIM> dbModel)
        {
            return dbModel.Select(x => new MfoLimit
            {
                Mfo = x.KF,
                MfoName = x.RU_NAME,
                LimitType = x.LIM_TYPE,
                LimitTypeName = x.LIM_NAME,
                CurrencyCode = x.KV,
                // в БД значение хранится в копейках
                //
                CurrentLimit = x.LIM_CURRENT / 100,
                MaxLimit = x.LIM_MAX / 100,
                Balance = x.SUM_BAL / 100,
                LimitViolated = x.LIMIT_VIOLATION == 1,
                LimitViolatedName = x.LIMIT_VIOLATION_NAME
            });
        }
    }
}