using Areas.Arcs.Models;

namespace BarsWeb.Areas.Arcs.Infrastructure.Repository.DI.Abstract
{
    public interface IArcsModel
    {
        ArcsEntities ArcsEntities { get; }
    }
}
