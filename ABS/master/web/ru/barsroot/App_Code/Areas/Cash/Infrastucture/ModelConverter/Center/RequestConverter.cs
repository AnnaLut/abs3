using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {

        public static CLIM_REQUEST ToDbModel(Request viewModel)
        {
            var dbModel = new CLIM_REQUEST
            {
                ACC_ID = viewModel.AccountId,
                APR_DATE = viewModel.ApproveDate,
                APR_STAFF_ID = viewModel.ApproveStaffId,
                // денежные значения хранятся в копейках
                //
                LIM_CURRENT = viewModel.CurrentLimit * 100,
                LIM_MAX = viewModel.MaxLimit * 100,
                LIM_MAXLOAD = viewModel.MaxLoadLimit * 100,
                REQ_DATE = viewModel.RequestDate,
                REQ_ID = viewModel.ID,
                REQ_STAFF_ID = viewModel.RequestStaffId,
                REQ_STATUS = viewModel.RequestStatus
            };
            return dbModel;
        }

        // todo Обратить внимание! Методы дублируют друг друга
        public static Request ToViewModel(V_CLIM_REQUEST dbModel)
        {
            var viewModel = new Request
            {
                AccountId = dbModel.ACC_ID,
                ID = dbModel.REQ_ID,
                ApproveDate = dbModel.APR_DATE,
                ApproveStaffId = dbModel.APR_STAFF_ID,
                ApproveStaffName = dbModel.APR_STAFF_FIO,
                CurrencyCode = dbModel.ACC_CURRENCY,
                // денежные значения хранятся в копейках
                //
                CurrentLimit = dbModel.LIM_CURRENT == null ? null : dbModel.LIM_CURRENT / 100,
                MaxLimit = dbModel.LIM_MAX == null ? null : dbModel.LIM_MAX / 100,
                MaxLoadLimit = dbModel.LIM_MAXLOAD== null ? null : dbModel.LIM_MAXLOAD / 100,
                RequestDate = dbModel.REQ_DATE,
                RequestStaffId = dbModel.REQ_STAFF_ID,
                RequestStaffName = dbModel.REQ_STAFF_FIO,
                RequestStatus = dbModel.REQ_STATUS,
                RequestStatusName = dbModel.REQ_STATUS_NAME,
                Branch = dbModel.ACC_BRANCH,
                Mfo = dbModel.KF,
                MfoName = dbModel.RU_NAME,
                LimitType = dbModel.ACC_CASHTYPE,
                PrivateAccount = dbModel.ACC_NUMBER
            };
            return viewModel;
        }

        // todo Обратить внимание! Методы дублируют друг друга
        public static IQueryable<Request> ToViewModel(IQueryable<V_CLIM_REQUEST> dbModel)
        {
            return dbModel.Select(x => new Request
            {
                AccountId = x.ACC_ID,
                ID = x.REQ_ID,
                ApproveDate = x.APR_DATE,
                ApproveStaffId = x.APR_STAFF_ID,
                ApproveStaffName = x.APR_STAFF_FIO,
                CurrencyCode = x.ACC_CURRENCY,
                // денежные значения хранятся в копейках
                //
                CurrentLimit = x.LIM_CURRENT == null ? null : x.LIM_CURRENT / 100,
                MaxLimit = x.LIM_MAX == null ? null : x.LIM_MAX / 100,
                MaxLoadLimit = x.LIM_MAXLOAD == null ? null : x.LIM_MAXLOAD / 100,
                RequestDate = x.REQ_DATE,
                RequestStaffId = x.REQ_STAFF_ID,
                RequestStaffName = x.REQ_STAFF_FIO,
                RequestStatus = x.REQ_STATUS,
                RequestStatusName = x.REQ_STATUS_NAME,
                Mfo = x.KF,
                MfoName = x.RU_NAME,
                Branch = x.ACC_BRANCH,
                LimitType = x.ACC_CASHTYPE,
                PrivateAccount = x.ACC_NUMBER
            });
        }
    }
}