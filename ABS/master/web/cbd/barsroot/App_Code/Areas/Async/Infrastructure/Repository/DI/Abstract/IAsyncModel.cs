using Areas.Async.Models;

namespace BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract
{
    public interface IAsyncModel
    {
        AsyncEntities AsyncEntities { get; }
    }
}
