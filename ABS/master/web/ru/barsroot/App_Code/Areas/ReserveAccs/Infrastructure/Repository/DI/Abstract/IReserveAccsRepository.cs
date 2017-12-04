using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Areas.ReserveAccs.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.ReserveAccs.Infrastructure.Repository.DI.Abstract
{
    public interface IReserveAccsRepository
    {
        decimal Reserved(ReservedAccountRegister account);
        List<SpecParamList> GetSpecParamList();
        String GetNDBO(Decimal rnk);
        void Activate(List<decimal> accountId);
    }
}
