using Areas.AdmSecurity.Models;
using BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Implementation
{
    public class SecurityModel : ISecurityModel
    {
        private Entities _entities;
        public Entities Entities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("SecurityModel", "AdmSecurity");
                return _entities ?? new Entities(connectionStr);
            }
        }
    }
}