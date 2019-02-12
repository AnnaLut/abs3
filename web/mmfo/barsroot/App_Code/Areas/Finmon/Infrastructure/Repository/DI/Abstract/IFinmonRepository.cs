using System.Linq;
using Areas.Finmon.Models;

namespace BarsWeb.Areas.Finmon.Infrastructure.Repository.DI.Abstract
{
    public interface IFinmonRepository
    {
        IQueryable<V_OPER_FM> GetOperFm();
    }
}