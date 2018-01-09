using Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Implementation
{
    public class KernelModel : IKernelModel
    {
        private KernelContext _entities;
        public KernelContext KernelEntities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("Kernel","Kernel");
                return _entities ?? new KernelContext(connectionStr);
            }
        }
    }
}
