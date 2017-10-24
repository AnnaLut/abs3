using Areas.Doc.Models;
using BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Implementation
{
    public class DocModel : IDocModel
    {
        private DocEntities _entities;
        public DocEntities DocEntities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("DocModel","Doc");
                return _entities ?? new DocEntities(connectionStr);
            }
        }
    }
}
