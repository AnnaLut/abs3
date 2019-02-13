using System.Linq;
using Areas.Finmon.Models;

namespace BarsWeb.Areas.Finmom.Infrastructure.Repository.DI.Abstract
{
    public interface IFinmonRepository
    {
        IQueryable<V_OPER_FM> GetOperFm();
    }
}