using BarsWeb.Areas.Security.Models.Abstract;
using BarsWeb.Core;

namespace BarsWeb.Areas.Security.Models.Implementation
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
}
