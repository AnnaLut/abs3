using System.Linq;
using BarsWeb.Areas.AdmSecurity.Models;

namespace BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Abstract
{
    public interface ISecAuditRepository
    {
        bool SeedSecAuditTable(string start, string end);
        IQueryable<SecAuditArchModel> GetGridData();
    }
}