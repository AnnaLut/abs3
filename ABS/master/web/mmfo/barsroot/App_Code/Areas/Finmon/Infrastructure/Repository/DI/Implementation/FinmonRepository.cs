using Areas.Finmon.Models;
using BarsWeb.Areas.Finmom.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Finmom.Infrastructure.Repository.DI.Implementation
{
    public class FinmonRepository : IFinmonRepository
    {
        private readonly FinmonModel _entities;
        public FinmonRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("FmonModel", "Finmon");
            _entities = new FinmonModel(connectionStr);
        }

        public System.Linq.IQueryable<V_OPER_FM> GetOperFm()
        {
            return _entities.V_OPER_FM;
        }
    }
}