using Areas.Async.Models;
using BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Async.Infrastructure.Repository.DI.Implementation
{
    public class AsyncModel : IAsyncModel
    {
        private AsyncEntities _entities;
        public AsyncEntities AsyncEntities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("AsyncModel", "Async");
                return _entities ?? new AsyncEntities(connectionStr);
            }
        }
    }
}
