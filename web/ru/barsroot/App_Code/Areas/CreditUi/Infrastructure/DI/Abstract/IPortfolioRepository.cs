using System.Linq;
using BarsWeb.Areas.CreditUi.Models;
using System;
using System.Collections.Generic;


namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract
{
    public interface IPortfolioRepository
    {
        IQueryable<Portfolio> GetPortfolio(byte cusstype);
        PortfolioStaticData GetBankDate();

    }
}