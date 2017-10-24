using BarsWeb.Core.Models;

namespace BarsWeb.Core.Infrastructure.Repository
{
    public class CoreModel : ICoreModel
    {
        private CoreDbContext _dbContext;

        public CoreDbContext GetDbContext()
        {
            if (_dbContext == null)
            {
                _dbContext = new CoreDbContext(Constants.AppConnectionStringName);
            }
            return _dbContext;
            
        }
    }
    public interface ICoreModel
    {
        CoreDbContext GetDbContext();
    }
}
