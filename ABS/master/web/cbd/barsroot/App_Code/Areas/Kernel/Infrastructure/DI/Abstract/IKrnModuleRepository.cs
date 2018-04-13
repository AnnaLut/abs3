using Areas.Kernel.Models;
using System.Linq;

namespace BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract
{
    public interface IKrnModuleRepository
    {
        IQueryable<KRN_MODULE_VRS_HIST> GetKrnModuleList();
    }
}
