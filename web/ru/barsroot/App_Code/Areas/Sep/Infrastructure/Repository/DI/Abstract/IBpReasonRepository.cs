using System.Linq;
using Areas.Sep.Models;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface IBpReasonRepository
    {
        IQueryable<BP_REASON> GetBpReasons();
        BP_REASON GetBpReason(decimal reasonId);
    }
}