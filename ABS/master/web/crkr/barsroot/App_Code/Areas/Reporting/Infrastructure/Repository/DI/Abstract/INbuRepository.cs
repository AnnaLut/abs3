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
        DataSet GetReportData(string code, string date, string isCon);
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
        string GetReportFile(string code, string date);
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
        /// 
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
        /// <param name="kodf">report code</param>
        /// <returns></returns>
        IEnumerable<Archive> ArchiveGrid(string kodf);
    }
}
