using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISep3720Repository
    {
        IQueryable<Sep3720> GetSep3720List(DataSourceRequest request, AccessType accessType);
        decimal GetSep3720Count(AccessType accessType, DataSourceRequest request);
        void DeleteSep3720Record(int delSepREFnumber);
        IQueryable<ACCOUNTS> GetAccount();
        IQueryable<CUSTOMER> GetCustomer();
        Sep3720AltAccount GetAltAccount(string nls, int? kv);
        int SetToAltAccounts(string docList);
        int SetRequest(string requestList);
        decimal GetSumT902();
    }
}