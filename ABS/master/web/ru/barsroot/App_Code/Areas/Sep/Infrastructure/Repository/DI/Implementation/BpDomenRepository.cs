using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Models;
using System.Linq;


namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
	public class BpDomenRepository: IBpDomenRepository
	{
        private readonly SepFiles _entities;
        public BpDomenRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr); 
        }
        public IQueryable<SepDomen> GetBpDomen()
        {
            string query = "SELECT trim(atr) atr, name FROM Bp_domain where trim(tab)= 'arc_rrp'";
            return _entities.ExecuteStoreQuery<SepDomen>(query, new object[0]).AsQueryable();
        }
	}
}