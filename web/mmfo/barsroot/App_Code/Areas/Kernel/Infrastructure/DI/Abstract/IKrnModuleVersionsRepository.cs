using Areas.Kernel.Models;
using System.Linq;

namespace BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract
{
    public interface IKrnModuleVersionsRepository
    {
        IQueryable<KRN_MODULE_VERSIONS> GetKrnModuleVersionsList();
    }
}
