using BarsWeb.Areas.Clients.Models;
using BarsWeb.Core;

namespace BarsWeb.Areas.Clients.Infrastructure.Repository
{
    public class ClientsModel : IClientsModel
    {
        private ClientsDbContext _dbContext;
        public ClientsDbContext GetDbContext()
        {
            if (_dbContext == null)
            {
                _dbContext = new ClientsDbContext(Constants.AppConnectionStringName);
            }
            return _dbContext;
        }
    }
    public interface IClientsModel
    {
        ClientsDbContext GetDbContext();
    }
}
