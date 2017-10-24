using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
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

        public IQueryable<tblFDAT> GetWorkDates()
        {
            const string query = @"Select * from FDAT f order by f.FDAT desc";
            return _entities.ExecuteStoreQuery<tblFDAT>(query).AsQueryable();
            //return _entities.FDAT; 
        }
    }
}