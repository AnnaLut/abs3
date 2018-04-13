using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface IUpdateHistoryRepository
    {
        int InsertUpdateInfo(BarsUpdateInfo updInfo);

        int InsertModuleVersion(BarsUpdateInfo updInfo);
    }
}