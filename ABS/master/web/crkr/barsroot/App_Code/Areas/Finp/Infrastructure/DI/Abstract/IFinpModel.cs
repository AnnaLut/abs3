using Areas.Finp.Models;

namespace BarsWeb.Areas.Finp.Infrastructure.DI.Abstract
{
    public interface IFinpModel
    {
        FinpEntities FinpEntities { get; }
    }
}
