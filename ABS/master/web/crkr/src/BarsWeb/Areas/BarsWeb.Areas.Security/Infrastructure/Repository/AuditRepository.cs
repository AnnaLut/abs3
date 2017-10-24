using System.Linq;
using BarsWeb.Areas.Security.Models;

namespace BarsWeb.Areas.Security.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for AccountRepository
    /// </summary>
    public class AuditRepository : IAuditRepository
    {
        readonly SecurityDbContext _entities;

        public AuditRepository(ISecurityModel model)
        {
            _entities = model.GetDbContext();
        }

        public IQueryable<AuditMessage> GetAllMessages()
        {
            return _entities.AuditMessages;
        }
        
    }

    public interface IAuditRepository
    {
        IQueryable<AuditMessage> GetAllMessages();
    }

}
