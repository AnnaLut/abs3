using System.Linq;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface ICurrencyDict
    {
        IQueryable<TabvalViewModel> GetTabvals();
        /// <summary>
        /// Get all currency
        /// </summary>
        /// <returns></returns>
        IQueryable<Currency> GetAllCurrencies();
    }
}