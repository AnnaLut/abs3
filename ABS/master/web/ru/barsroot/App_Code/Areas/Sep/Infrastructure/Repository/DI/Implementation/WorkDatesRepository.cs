using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class WorkDatesRepository : IWorkDatesRepository
    {
        private readonly SepFiles _entities;
        public WorkDatesRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr);
        }

        public IQueryable<FDAT> GetWorkDates()
        {
            return _entities.FDAT; ;
        }
    }
}