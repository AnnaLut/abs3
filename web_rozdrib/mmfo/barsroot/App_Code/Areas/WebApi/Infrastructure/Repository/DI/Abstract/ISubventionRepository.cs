using BarsWeb.Areas.WebApi.Subvention.Models;
using System;

namespace BarsWeb.Areas.WebApi.Subvention.Infrastructure.DI.Abstract
{
    public interface ISubventionRepository
    {
        AccBalance GetAccBalance(string accNum, string accMfo, string _from, string _to);
        string HouseholdPayments(HHPayments data);
        string GetTicket(string requestId);
    }
}