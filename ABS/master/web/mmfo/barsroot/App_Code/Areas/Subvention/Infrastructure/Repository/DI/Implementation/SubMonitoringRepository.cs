using Areas.Subvention.Models;
using Bars.Classes;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Subvention.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Data;
using System.IO;
using System;
using System.Globalization;

namespace BarsWeb.Areas.Subvention.Infrastructure.DI.Implementation
{
    public class SubMonitoringRepository : ISubMonitoringRepository
    {
        readonly SubventionMonitoringModel _SubventionMonitoring;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public SubMonitoringRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _SubventionMonitoring = new SubventionMonitoringModel(EntitiesConnection.ConnectionString("SubventionModel", "Subvention"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        public byte RunJob()
        {
            try
            {
                using (OracleConnection con = OraConnector.Handler.UserConnection)
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "SUBSIDY.start_job";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
            }
            catch (OracleException ex)
            {
                if (ex.Message.Contains("ORA-27478")) return 1;
                else throw;
            }

            return 0;
        }

        public byte[] GetReportContent(string dateFrom, string dateTo, string accNumber)
        {
            CultureInfo ci;
            ci = CultureInfo.CreateSpecificCulture("en-GB");
            ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            ci.DateTimeFormat.DateSeparator = ".";

            FrxParameters pars = new FrxParameters();

            if (!string.IsNullOrWhiteSpace(dateTo) && !string.IsNullOrWhiteSpace(dateFrom))
            {
                DateTime dtFrom = ChangeTime(Convert.ToDateTime(dateFrom, ci), 0, 0, 0);
                DateTime dtTo = ChangeTime(Convert.ToDateTime(dateTo, ci), 23, 59, 59);

                pars.Add(new FrxParameter("sFdat1", TypeCode.DateTime, dtFrom));
                pars.Add(new FrxParameter("sFdat2", TypeCode.DateTime, dtTo));
                pars.Add(new FrxParameter("Param0", TypeCode.String, accNumber));
            }
            else throw new Exception("parameters [dateFrom] or/and [dateTo] can't bew null or white spaces");

            string templatePath = FrxDoc.GetTemplatePathByFileName("REP7609.FRX");

            FrxDoc doc = new FrxDoc(templatePath, pars, null);

            byte[] content = null;
            using (var str = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
                content = str.ToArray();
            }

            return content;
        }

        private DateTime ChangeTime(DateTime dateTime, int hours, int minutes, int seconds)
        {
            return new DateTime(
                dateTime.Year,
                dateTime.Month,
                dateTime.Day,
                hours,
                minutes,
                seconds,
                0,
                dateTime.Kind);
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _SubventionMonitoring.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _SubventionMonitoring.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _SubventionMonitoring.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _SubventionMonitoring.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion
    }
}
