using Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation
{
    public class UpdateHistoryRepository : IUpdateHistoryRepository
    {
        private readonly KernelContext _entities;
        public UpdateHistoryRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("Kernel", "Kernel");
            _entities = new KernelContext(connectionStr); 
        }

        public UpdateHistoryRepository(IKernelModel model)
        {
            _entities = model.KernelEntities;
        }

        public int InsertUpdateInfo(BarsUpdateInfo updInfo)
        {
            return _entities.KRN_INSTALL_MGR_INS_UPD_HIST(
                updInfo.Name,
                updInfo.Hash,
                updInfo.Log,
                updInfo.ModuleName,
                updInfo.Date,
                updInfo.HostName,
                updInfo.UserName,
                1);
        }
        public int InsertModuleVersion(BarsUpdateInfo updInfo)
        {
            return _entities.KRN_INSTALL_MGR_INS_MODULE_VERSION(
                updInfo.ModuleName,
                updInfo.Version, 
                updInfo.Log, 
                updInfo.HostName, 
                updInfo.UserName, 
                updInfo.Date, 
                updInfo.Hash);
        }
    }
}