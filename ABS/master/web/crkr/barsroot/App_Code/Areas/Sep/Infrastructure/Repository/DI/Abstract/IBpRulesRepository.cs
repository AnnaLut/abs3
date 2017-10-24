using BarsWeb.Areas.Sep.Models;
using System.Linq;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface IBpRulesRepository
    {
        IQueryable<SepRule> GetBpRules();
        bool CreateBpRules(SepRule item);
        bool DeleteBpRules(SepRule item);
        bool UpdateBpRules(SepRule item);
    }
}