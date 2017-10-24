using BarsWeb.Areas.Docs.Models;
using BarsWeb.Core;

namespace BarsWeb.Areas.Docs.Infrastructure.Repository
{
    public class DocsModel : IDocsModel
    {
        private DocsDbContext _dbContext;
        public DocsDbContext GetDbContext()
        {
            if (_dbContext == null)
            {
                _dbContext = new DocsDbContext(Constants.AppConnectionStringName);
            }
            return _dbContext;
        }
    }

    public interface IDocsModel
    {
        DocsDbContext GetDbContext();
    }
}
