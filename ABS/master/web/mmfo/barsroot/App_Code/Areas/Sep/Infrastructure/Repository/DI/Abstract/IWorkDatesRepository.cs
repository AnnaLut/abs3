using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Models;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface IWorkDatesRepository
    {
        IQueryable<tblFDAT> GetWorkDates();
    }
}