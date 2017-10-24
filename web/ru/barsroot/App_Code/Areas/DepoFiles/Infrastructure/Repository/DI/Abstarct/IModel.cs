using Areas.DepoFiles.Models;

namespace BarsWeb.Areas.DepoFiles.Infrastructure.DI.Abstract
{
    public interface IModel
    {
        Entities Entities { get; }
    }
}
