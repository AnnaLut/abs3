using System.Collections.Generic;
using BarsWeb.Areas.LimitControl.ViewModels;

namespace BarsWeb.Areas.LimitControl.Infrastucture.DI.Abstract
{
    public interface ILimitRepository
    {
        LcsServices.LimitStatus GetLimitStatus(LimitSearchInfo searchInfo);

        List<Transfer> GetTransfers(TransferSearchInfo searchInfo);

        ConformationResponse ConfirmTransfers(TransferSearchInfo searchInfo, List<string> transfers, string userName);
    }
}
