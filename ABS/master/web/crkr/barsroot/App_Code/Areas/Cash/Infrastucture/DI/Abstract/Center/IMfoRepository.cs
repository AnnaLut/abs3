using System.Linq;
using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center
{
    public interface IMfoRepository
    {
        /// <summary>
        /// Получить список МФО
        /// </summary>
        IQueryable<CLIM_MFO> GetMfos();
    }
}