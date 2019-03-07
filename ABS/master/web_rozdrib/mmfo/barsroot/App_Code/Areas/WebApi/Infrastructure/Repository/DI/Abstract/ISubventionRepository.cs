using BarsWeb.Areas.WebApi.Subvention.Models;
using System;

namespace BarsWeb.Areas.WebApi.Subvention.Infrastructure.DI.Abstract
{
    public interface ISubventionRepository
    {
        Response<AccBalance> GetAccBalance(string accNum, string accMfo, string _from, string _to);
        Response<string> HouseholdPayments(HHPayments data);
        Response<string> GetTicket(string requestId);
    }
}