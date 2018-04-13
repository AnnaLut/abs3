using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract
{
    public interface ICashModel
    {
        CashEntities CashEntities { get; }
    }
}
