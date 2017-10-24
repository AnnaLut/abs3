using Areas.DownloadXsdScheme.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.DownloadXsdScheme.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Data;
using System.IO;
using Dapper;

namespace BarsWeb.Areas.DownloadXsdScheme.Infrastructure.DI.Implementation
{
    public class DownloadXsdSchemeRepository : IDownloadXsdSchemeRepository
    {
        readonly DownloadXsdSchemeModel _DownloadXsdScheme;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public DownloadXsdSchemeRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _DownloadXsdScheme = new DownloadXsdSchemeModel(EntitiesConnection.ConnectionString("DownloadXsdSchemeModel", "DownloadXsdScheme"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        public void UploadFileFromPathIE(FileUploadModel model)
        {
            DateTime rDate = CheckSchemeDate(model.Date);

            if (!File.Exists(model.FilePath))
                throw new Exception("File " + model.FilePath + " does not exists or the re are no access.");

            ExecuteUploadProcedure(model.FileId, File.ReadAllBytes(model.FilePath), rDate);
        }

        public void UploadFileFromBytes(FileUploadModel model, byte[] fileContent)
        {
            DateTime rDate = CheckSchemeDate(model.Date);
            ExecuteUploadProcedure(model.FileId, fileContent, rDate);
        }

        private DateTime CheckSchemeDate(string date)
        {
            DateTime rDate = new DateTime();
            if (string.IsNullOrWhiteSpace(date))
            {
                rDate = currentBnkDate();
            }
            else
            {
                if (!DateTime.TryParseExact(date, "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out rDate))
                    throw new Exception("Incorrect date format.");
            }
            return rDate;
        }

        public void ExecuteUploadProcedure(int fileId, byte[] fileData, DateTime sDate)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleCommand cmd = new OracleCommand();
                cmd.Connection = connection;
                cmd.CommandText = "NBUR_XML.SET_XSD";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("p_file_id", OracleDbType.Decimal).Value = fileId;
                cmd.Parameters.Add("p_scm_dt", OracleDbType.Date).Value = sDate;
                cmd.Parameters.Add("p_scm_doc", OracleDbType.Blob).Value = fileData;

                cmd.ExecuteNonQuery();
            }
        }

        private DateTime currentBnkDate()
        {
            string tmpResult = "";
            var sql = @"SELECT bankdate() BDate FROM dual";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                tmpResult = connection.Query<string>(sql).ToList().FirstOrDefault();
            }
            return DateTime.Parse(tmpResult);
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _DownloadXsdScheme.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _DownloadXsdScheme.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _DownloadXsdScheme.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _DownloadXsdScheme.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion
    }
}
