using System.Collections.Generic;
using BarsWeb.Areas.Mbdk.Models;
using System.Linq;

namespace BarsWeb.Areas.Mbdk.Infrastructure.DI.Abstract
{
    public interface IDealRepository
    {
        object SaveDeal(SaveDealParam megamodel);
        decimal DealSum(SummInfo model);
        Deal ReadReal(string ND);
        List<object> ScoresNms(ScoreNms model);
        IQueryable<Currency> GetCurrency();
    }
}
