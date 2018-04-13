using Areas.Reporting.Models;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Implementation
{
    public class ReportingModel : IReportingModel
    {
        private ReportingEntities _entities;
        public ReportingEntities ReportingEntities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("ReportingModel", "Reporting" );
                return _entities ?? new ReportingEntities(connectionStr);
            }
        }
    }
}
