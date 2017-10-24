using Areas.DepoFiles.Models;
using Areas.Doc.Models;
using BarsWeb.Areas.DepoFiles.Infrastructure.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.DepoFiles.Infrastructure.Repository.DI.Implementation
{
    public class Model : IModel
    {
        private Entities _entities;
        public Entities Entities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("Model", "DepoFiles");
                return _entities ?? new Entities(connectionStr);
            }
        }
    }
}
