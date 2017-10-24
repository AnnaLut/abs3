using BarsWeb.Areas.Dwh.Models;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Dwh.Infrastructure.Repository.DI.Abstract
{
    public interface IReportRepository
    {
        IEnumerable<V_DWH_REPORTS> ReportData(DataSourceRequest request, string moduleId);
        decimal ReportDataCount(DataSourceRequest request, string moduleId);

        IEnumerable<V_DWH_CBIREP_QUERIES> ReportResultData(DataSourceRequest request, string moduleId);
        decimal ReportResultDataCount(DataSourceRequest request, string moduleId);

        V_DWH_REPORTS ReportItem(decimal id, string moduleId);

        int EnqueueReport(decimal reportId, string parameters);
        int DropReport(decimal reportId);
        IEnumerable<DWH_CBIREP_QUERIES_DATA> GetReportResults(decimal id);
        IQueryable<V_DWH_CBIREP_QUERIES> GetAllReportResults(string moduleId);
        List<V_REGIONS> GetRegions();
        string GetResultFileName(decimal id, string param);

        /*IQueryable<V_DWH_REPORTS> GetNotModuleReports(string moduleId);
        void ReportToModuleFunc(string moduleId, string reportId);        
        */
    }
}