using BarsWeb.Areas.Sep.Models;
using System.Linq;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface IBpDomenRepository
    {
        IQueryable<SepDomen> GetBpDomen();	   
    }
}
