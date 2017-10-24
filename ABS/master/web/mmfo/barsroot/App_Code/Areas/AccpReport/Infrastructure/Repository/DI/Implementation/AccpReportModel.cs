using BarsWeb.Areas.AccpReport.Infrastructure.DI.Abstract;
using Areas.AccpReport.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.AccpReport.Infrastructure.Repository.DI.Implementation
{
    public class AccpReportModel : IAccpReportModel
    {
        private Entities _entities;
        public Entities AccpReportEntities
        {
            get
            {
                if (_entities == null)
                {
                    var connectionStr = EntitiesConnection.ConnectionString("AccpReport", "AccpReport");
                    _entities = new Entities(connectionStr);
                }
                return _entities;
            }
        }
    }
}
