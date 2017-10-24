using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {
        public static IQueryable<SyncResult> ToViewModel(IQueryable<CLIM_PROTOCOL> dbModel)
        {
            return dbModel.Select(x => new SyncResult
            {
                ID = x.ID,
                ParentId = x.PARENT_ID,
                Mfo = x.KF,
                DateStart = x.TRANSFER_DATE_START,
                DateEnd = x.TRANSFER_DATE_END,
                BankDate = x.TRANSFER_BDATE,
                TransferType = x.TRANSFER_TYPE,
                URL = x.URL,
                Message = x.COMM ?? "",
                RowsSucceed = x.PROCESSED_ROWS,
                RowsTotal = x.TRANSFER_ROWS,
                Status = x.TRANSFER_RESULT,
                RowLevel = x.ROW_LEVEL ?? 0
            });
        }
    }
}