using System.Linq;
using BarsWeb.Areas.CreditUi.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract
{
    public interface IAnalysisBalanceRepository
    {
        CreditInfo GetInfo(decimal nd);
        IQueryable<AccKredit> getAccKredit(decimal nd);
        IQueryable<AccKredit> getAccDebit(decimal nd, string ccId);
        List<CreateResponse> createIsg(List<CreateIsg> isg);
    }
}