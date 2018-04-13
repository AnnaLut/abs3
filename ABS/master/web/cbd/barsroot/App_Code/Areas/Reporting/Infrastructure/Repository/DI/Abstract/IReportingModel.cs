using Areas.Reporting.Models;

namespace BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract
{
    public interface IReportingModel
    {
        ReportingEntities ReportingEntities { get; }
    }
}
