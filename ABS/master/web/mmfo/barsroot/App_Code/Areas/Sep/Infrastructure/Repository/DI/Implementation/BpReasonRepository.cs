using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using BP_REASON = Areas.Sep.Models.BP_REASON;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class BpReasonRepository: IBpReasonRepository
    {
        private readonly SepFiles _entities;
        public BpReasonRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr);
        }
        public IQueryable<BP_REASON> GetBpReasons()
        {
            return _entities.BP_REASON;
        }
        public BP_REASON GetBpReason(decimal reasonId)
        {
            return GetBpReasons().SingleOrDefault(r => r.ID == reasonId);
        }
    }
}