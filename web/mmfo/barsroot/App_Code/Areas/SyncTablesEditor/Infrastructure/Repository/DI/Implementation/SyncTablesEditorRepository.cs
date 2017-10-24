using Areas.SyncTablesEditor.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.SyncTablesEditor.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Data;
using Bars.Classes;
using System.Globalization;
using System.IO;
using Oracle.DataAccess.Client;
using System.Text;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.SyncTablesEditor.Infrastructure.DI.Implementation
{
    public class SyncTablesEditorRepository : ISyncTablesEditorRepository
    {
        readonly SyncTablesEditorModel _SyncTablesEditor;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public SyncTablesEditorRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _SyncTablesEditor = new SyncTablesEditorModel(EntitiesConnection.ConnectionString("SyncTablesEditorModel", "SyncTablesEditor"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }
        public ResponseSTE DeleteRecord(SyncTables model)
        {
            ResponseSTE result = new ResponseSTE() { Result = "OK", ErrorMsg = "" };

            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("p_tbl_id", model.TABID, DbType.Decimal, ParameterDirection.Input);

                    connection.Execute("NBUR_SYNC_DBF.DEL_ROW", p, commandType: CommandType.StoredProcedure);
                }
            }
            catch (Exception ex)
            {
                result.ErrorMsg = ex.Message;
                result.Result = "ERROR";
            }

            return result;
        }
        public ResponseSTE UpdateRecord(SyncTables model)
        {
            ResponseSTE result = new ResponseSTE() { Result = "OK", ErrorMsg = "" };

            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("p_tbl_id", model.TABID, DbType.Decimal, ParameterDirection.InputOutput);
                    p.Add("p_sel_stmt", model.S_SELECT, DbType.String, ParameterDirection.Input);
                    p.Add("p_ins_stmt", model.S_INSERT, DbType.String, ParameterDirection.Input);
                    p.Add("p_upd_stmt", model.S_UPDATE, DbType.String, ParameterDirection.Input);
                    p.Add("p_del_stmt", model.S_DELETE, DbType.String, ParameterDirection.Input);
                    p.Add("p_encode", model.ENCODE, DbType.String, ParameterDirection.Input);
                    p.Add("p_dbf_nm", model.FILE_NAME, DbType.String, ParameterDirection.Input);

                    connection.Execute("NBUR_SYNC_DBF.SET_ROW", p, commandType: CommandType.StoredProcedure);
                }
            }
            catch (Exception ex)
            {
                result.ErrorMsg = ex.Message;
                result.Result = "ERROR";
            }
            return result;
        }

        public ResponseSTE SynchronizeTable(SyncTables model)
        {
            ResponseSTE result = new ResponseSTE() { Result = "OK", ErrorMsg = "" };

            var tmpRes = SyncOneTable(model.TABID);

            if (!string.IsNullOrWhiteSpace(tmpRes))
            {
                result.ErrorMsg = tmpRes;
                result.Result = "ERROR";
            }
            return result;
        }

        public ResponseSTE SynchronizeAllTables()
        {
            ResponseSTE result = new ResponseSTE() { Result = "OK", ErrorMsg = "" };

            BarsSql sql = SqlCreator.SearchMain();
            IEnumerable<SyncTables> data = SearchGlobal<SyncTables>(null, sql);

            foreach (SyncTables item in data)
            {
                if (item.SYNC_FLAG != 1)
                {
                    string sResult = SyncOneTable(item.TABID);
                    result.ErrorMsg += string.IsNullOrWhiteSpace(sResult) ? "" : "<b>" + item.SEMANTIC + ":</b><br/>   " + sResult + "<br/>";
                }
                else
                {
                    DateTime? modTime = FileLastModifTime(item.TABID);
                    if (modTime != null)
                    {
                        var compareRes = DateTime.Compare((DateTime)item.FILE_DATE, (DateTime)modTime);
                        if (item.FILE_DATE == null || compareRes < 0)
                        {
                            string sResult = SyncOneTable(item.TABID);
                            result.ErrorMsg += string.IsNullOrWhiteSpace(sResult) ? "" : "<b>" + item.SEMANTIC + ":</b><br/>   " + sResult + "<br/>";
                        }
                    }
                    else if (item.FILE_DATE != null)
                    {
                        string sResult = SyncOneTable(item.TABID);
                        result.ErrorMsg += string.IsNullOrWhiteSpace(sResult) ? "" : "<b>" + item.SEMANTIC + ":</b><br/>   " + sResult + "<br/>";
                    }
                }
            }

            if (!string.IsNullOrWhiteSpace(result.ErrorMsg))
                result.Result = "ERROR";

            return result;
        }

        public ResponseSTE UploadFileData(byte[] fileData, string fileDate, int tabId)
        {
            DateTime fDate = new DateTime();
            if (DateTime.TryParse(fileDate, out fDate))
                ExecuteUploadProcedure(tabId, fileData, fDate);
            else
                return new ResponseSTE() { Result = "ERROR", ErrorMsg = "Wrong date format." };

            return new ResponseSTE();
        }

        public ResponseSTE UploadFile(FileInput uploadFileInfo)
        {
            ResponseSTE result = new ResponseSTE();
            try
            {
                byte[] fileData;
                string filePath = string.Empty;
                if (string.IsNullOrWhiteSpace(uploadFileInfo.FilePath))
                    filePath = GetPathById(uploadFileInfo.TabId);
                else
                    filePath = uploadFileInfo.FilePath;

                if (File.Exists(filePath))
                {
                    FileInfo fi = new FileInfo(filePath);
                    DateTime dateOfFile = fi.CreationTime;
                    fileData = File.ReadAllBytes(filePath);

                    ExecuteUploadProcedure(uploadFileInfo.TabId, fileData, dateOfFile);
                }
                else
                {
                    throw new Exception("File does not exist or there are no access.<br/>" + filePath);
                }
            }
            catch (Exception ex)
            {
                result.ErrorMsg = ex.Message;
                result.Result = "ERROR";
            }
            return result;
        }

        public FileCheckResponse CheckFile(SyncTables model, string filePath)
        {
            string path = string.Empty;
            if (string.IsNullOrWhiteSpace(filePath))
                path = GetPathById(model.TABID);
            else
                path = filePath;

            if (!File.Exists(path)) return new FileCheckResponse() { FileExists = false, FilePath = path };

            string dateFormat = "yyyy-MM-ddT00:00:00.000Z";

            DateTime? dateFromSql = FileLastModifTime(model.TABID);
            string dateFromSqlStr = dateFromSql == null ? "" : ((DateTime)dateFromSql).ToString(dateFormat);

            FileInfo fi = new FileInfo(path);

            return new FileCheckResponse() { FileExists = true, FileDate = fi.CreationTime.ToString(dateFormat), FileDateFromSql = dateFromSqlStr, FilePath = path };
        }

        private string GetPathById(decimal id)
        {
            ResponseSTE filePathResult = GetFullFilePath((int)id);
            if (filePathResult.Result != "OK" || string.IsNullOrWhiteSpace(filePathResult.ResultMsg))
                throw new Exception("Error reading path to file " + filePathResult.ErrorMsg);

            return filePathResult.ResultMsg;
        }

        private string ExecuteUploadProcedure(decimal tabId, byte[] fileData, DateTime dateOfFile)
        {
            string result = string.Empty;

            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleParameter param = new OracleParameter();

                OracleCommand cmd = new OracleCommand();
                cmd.Connection = connection;
                cmd.CommandText = "NBUR_SYNC_DBF.IMPORT_DBF";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("p_tbl_id", OracleDbType.Decimal).Value = tabId;
                cmd.Parameters.Add("p_dbf_data", OracleDbType.Blob).Value = fileData;
                cmd.Parameters.Add("p_dbf_dt", OracleDbType.Date).Value = dateOfFile;
                param = cmd.Parameters.Add("p_err_msg", OracleDbType.Varchar2, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                var myLc_ExitoValue = param.Value;
            }
            return result;
        }

        private string GetFolderPathFromFilePath(string filePath)
        {
            if (string.IsNullOrWhiteSpace(filePath)) return string.Empty;

            string[] elements = filePath.Split('\\');
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < elements.Length - 1; i++)
            {
                sb.Append(elements[i]);
                sb.Append(@"\");
            }

            return sb.ToString();
        }

        private string SyncOneTable(decimal id)
        {
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("p_tbl_id", id, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_err_msg", "", DbType.String, ParameterDirection.Output);

                    var trans = connection.BeginTransaction();

                    connection.Execute("NBUR_SYNC_DBF.SYNC_TBL", p, commandType: CommandType.StoredProcedure);

                    var error = p.Get<string>("p_err_msg");

                    if (!string.IsNullOrWhiteSpace(error))
                    {
                        trans.Rollback();
                        return error;
                    }
                    else trans.Commit();

                    return "";
                }
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }      

        public ResponseSTE ExportTableToSql(int tabId)
        {
            ResponseSTE result = new ResponseSTE() { Result = "OK", ErrorMsg = "" };

            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("p_tbl_id", tabId, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_script", "", DbType.String, ParameterDirection.Output);

                    connection.Execute("NBUR_SYNC_DBF.EXPORT", p, commandType: CommandType.StoredProcedure);
                    result.ResultMsg = p.Get<string>("p_script");
                }
            }
            catch (Exception ex)
            {
                result.ErrorMsg = ex.Message;
                result.Result = "ERROR";
            }

            return result;
        }

        public ResponseSTE GetFullFilePath(int tabId)
        {
            ResponseSTE result = new ResponseSTE() { Result = "OK", ErrorMsg = "" };

            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("Return_Value", "", DbType.String, ParameterDirection.ReturnValue);
                    p.Add("p_tbl_id", tabId, DbType.Decimal, ParameterDirection.Input);

                    connection.Execute("NBUR_SYNC_DBF.GET_FULL_FILE_NAME", p, commandType: CommandType.StoredProcedure);
                    result.ResultMsg = p.Get<string>("Return_Value");
                }
            }
            catch (Exception ex)
            {
                result.ErrorMsg = ex.Message;
                result.Result = "ERROR";
            }

            return result;
        }

        public ResponseSTE GetFileLastChangeDate(int tabId)
        {
            ResponseSTE result = new ResponseSTE() { Result = "OK", ErrorMsg = "" };

            try
            {
                DateTime? tmpDate = FileLastModifTime(tabId);
                if (tmpDate == null) throw new Exception("Exeption while getting date.");
                result.ResultMsg = ((DateTime)tmpDate).ToString("yyyy-MM-ddT00:00:00.000Z");
            }
            catch (Exception ex)
            {
                result.ErrorMsg = ex.Message;
                result.Result = "ERROR";
            }

            return result;
        }

        private DateTime? FileLastModifTime(decimal id)
        {
            DateTime result;
            string tmpRes = GetModifyDateString(id);

            if (string.IsNullOrWhiteSpace(tmpRes)) return null;

            if (!DateTime.TryParseExact(tmpRes, "dd-MMM-yy", CultureInfo.CurrentCulture, DateTimeStyles.None, out result)) return null;
            else return result;
        }

        private static string GetModifyDateString(decimal id)
        {
            string tmpRes;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("Return_Value", "", DbType.String, ParameterDirection.ReturnValue);
                p.Add("p_tbl_id", id, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("NBUR_SYNC_DBF.GET_DBF_CHANGE_DATE", p, commandType: CommandType.StoredProcedure);
                tmpRes = p.Get<string>("Return_Value");
            }
            return tmpRes;
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _SyncTablesEditor.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _SyncTablesEditor.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _SyncTablesEditor.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _SyncTablesEditor.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion
    }
}
