using Areas.Reference.Models;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Implementation
{
    public class ReferenceModel : IReferenceModel
    {
        private ReferenceEntities _entities;
        public ReferenceEntities ReferenceEntities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("ReferenceModel", "Reference");
                return _entities ?? new ReferenceEntities(connectionStr);
            }
        }
    }
}
