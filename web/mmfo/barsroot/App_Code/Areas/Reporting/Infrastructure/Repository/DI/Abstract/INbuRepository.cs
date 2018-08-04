using System.Collections.Generic;
using System.Data;
using BarsWeb.Areas.Reporting.Models;
using Kendo.Mvc.UI;
using BarsWeb.Infrastructure.Helpers;

namespace BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract
{
    public interface INbuRepository
    {
        /// <summary>
        /// Get report structure
        /// </summary>
        /// <returns></returns>
        IEnumerable<RepStructure> GetReportStructure(string fileCode, string schemeCode);
        Bars.Oracle.Factories.OracleConnectFactory GetOracleConnector { get; }
        NburListFromFinished GetNburListFromFinished(string fileCode, string reportDate, string kf, decimal? versionId = null);
        /// <summary>
        /// Get report data
        /// </summary>
        /// <returns></returns>
        DataSet GetReportData(string fileCode, string schemeCode, string kf, string date, string isCon, decimal? verId = null);
        /// <summary>
        /// Start create report
        /// </summary>
        /// <returns>task code</returns>
        string StartCreateReport(string reportDate, string fileCode, string schemeCode, string fileType, string kf);
        /// <summary>
        /// get repport file in memory stream
        /// </summary>
        /// <param name="code">report code</param>
        /// <param name="date">report date</param>
        /// <returns></returns>
        string GetReportFile(string code, string date);

        string GenerateReportFromClob(string reportDate, 
                                      string fileCode, 
                                      string kf, 
                                      string schemeCode, 
                                      decimal? versionId = null);
        string GenerateReportFiltName(string fileCode,
                                      string reportDate,
                                      string kf,
                                      string schemeCode,
                                      decimal? versionId);
        /// <summary>
        /// use to check and get view from DB which has needed consolidate data 
        /// </summary>
        /// <param name="code">report code</param>
        /// <returns>kod of view for request</returns>
        string kodfСheck(string code);
        /// <summary>
        /// insert a new row to db by using BARS.OTCN_WEB.p_insert_row
        /// </summary>
        /// <param name="datf">дата формування файлу</param>
        /// <param name="kodf">номер файлу</param>
        /// <param name="kodp">код показника</param>
        /// <param name="znap">значення показника</param>
        /// <param name="nbuc">код області / МФО</param>
        /// <returns></returns>
        void InsertRow(string datf, string kodf, string kodp, string znap, string nbuc);

        /// <summary>
        /// update row in db by using BARS.OTCN_WEB.p_update_row
        /// </summary>
        /// <param name="datf">дата формування файлу</param>
        /// <param name="kodf">номер файлу</param>
        /// <param name="oldKodp">???</param>
        /// <param name="kodp">новий код показника</param>
        /// <param name="znap">значення показника</param>
        /// <param name="nbuc">код області / МФО</param>
        /// <returns></returns>
        void UpdateRow(string datf, string kodf, string oldKodp, string kodp, string znap, string nbuc);
        /// <summary>
        /// delete row from db by using BARS.OTCN_WEB.p_delete_row
        /// </summary>
        /// <param name="datf">дата формування файлу</param>
        /// <param name="kodf">номер файлу</param>
        /// <param name="kodp">код показника</param>
        /// <param name="nbuc">код області / МФО</param>
        /// <returns></returns>
        void DeleteRow(string datf, string kodf, string kodp, string nbuc);
        /// <summary>
        /// Get archive data
        /// </summary>
        /// <returns></returns>
        IEnumerable<Archive> ArchiveGrid(string fileCodeBase64, string kf, string reportDate);

        IEnumerable<Accessed> GetVersion(string reportDate, string kf, string fileCode);

        void BlockFile(string reportDate, decimal fileId, string kf, decimal versionId);

        decimal? GetCustType(decimal rnk);

        IEnumerable<FileInitialInfo> GetFileInitialInfo(int id, string kf);

        List<DetailedReport> GetDetailedReport(DataSourceRequest request, string fileCode, string reportDate, string kf, string fieldCode, string schemeCode);
        List<DetailedReport> GetDetailedReportList(string fileCode, string reportDate, string kf, string fieldCode, string schemeCode);

        string GetViewName(string fileCode, bool isDtl);
        List<AllColComments> GetTableComments(string tableName);
        List<TableInfo> GetTableInfo(string tableName);
        IEnumerable<Dictionary<string, object>> GetDetailedReportDyn(DataSourceRequest request, string vn, string fileCode, string reportDate, string kf, string fieldCode, string schemeCode, string nbuc,bool isDtl);
        string GetFileFmt(string fileCode, bool isDtl);
        string GetChkLog(string fileCode, string reportDate, string kf, string schemeCode, decimal? versionId = null);
    }
}
