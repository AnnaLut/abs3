using Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract
{
    public interface IKernelModel
    {
        KernelContext KernelEntities { get; }
    }
}
