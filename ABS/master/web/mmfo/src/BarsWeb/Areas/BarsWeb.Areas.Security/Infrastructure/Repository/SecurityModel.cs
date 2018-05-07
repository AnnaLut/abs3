using BarsWeb.Areas.Security.Models;
using BarsWeb.Core;

namespace BarsWeb.Areas.Security.Infrastructure.Repository
{
    public class SecurityModel : ISecurityModel
    {
        private SecurityDbContext _dbContext;
        public SecurityDbContext GetDbContext()
        {
            if (_dbContext == null)
            {
                _dbContext = new SecurityDbContext(Constants.AppConnectionStringName);
            }
            return _dbContext;
            
        }
    }
    public interface ISecurityModel
    {
        SecurityDbContext GetDbContext();
    }
}
