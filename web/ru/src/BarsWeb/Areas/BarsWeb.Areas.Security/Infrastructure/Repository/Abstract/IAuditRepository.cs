using System.Linq;
using BarsWeb.Areas.Security.Models;

namespace BarsWeb.Areas.Security.Infrastructure.Repository.Abstract
{
    public interface IAuditRepository
    {
        IQueryable<AuditMessage> GetAllMessages();
    }
}