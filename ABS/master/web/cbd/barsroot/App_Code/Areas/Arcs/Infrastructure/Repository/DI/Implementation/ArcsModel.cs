using Areas.Arcs.Models;
using BarsWeb.Areas.Arcs.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Arcs.Infrastructure.Repository.DI.Implementation
{
    public class ArcsModel : IArcsModel
    {
        private ArcsEntities _entities;
        public ArcsEntities ArcsEntities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("ArcsModel","Arcs");
                return _entities ?? new ArcsEntities(connectionStr);
            }
        }
    }
}
