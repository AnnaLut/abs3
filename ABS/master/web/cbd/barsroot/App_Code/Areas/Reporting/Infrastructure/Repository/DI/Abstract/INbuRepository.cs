using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using BarsWeb.Areas.Reporting.Models;

namespace BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract
{
    public interface INbuRepository
    {
        /// <summary>
        /// Get report structure
        /// </summary>
        /// <param name="code">Report code</param>
        /// <returns></returns>
        IEnumerable<ReportStructure> GetReportStructure(string code);
        /// <summary>
        /// Get report data
        /// </summary>
        /// <param name="code">report code</param>
        /// <param name="date">report date</param>
        /// <returns></returns>
        DataSet GetReportData(string code, string date);
        /// <summary>
        /// Start create report
        /// </summary>
        /// <param name="code">report code</param>
        /// <param name="date">report date</param>
        /// <returns>task code</returns>
        string StartCreateReport(string code, string date);
        /// <summary>
        /// get repport file in memory stream
        /// </summary>
        /// <param name="code">report code</param>
        /// <param name="date">report date</param>
        /// <returns></returns>
        string GetReportFile(string code, DateTime date);
    }
}
