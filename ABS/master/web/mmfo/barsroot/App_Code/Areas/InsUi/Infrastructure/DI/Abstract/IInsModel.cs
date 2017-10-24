using Areas.InsUi.Models;

namespace BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract
{
    public interface IInsModel
    {
        InsuranceEntities InsuranceEntities { get; }
    }
}
