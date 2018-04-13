using Areas.CreditFactory.Models;

namespace BarsWeb.Areas.CreditFactory.Infrastructure.DI.Abstract
{
    public interface ICreditFactoryModel
    {
        CreditFactoryEntities CreditFactoryEntities { get; }
    }
}
