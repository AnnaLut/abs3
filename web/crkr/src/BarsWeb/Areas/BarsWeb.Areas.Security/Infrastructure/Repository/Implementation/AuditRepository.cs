using System.Linq;
using BarsWeb.Areas.Security.Infrastructure.Repository.Abstract;
using BarsWeb.Areas.Security.Models;
using BarsWeb.Areas.Security.Models.Abstract;

namespace BarsWeb.Areas.Security.Infrastructure.Repository.Implementation
{
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
}
