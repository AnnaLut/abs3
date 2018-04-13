using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class AdminModel : IAdminModel
    {
        private Entities _entities;
        public Entities Entities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("AdminModel","Admin");
                return _entities ?? new Entities(connectionStr);
            }
        }
    }
}
