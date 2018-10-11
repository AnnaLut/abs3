using System;
using System.ComponentModel;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Web;
using System.Web.Services;
using Bars.Exception;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Classes;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc;
using Kendo.Mvc.UI;
using CommandType = System.Data.CommandType;
using Bars.WebServices;
using barsroot.core;
using System.IO.Compression;
using System.IO;
using BarsWeb.Core.Logger;
using Oracle.DataAccess.Types;

namespace Bars
{
    public class BarsWebService : System.Web.Services.WebService
    {
        protected string moduleName = "XRMIntegration";
        IOraConnection _hsql;
        OracleConnection _connect;
        OracleCommand _command;
        OracleDataReader _reader;
        OracleTransaction _transaction;
        //-----------------------------------------------

        public BarsWebService()
        {
            InitializeComponent();
            //Context.Response;
        }
        private IContainer components = null;

        public static CultureInfo CXRMinfo()
        {
            CultureInfo cXRMinfo = CultureInfo.CreateSpecificCulture("en-GB");

            cXRMinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cXRMinfo.DateTimeFormat.DateSeparator = "/";

            cXRMinfo.NumberFormat.NumberDecimalSeparator = ".";
            cXRMinfo.NumberFormat.CurrencyDecimalSeparator = ".";

            return cXRMinfo;
        }

        #region new login and bc.go, using single connection
        protected void LoginADUserIntSingleCon(OracleConnection con, string userName, bool bcGo = true)
        {
            string ipAddress = RequestHelpers.GetClientIpAddress(HttpContext.Current.Request);

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = "bars.bars_login.login_user";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_session_id", OracleDbType.Varchar2, Session.SessionID, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_login_name", OracleDbType.Varchar2, userName, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_authentication_mode", OracleDbType.Varchar2, "ACTIVE DIRECTORY", ParameterDirection.Input));

                cmd.Parameters.Add(new OracleParameter("p_hostname", OracleDbType.Varchar2, ipAddress, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input));
                cmd.ExecuteNonQuery();

                if (bcGo)
                    ExecBcGo(con, HttpContext.Current.Request.Headers["branch"]);

                WriteMsgToAudit(con, string.Format("XRMIntegration: авторизация. Хост {0}, пользователь {1} ", ipAddress, userName));
            }
            Session["UserLoggedIn"] = true;
        }

        protected void LoginUserIntSingleCon(OracleConnection con, string userName, bool bcGo = true)
        {
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);
            string ipAddress = RequestHelpers.GetClientIpAddress(HttpContext.Current.Request);

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = "bars.bars_login.login_user";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_session_id", OracleDbType.Varchar2, Session.SessionID, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_hostname", OracleDbType.Varchar2, ipAddress, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input));
                cmd.ExecuteNonQuery();

                if (bcGo)
                    ExecBcGo(con, HttpContext.Current.Request.Headers["branch"]);

                WriteMsgToAudit(con, string.Format("XRMIntegration: авторизация. Хост {0}, пользователь {1} ", ipAddress, userName));
            }

            Session["UserLoggedIn"] = true;
        }

        private void ExecBcGo(OracleConnection con, string branch)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bc.go";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_branch", OracleDbType.Varchar2, branch, ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
        }

        private void WriteMsgToAudit(OracleConnection con, string msg)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bars_audit.info";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_info", OracleDbType.Varchar2, msg, ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
        }
        #endregion

        #region writing/reading request and response to/from log by transaction id
        protected T ToResponse<T>(byte[] response) where T : new()
        {
            try
            {
                Byte[] unzipResponse = Decompress(response);
                T result = Newtonsoft.Json.JsonConvert.DeserializeObject<T>(System.Text.Encoding.GetEncoding(1251).GetString(unzipResponse));

                return result;
            }
            catch
            {
                return new T();
            }
        }
        private byte[] Decompress(byte[] response)
        {
            using (var compressedStream = new MemoryStream(response))
            {
                using (var uncompressedStream = new MemoryStream())
                {
                    using (var gzipStream = new GZipStream(compressedStream, CompressionMode.Decompress))
                    {
                        gzipStream.CopyTo(uncompressedStream);
                    }
                    return uncompressedStream.ToArray();
                }
            }
        }
        private byte[] Compress(string uncompressedJsonString)
        {
            using (var uncompressedStream = new MemoryStream(System.Text.Encoding.GetEncoding(1251).GetBytes(uncompressedJsonString)))
            {
                using (var compressedStream = new MemoryStream())
                {
                    using (var gzipStream = new GZipStream(compressedStream, CompressionMode.Compress))
                    {
                        uncompressedStream.CopyTo(gzipStream);
                        gzipStream.Close();
                    }
                    return compressedStream.ToArray();
                }
            }
        }
        protected void WriteRequestResponseToLog(OracleConnection con, decimal transactionId, object Request, object Response)
        {
            try
            {
                using (OracleCommand command = con.CreateCommand())
                {
                    command.Parameters.Clear();
                    command.CommandType = CommandType.StoredProcedure;
                    command.BindByName = true;
                    command.CommandText = "bars.xrm_ui_oe.save_req";
                    command.Parameters.Add("p_TransactionId", OracleDbType.Varchar2, transactionId, ParameterDirection.Input);
                    command.Parameters.Add("p_req", OracleDbType.Blob, Compress(Newtonsoft.Json.JsonConvert.SerializeObject(Request)), ParameterDirection.Input);
                    command.Parameters.Add("p_resp", OracleDbType.Blob, Compress(Newtonsoft.Json.JsonConvert.SerializeObject(Response)), ParameterDirection.Input);
                    command.ExecuteNonQuery();
                }
            }
            catch { }
        }
        #endregion

        #region Transaction processing  
        protected readonly String TransactionErrorMessage = "Помилка отримання транзакції {0} з БД";
        protected readonly String TransactionExistsMessage = "TransactionID {0} вже була проведена";
        protected readonly String TransactionInProgress = "TransactionID {0} вже була проведена, але обробка ще не завершилась";

        protected void TransactionCreate(OracleConnection con, decimal transactionId, string userLogin, short? operationType = null, string description = null)
        {
            try
            {
                using (OracleCommand cmdTrans = con.CreateCommand())
                {
                    cmdTrans.CommandType = CommandType.StoredProcedure;
                    cmdTrans.CommandText = "xrm_ui_oe.xrm_audit";
                    cmdTrans.BindByName = true;
                    cmdTrans.Parameters.Clear();
                    cmdTrans.Parameters.Add("p_TransactionId", OracleDbType.Decimal, transactionId, ParameterDirection.Input);
                    cmdTrans.Parameters.Add("p_TranType", OracleDbType.Decimal, operationType, ParameterDirection.Input);
                    cmdTrans.Parameters.Add("p_Description", OracleDbType.Varchar2, description, ParameterDirection.Input);
                    cmdTrans.Parameters.Add("p_user_login", OracleDbType.Varchar2, userLogin, ParameterDirection.Input);
                    cmdTrans.ExecuteNonQuery();
                }
            }
            catch (System.Exception e)
            {
                DbLoggerConstruct.NewDbLogger().Info(e.StackTrace + e.Message, moduleName);
            }
        }
        protected decimal TransactionCheck(OracleConnection con, decimal transactionId, out byte[] responseBytes)
        {
            responseBytes = null;
            decimal res = 1;

            try
            {
                using (OracleCommand cmdTrans = con.CreateCommand())
                {
                    cmdTrans.CommandType = CommandType.StoredProcedure;
                    cmdTrans.CommandText = "xrm_ui_oe.CheckTrasaction";
                    cmdTrans.BindByName = true;

                    cmdTrans.Parameters.Clear();
                    cmdTrans.Parameters.Add("p_TransactionId", OracleDbType.Decimal, transactionId, ParameterDirection.Input);
                    cmdTrans.Parameters.Add("p_TransactionResult", OracleDbType.Decimal, res, ParameterDirection.Output);
                    cmdTrans.Parameters.Add("p_resp", OracleDbType.Blob, responseBytes, ParameterDirection.Output);
                    cmdTrans.ExecuteNonQuery();
                    res = ((OracleDecimal)cmdTrans.Parameters["p_TransactionResult"].Value).Value;
                    if (res == -1)
                    {
                        using (OracleBlob p_resp = (OracleBlob)cmdTrans.Parameters["p_resp"].Value)
                        {
                            responseBytes = p_resp.IsNull ? null : p_resp.Value;
                        }
                    }
                }
            }
            catch (System.Exception e)
            {
                DbLoggerConstruct.NewDbLogger().Info(e.StackTrace + e.Message, moduleName);
            }
            return res;
        }

        /// <summary>
        /// check if transaction allready exists then throw error, if it's new, creates transaction
        /// </summary>
        /// <param name="con">Oracle connection</param>
        /// <param name="transactionId">Transaction Id (passed from XRM)</param>
        /// <param name="userLogin">AD User login (passed from XRM)</param>
        /// <param name="operationType">Operation type (passed from XRM)</param>
        /// <param name="moduleName">log message identifier (default is "XRMIntegration")</param>
        /// <param name="description">Transaction decription (empty by default)</param>
        //protected void ProcessTransactions(OracleConnection con, decimal transactionId, string userLogin, short? operationType, out byte[] response, string description = "")
        //{
        //    decimal TransStatus = TransactionCheck(con, transactionId, out response);

        //    if (0 == TransStatus)
        //        TransactionCreate(con, transactionId, userLogin, operationType, description);
        //    else if (-1 == TransStatus)
        //    {
        //        if (null == response)
        //            throw new System.Exception(String.Format("TransactionID {0} already exists and there is no saved answer", transactionId));
        //    }
        //    else
        //        throw new System.Exception(String.Format("Помилка отримання транзакції {0} з БД", transactionId));
        //}
        protected int ProcessTransactions(OracleConnection con, decimal transactionId, string userLogin, short? operationType, out byte[] response, string description = "")
        {
            int TransStatus = (int)TransactionCheck(con, transactionId, out response);

            if (0 == TransStatus) TransactionCreate(con, transactionId, userLogin, operationType, description);
            else if (-1 == TransStatus)
            {
                if (null == response) TransStatus = -2;
            }
            else
                throw new System.Exception(String.Format("Помилка отримання транзакції {0} з БД", transactionId));
            return TransStatus;
        }
        #endregion Transaction

        #region Old
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
        }
        public void SetLONGFetchSize(int size)
        {
            _command.InitialLONGFetchSize = size;
        }
        public void SetLOBFetchSize(int size)
        {
            _command.InitialLOBFetchSize = size;
        }
        public void SetFetchSize(int size)
        {
            _command.FetchSize = size;
        }

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing && components != null)
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }
        /// <summary>
        /// Первичная проверка на доступ к сервису
        /// </summary>
        public virtual void PrimaryCheckAccess()
        {

        }

        /// <summary>
        /// Сохраняем выброшенное исключение 
        /// </summary>
        /// <param name="ex">Исключение</param>
        public void SaveExeption(System.Exception ex)
        {
            if (HttpContext.Current.Session != null)
            {
                HttpContext.Current.Session["AppError"] = ex;
            }
            else
            {
                string hash = HttpContext.Current.Request.UserAgent;
                hash += HttpContext.Current.Request.UserHostAddress;
                hash += HttpContext.Current.Request.UserHostName;

                string key = hash.GetHashCode().ToString();
                AppDomain.CurrentDomain.SetData(key, ex);

            }
        }

        /// <summary>
        /// Инициализация работы с базой(создаем экземпляр интерфейса Bars.Oracle.Connection )
        /// </summary>
        public IOraConnection hsql
        {
            get
            {
                if (_hsql == null)
                {
                    _hsql = OraConnector.Handler.IOraConnection;
                }
                return _hsql;
            }
        }

        /// <summary>
        /// Строка соединения
        /// </summary>
        /// <param name="ctx">Контекст</param>
        /// <returns>строка соединения</returns>
        public string ConnectionString(HttpContext ctx)
        {
            return hsql.GetUserConnectionString(ctx);
        }

        /// <summary>
        /// Connection 
        /// </summary>
        public OracleConnection GetOraConnection()
        {
            return _connect;
        }

        public void SetAddRowid(bool flag)
        {
            _command.AddRowid = flag;
        }

        /// <summary>
        /// Инициализация работы с базой
        /// </summary>
        /// <param name="ctx">Контекст</param>
        public void InitOraConnection(HttpContext ctx)
        {
            if (_connect == null)
                _connect = hsql.GetUserConnection();
            _command = new OracleCommand();
        }
        /// <summary>
        /// Инициализация работы с базой
        /// </summary>
        /// <param name="connstr">строка соединения</param>
        public void InitOraConnection(string connstr)
        {
            if (_connect == null)
                _connect = new OracleConnection(connstr);
            _connect.Open();
            _command = new OracleCommand();
        }
        /// <summary>
        /// Инициализация работы с базой
        /// </summary>
        public void InitOraConnection()
        {
            if (_connect == null)
                _connect = hsql.GetUserConnection();
            _command = new OracleCommand();
        }
        /// <summary>
        /// Начать транзакцию
        /// </summary>
        public void BeginTransaction()
        {
            _transaction = _connect.BeginTransaction();
        }
        /// <summary>
        /// Commit транзакции
        /// </summary>
        public void CommitTransaction()
        {
            _transaction.Commit();
        }
        /// <summary>
        /// Rollback  транзакции
        /// </summary>
        public void RollbackTransaction()
        {
            _transaction.Rollback();
        }
        /// <summary>
        /// Установка роли
        /// </summary>
        /// <param name="role">имя роли</param>
        public void SetRole(string role)
        {
            _command.Connection = _connect;
            _command.CommandText = hsql.GetSetRoleCommand(role.ToUpper());
            try
            {
                _command.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                throw (new RoleException(role, ex));
            }
        }
        /// <summary>
        /// Commit текущего соединения
        /// </summary>
        public void Commit()
        {
            _command.Connection = _connect;
            _command.CommandText = "commit";
            _command.ExecuteNonQuery();
        }
        /// <summary>
        /// Добавить параметр запроса
        /// </summary>
        /// <param name="name">имя параметра</param>
        /// <param name="type">тип(перечисление DB_TYPE)</param>
        /// <param name="val">значение параметра</param>
        /// <param name="direct">direction(перечисление DIRECTION)</param>
        public void SetParameters(string name, DB_TYPE type, object val, DIRECTION direct)
        {
            _command.Parameters.Add(name, (OracleDbType)type, val, (ParameterDirection)direct);
        }

        public void SetParameters(string name, DB_TYPE type, int size, string column)
        {
            _command.Parameters.Add(name, (OracleDbType)type, size, column);
        }

        public void SetParameters(string name, DB_TYPE type, int size)
        {
            _command.Parameters.Add(name, (OracleDbType)type, size);
        }

        public void SetParameters(string name, DB_TYPE type, int size, object val, DIRECTION direct)
        {
            _command.Parameters.Add(name, (OracleDbType)type, size, val, (ParameterDirection)direct);
        }
        /// <summary>
        /// Удалить все параметры текущего OracleCommand 
        /// </summary>
        public void ClearParameters()
        {
            _command.Parameters.Clear();
        }
        /// <summary>
        /// Получить параметр
        /// </summary>
        /// <param name="name">имя параметра</param>
        /// <returns>значение параметра</returns>
        public object GetParameter(string name)
        {
            return _command.Parameters[name].Value;
        }
        /// <summary>
        /// Значение параметра из таблицы WEB_USERPARAMS
        /// </summary>
        /// <param name="param">имя параметра</param>
        /// <returns>значение</returns>
        public string GetUserParam(string param)
        {
            _command.CommandText = "SELECT VAL FROM V_WEB_USERPARAMS WHERE PAR=:PAR";
            _command.Parameters.Clear();
            _command.Parameters.Add("PAR", OracleDbType.Varchar2, param, ParameterDirection.Input);
            try
            {
                return _command.ExecuteScalar().ToString();
            }
            catch
            {
                return "";
            }
        }
        /// <summary>
        /// Взять глобальный параметр из таблицы Params
        /// </summary>
        /// <param name="parName"></param>
        /// <returns></returns>
        public string GetGlobalParam(string parName, string roleName)
        {
            if (_connect == null) InitOraConnection();
            object parValue = AppDomain.CurrentDomain.GetData("WPARAM_" + parName);
            if (parValue == null)
            {
                SetRole(roleName);
                _command.Parameters.Add("par", OracleDbType.Varchar2, parName, ParameterDirection.Input);
                _command.CommandText = "select val from params where par=:par";
                parValue = _command.ExecuteScalar();
                _command.Parameters.Clear();
                AppDomain.CurrentDomain.SetData("WPARAM_" + parName, parValue);
            }
            return Convert.ToString(parValue);
        }

        /// <summary>
        /// Возвращает строку запроса с пейджингом
        /// </summary>
        /// <param name="query">входной запрос</param>
        /// <param name="startpos">позиция с</param>
        /// <param name="maxpos">количество строк</param>
        /// <returns></returns>
        private string MakePagingQuery(string query, int startpos, int maxpos)
        {
            startpos++;
            _command.Parameters.Add("MAX_ROW_TO_FETCH", OracleDbType.Decimal, startpos + maxpos, ParameterDirection.Input);
            _command.Parameters.Add("MIN_ROW_TO_FETCH", OracleDbType.Decimal, startpos, ParameterDirection.Input);
            return "select * from " +
                   "(select /*+ FIRST_ROWS(100) */ myquery.*,rownum rnum from (" + query + ") myquery " +
                   "where rownum < :MAX_ROW_TO_FETCH) " +
                   "where rnum >= :MIN_ROW_TO_FETCH";
        }
        /// <summary>
        /// Заполняет DataSet заданым запросом
        /// </summary>
        /// <param name="query">запрос</param>
        /// <returns>DataSet</returns>
        public DataSet SQL_SELECT_dataset(string query)
        {
            OracleDataAdapter adapter = new OracleDataAdapter();
            DataSet ds = new DataSet();
            _command.Connection = _connect;
            _command.CommandText = query;
            adapter.SelectCommand = _command;
            adapter.Fill(ds, "Table");
            adapter.Dispose();
            return ds;
        }
        private string countQuery(string query, string key)
        {
            string result = query.ToUpper();
            result = result.Substring(result.IndexOf("FROM"));
            result = result.Substring(0, result.ToUpper().IndexOf("ORDER"));
            result = "SELECT count(distinct " + key + ") " + result;
            return result;
        }
        /// <summary>
        /// Заполняет DataSet строками начиная с номера [startpos] и количеством [maxpos] строк
        /// </summary>
        /// <param name="query">запрос</param>
        /// <param name="startpos">начальный номер строки</param>
        /// <param name="takeRows">количество строк</param>
        /// <returns></returns>
        public DataSet SQL_SELECT_dataset(string query, int startpos, int takeRows)
        {
            OracleDataAdapter adapter = new OracleDataAdapter();
            DataSet ds = new DataSet();
            _command.Connection = _connect;
            adapter.SelectCommand = _command;
            _command.CommandText = MakePagingQuery(query, startpos, takeRows);
            adapter.Fill(ds);
            adapter.Dispose();
            return ds;
        }

        public DataSet SQL_SELECT_dataset(string query, int startpos, int takeRows, string[] data)
        {
            OracleDataAdapter adapter = new OracleDataAdapter();
            DataSet ds = new DataSet();
            _command.Connection = _connect;
            adapter.SelectCommand = _command;

            int pageSize = takeRows;

            //трансформируем запрос согласно щтатного кенду трасфортматорв
            //1. конвертнем данные запроса в кендо DataSourceRequest
            DataSourceRequest request = new DataSourceRequest()
            {
                Page = startpos / (pageSize - 1) + 1,
                PageSize = pageSize,
                Sorts = new List<SortDescriptor>()
            };
            if (!String.IsNullOrEmpty(data[3]))
            {
                //сортировки передаются сюда по-разному 
                //бывает просто перечень полей для сортировки через запятую
                if (data[3].IndexOf(", ") >= 0)
                {
                    string[] sort = data[3].Split(new[] { ", " }, StringSplitOptions.None);
                    foreach (var sortItem in sort)
                    {
                        request.Sorts.Add(new SortDescriptor()
                        {
                            Member = sortItem,
                            SortDirection = ListSortDirection.Ascending
                        });
                    }
                }
                else
                {
                    //бывает название колонки - направление
                    string[] sort = data[3].Split(' ');
                    request.Sorts.Add(new SortDescriptor()
                    {
                        Member = sort[0],
                        SortDirection = sort[1].ToUpper() == "DESC" ? ListSortDirection.Descending : ListSortDirection.Ascending
                    });
                }

            }
            //2. Создадим конвертер и произведем конвертацию
            KendoSqlTransformer sqlTransformer = new KendoSqlTransformer(null);
            BarsSql barssql = new BarsSql() { SqlText = query };

            var transFormedSql = sqlTransformer.TransformSql(barssql, request);
            //3. Пересчитаем параметри постраничной разбивки по правилам Grid2005
            int shiftRow = request.Page - 1;
            _command.Parameters.Add("p_startNumRow", OracleDbType.Decimal, Int32.Parse(((OracleParameter)transFormedSql.SqlParams[0]).Value.ToString()) - shiftRow, ParameterDirection.Input);
            _command.Parameters.Add("p_endNumRow", OracleDbType.Decimal, Int32.Parse(((OracleParameter)transFormedSql.SqlParams[1]).Value.ToString()) - shiftRow, ParameterDirection.Input);
            _command.CommandText = transFormedSql.SqlText;

            adapter.Fill(ds);
            adapter.Dispose();
            return ds;
        }

        /// <summary>
        ///  Строка значений параметров из web_userparams
        /// </summary>
        /// <param name="params_str">строка имен параметров через запятую</param>
        /// <param name="role">имя роли</param>
        /// <returns>строка значений</returns>
        [WebMethod(EnableSession = true)]
        public string GetUserParams(string params_str, string role)
        {
            string result = "";
            try
            {
                InitOraConnection(Context);
                SetRole(role);
                if (params_str != string.Empty)
                {
                    for (int i = 0; i < params_str.Split(';').Length; i++)
                    {
                        result += GetUserParam(params_str.Split(';')[i]) + ";";
                    }
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="fields"></param>
        /// <param name="tables"></param>
        /// <param name="cond"></param>
        /// <param name="field_for_count"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        public object[] BindTableWithFilter(string fields, string tables, string cond, string field_for_count, string[] data)
        {
            object[] obj = new object[3];
            DataSet ds = new DataSet();
            string query = "SELECT " + fields + " FROM " + tables;
            string tmp = "";
            if (data[0].Trim() == string.Empty)
            {
                tmp = cond.Trim() + data[1].Trim() + data[2].Trim();
                if (tmp.Length > 4)
                {
                    if (tmp.Substring(0, 4).ToUpper() == "AND ")
                        tmp = tmp.Substring(4);
                }
                if (tmp != "")
                    query += " WHERE " + tmp;
            }
            else
            {
                string cond1 = data[0].ToUpper(), temp_str, type_str, value_str, param_str, table_str;
                for (int i = 1; i < cond1.Split(' ').Length; i++)
                {
                    temp_str = cond1.Split(' ')[i];
                    if (temp_str.Length == 0) continue;
                    if (temp_str[0] == '@')
                    {
                        table_str = temp_str.Substring(1);
                        if (table_str != string.Empty)
                            query += "," + table_str;
                        cond1 = cond1.Replace(temp_str, "");
                    }
                    if (temp_str[0] == ':')
                    {
                        type_str = temp_str.Substring(1, 1);
                        param_str = temp_str.Substring(0, temp_str.IndexOf("["));
                        value_str = temp_str.Substring(temp_str.IndexOf("[") + 1, temp_str.IndexOf("]") - temp_str.IndexOf("[") - 1);
                        cond1 = cond1.Replace(temp_str, param_str);

                        if (type_str == "C")
                            SetParameters(param_str, DB_TYPE.Varchar2, value_str, DIRECTION.Input);
                        else if (type_str == "N")
                            SetParameters(param_str, DB_TYPE.Decimal, value_str, DIRECTION.Input);
                        else if (type_str == "D")
                        {
                            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                            cinfo.DateTimeFormat.DateSeparator = "/";
                            SetParameters(param_str, DB_TYPE.Date, Convert.ToDateTime(value_str, cinfo), DIRECTION.Input);
                        }
                        else if (type_str == "L")
                            cond1 = cond1.Replace(param_str, "(" + value_str + ")");
                    }
                }

                tmp = cond + " " + data[1] + " " + data[2] + " " + cond1;
                tmp = tmp.Trim();
                if (tmp.Length > 4)
                {
                    if (tmp.Substring(0, 4).ToUpper() == "AND ")
                        tmp = tmp.Substring(4);
                }
                query += " WHERE " + tmp;
            }
            if (field_for_count == string.Empty)
                field_for_count = "*";
            int count = Convert.ToInt32(SQL_SELECT_scalar("SELECT count(" + field_for_count + ") " + query.Substring(query.IndexOf("FROM"))).ToString());
            if (data[3] != string.Empty)
                query += " ORDER BY " + data[3];
            int startpos = Convert.ToInt32(data[4]);
            int pageSize = Convert.ToInt32(data[5]);

            ds = SQL_SELECT_dataset(query, startpos, pageSize);
            obj[0] = ds.GetXml();
            obj[1] = count;
            return obj;
        }

        public object[] BindTableWithFilter(string fields, string tables, string cond, string[] data)
        {
            object[] obj = new object[3];
            DataSet ds = new DataSet();
            string query = "SELECT " + fields + " FROM " + tables;
            string tmp = "";
            if (data[0].Trim() == string.Empty)
            {
                tmp = cond.Trim() + data[1].Trim() + data[2].Trim();
                if (tmp.Length > 4)
                {
                    if (tmp.Substring(0, 4).ToUpper() == "AND ")
                        tmp = tmp.Substring(4);
                }
                if (tmp != "")
                    query += " WHERE " + tmp;
            }
            else
            {
                string cond1 = data[0].ToUpper(), temp_str, type_str, value_str, param_str, table_str;
                for (int i = 1; i < cond1.Split(' ').Length; i++)
                {
                    temp_str = cond1.Split(' ')[i];
                    if (temp_str.Length == 0) continue;
                    if (temp_str[0] == '@')
                    {
                        table_str = temp_str.Substring(1);
                        if (table_str != string.Empty)
                            query += "," + table_str;
                        cond1 = cond1.Replace(temp_str, "");
                    }
                    if (temp_str[0] == ':')
                    {
                        type_str = temp_str.Substring(1, 1);
                        param_str = temp_str.Substring(0, temp_str.IndexOf("["));
                        value_str = temp_str.Substring(temp_str.IndexOf("[") + 1, temp_str.IndexOf("]") - temp_str.IndexOf("[") - 1);
                        cond1 = cond1.Replace(temp_str, param_str);

                        if (type_str == "C")
                            SetParameters(param_str, DB_TYPE.Varchar2, value_str, DIRECTION.Input);
                        else if (type_str == "N")
                            SetParameters(param_str, DB_TYPE.Decimal, value_str, DIRECTION.Input);
                        else if (type_str == "D")
                        {
                            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                            cinfo.DateTimeFormat.DateSeparator = "/";
                            SetParameters(param_str, DB_TYPE.Date, Convert.ToDateTime(value_str, cinfo), DIRECTION.Input);
                        }
                        else if (type_str == "L")
                            cond1 = cond1.Replace(param_str, "(" + value_str + ")");
                    }
                }

                tmp = cond + " " + data[1] + " " + data[2] + " " + cond1;
                tmp = tmp.Trim();
                if (tmp.Length > 4)
                {
                    if (tmp.Substring(0, 4).ToUpper() == "AND ")
                        tmp = tmp.Substring(4);
                }
                query += " WHERE " + tmp;
            }
            if (data[3] != string.Empty)
                query += " ORDER BY " + data[3];
            int startpos = Convert.ToInt32(data[4]);
            int pageSize = Convert.ToInt32(data[5]);

            ds = SQL_SELECT_dataset(query, startpos, pageSize + 1);

            int count = 0;
            if (ds.Tables[0].Rows.Count == pageSize + 1)
            {
                count = ds.Tables[0].Rows.Count + startpos;
                ds.Tables[0].Rows.RemoveAt(pageSize);
            }
            else
                count = pageSize + startpos - 1;

            obj[0] = ds.GetXml();
            obj[1] = count;
            return obj;
        }

        private string BuildSelectStatementForTable(string fields, string tables, string cond, string[] data)
        {
            string query = "SELECT " + fields + " FROM " + tables;
            string strWhere = string.Empty;
            string TabAlias = string.Empty;
            if (tables.Split(',')[0].Split(' ').Length == 1)
                TabAlias = tables.Split(',')[0].Split(' ')[0];
            else
                TabAlias = tables.Split(',')[0].Split(' ')[1];
            string idSysFilter = string.Empty;
            string idUserFilter = string.Empty;
            int pos = 0;
            if (data[20].Trim() != string.Empty)
            {
                ArrayList reader;
                if ((pos = data[20].IndexOf("[SYS:")) >= 0)
                {
                    idSysFilter = (data[20].Substring(pos + 5, data[20].IndexOf("]", pos) - pos - 5));
                    reader = SQL_reader("SELECT from_clause, where_clause FROM dyn_filter where filter_id=" + idSysFilter);
                    if (reader.Count != 0)
                    {
                        if (Convert.ToString(reader[0]) != string.Empty) query += "," + reader[0].ToString().Replace("OUTER", "");
                        if (Convert.ToString(reader[1]) != string.Empty) cond += " AND (" + Convert.ToString(reader[1]).Replace("$~~ALIAS~~$", TabAlias) + ") ";
                    }
                }
                if ((pos = data[20].IndexOf("[USER:")) >= 0)
                {
                    idUserFilter = (data[20].Substring(pos + 6, data[20].IndexOf("]", pos) - pos - 6));
                    reader = SQL_reader("SELECT from_clause, where_clause FROM dyn_filter where filter_id=" + idUserFilter);
                    if (reader.Count != 0)
                    {
                        if (Convert.ToString(reader[0]) != string.Empty) query += "," + reader[0].ToString().Replace("OUTER", "");
                        if (Convert.ToString(reader[1]) != string.Empty) cond += " AND (" + Convert.ToString(reader[1]).Replace("$~~ALIAS~~$", TabAlias) + ") ";
                    }
                }
            }
            if (data[0].Trim() == string.Empty)
            {
                strWhere = cond + " " + data[1] + " " + data[2];
                strWhere = strWhere.Trim();
                if (strWhere.Length > 4)
                    if (strWhere.Substring(0, 4).ToUpper() == "AND ") strWhere = strWhere.Substring(4);

                if (strWhere != string.Empty) query += " WHERE " + strWhere;
            }
            else
            {
                string cond1 = data[0], temp_str, type_str, value_str, param_str, table_str;
                cond1 = cond1.Replace("$ALIAS$", TabAlias);
                for (int i = 1; i < cond1.Split(' ').Length; i++)
                {
                    temp_str = cond1.Split(' ')[i];
                    if (temp_str.Length == 0) continue;
                    if (temp_str[0] == '@')
                    {
                        table_str = temp_str.Substring(1);
                        if (table_str != string.Empty)
                            query += "," + table_str;
                        cond1 = cond1.Replace(temp_str, "");
                    }
                    if (temp_str[0] == ':')
                    {
                        type_str = temp_str.Substring(1, 1);
                        param_str = temp_str.Substring(0, temp_str.IndexOf("["));
                        value_str = temp_str.Substring(temp_str.IndexOf("[") + 1, temp_str.IndexOf("]") - temp_str.IndexOf("[") - 1);
                        value_str = value_str.Replace("__space__", " ").Replace("__SPACE__", " ");
                        cond1 = cond1.Replace(temp_str, param_str);

                        if (type_str == "C" || type_str == "A")
                            SetParameters(param_str, DB_TYPE.Varchar2, value_str, DIRECTION.Input);
                        else if (type_str == "N")
                            SetParameters(param_str, DB_TYPE.Decimal, value_str, DIRECTION.Input);
                        else if (type_str == "D")
                        {
                            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                            cinfo.DateTimeFormat.DateSeparator = "/";
                            SetParameters(param_str, DB_TYPE.Date, Convert.ToDateTime(value_str, cinfo), DIRECTION.Input);
                        }
                        else if (type_str == "L")
                            cond1 = cond1.Replace(param_str, "(" + value_str + ")");
                    }
                }

                strWhere = cond + " " + data[1] + " " + data[2] + " " + cond1;
                strWhere = strWhere.Trim();
                if (strWhere.Length > 4)
                {
                    if (strWhere.Substring(0, 4).ToUpper() == "AND ")
                        strWhere = strWhere.Substring(4);
                }
                query += " WHERE " + strWhere;
            }
            return query;
        }

        public object GetFullXmlDataForTable(string fields, string tables, string cond, string[] data)
        {
            DataSet ds = new DataSet();

            string query = BuildSelectStatementForTable(fields, tables, cond, data);

            ds = SQL_SELECT_dataset(query);
            return ds.GetXml();
        }

        public DataSet GetFullDataSetForTable(string fields, string tables, string cond, string[] data)
        {
            DataSet ds = new DataSet();

            string query = BuildSelectStatementForTable(fields, tables, cond, data);

            ds = SQL_SELECT_dataset(query);
            return ds;
        }


        public object[] BindTableWithNewFilter(string fields, string tables, string cond, string[] data)
        {
            object[] obj = new object[3];
            DataSet ds = new DataSet();

            string query = BuildSelectStatementForTable(fields, tables, cond, data);
            int startpos = Convert.ToInt32(data[4]);
            int pageSize = Convert.ToInt32(data[5]);

            ds = SQL_SELECT_dataset(query, startpos, pageSize + 1, data);

            int count = 0;
            if (ds.Tables[0].Rows.Count == pageSize + 1)
            {
                count = ds.Tables[0].Rows.Count + startpos;
                ds.Tables[0].Rows.RemoveAt(pageSize);
            }
            else
                count = pageSize + startpos - 1;

            obj[0] = ds.GetXml();
            obj[1] = count;
            return obj;
        }

        public DataSet SQL_SELECT_dataset_count(string key, string query, int startpos, int maxpos)
        {
            OracleDataAdapter adapter = new OracleDataAdapter();
            DataSet ds = new DataSet();
            _command.Connection = _connect;
            adapter.SelectCommand = _command;
            _command.CommandText = query;
            adapter.Fill(ds, startpos, maxpos, "Table");
            _command.CommandText = countQuery(query, key);
            ds.DataSetName = _command.ExecuteScalar().ToString();
            adapter.Dispose();
            return ds;
        }
        public object SQL_SELECT_scalar(string query)
        {
            OracleDataReader reader = null;
            _command.Connection = _connect;
            _command.CommandText = query;
            object temp = null;
            reader = _command.ExecuteReader();
            if (reader.Read())
            {
                if (reader.IsDBNull(0)) temp = null;
                else temp = reader.GetValue(0);
            }
            reader.Close();
            reader.Dispose();
            return temp;
        }


        public void SQL_Reader_Exec(string query)
        {
            _command.Connection = _connect;
            _command.CommandText = query;
            _reader = _command.ExecuteReader();
        }
        public bool SQL_Reader_Read()
        {
            return _reader.Read();
        }
        public ArrayList SQL_Reader_GetValues()
        {
            ArrayList array = new ArrayList();
            for (int i = 0; i < _reader.FieldCount; i++)
            {
                if (_reader.IsDBNull(i)) array.Insert(i, "");
                else array.Insert(i, _reader.GetValue(i));
            }
            return array;
        }
        public void SQL_Reader_Close()
        {
            _reader.Close();
            _reader.Dispose();
        }

        public ArrayList SQL_reader(string query)
        {
            ArrayList array = new ArrayList();
            OracleDataReader reader = null;
            _command.Connection = _connect;
            _command.CommandText = query;
            reader = _command.ExecuteReader();
            if (reader.Read())
            {
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    if (reader.IsDBNull(i)) array.Insert(i, "");
                    else array.Insert(i, reader.GetValue(i));
                }
            }
            reader.Close();
            reader.Dispose();
            return array;
        }
        public object[] SQL_SELECT_reader(string query)
        {
            OracleDataReader reader = null;
            _command.Connection = _connect;
            _command.CommandText = query;
            object[] temp = new object[1000];
            reader = _command.ExecuteReader();
            if (reader.Read())
            {
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    if (reader.IsDBNull(i)) temp[i] = null;
                    else temp[i] = reader.GetValue(i);
                }
            }
            reader.Close();
            reader.Dispose();
            return temp;
        }
        public string SQL_SELECT_list(string query)
        {
            OracleDataReader reader = null;
            _command.Connection = _connect;
            _command.CommandText = query;
            string temp = "";
            reader = _command.ExecuteReader();
            while (reader.Read())
            {
                temp += Convert.ToString(reader.GetValue(0)) + ";";
            }
            reader.Close();
            reader.Dispose();
            return temp;
        }
        public int SQL_NONQUERY(string query)
        {
            int pos = -1;
            _command.Connection = _connect;
            _command.CommandText = query;
            pos = _command.ExecuteNonQuery();
            return pos;
        }

        public DataSet SQL_PROC_REFCURSOR(string proc_name, int startpos, int maxpos)
        {
            DataSet ds = new DataSet();
            OracleDataAdapter adapter = new OracleDataAdapter();
            _command.Connection = _connect;
            _command.Parameters.Add("P_CURSOR", OracleDbType.RefCursor, 2000, ParameterDirection.Output);
            _command.CommandType = CommandType.StoredProcedure;
            _command.CommandText = proc_name;
            adapter.SelectCommand = _command;
            adapter.Fill(ds, startpos, maxpos, "Table");
            adapter.Dispose();
            return ds;
        }
        public int SQL_PROCEDURE(string proc_name)
        {
            int pos = -1;
            _command.Connection = _connect;
            _command.CommandType = CommandType.StoredProcedure;
            _command.CommandText = proc_name;
            pos = _command.ExecuteNonQuery();
            _command.CommandType = CommandType.Text;
            return pos;
        }
        public void DisposeOraConnection()
        {
            if (_connect != null)
            {
                _connect.Close();
                _connect.Dispose();
                _connect = null;
            }
            if (_command != null)
                _command.Dispose();
            if (_reader != null)
            {
                _reader.Close();
                _reader.Dispose();
            }
        }
        //-----------------------------------------------
        public enum DB_TYPE
        {
            Byte = OracleDbType.Byte,
            Char = OracleDbType.Char,
            Date = OracleDbType.Date,
            Decimal = OracleDbType.Decimal,
            Double = OracleDbType.Double,
            Int16 = OracleDbType.Int16,
            Int32 = OracleDbType.Int32,
            Int64 = OracleDbType.Int64,
            Varchar2 = OracleDbType.Varchar2,
            RefCursor = OracleDbType.RefCursor,
            XmlType = OracleDbType.XmlType,
            Clob = OracleDbType.Clob,
            BFile = OracleDbType.BFile,
            Blob = OracleDbType.Blob,
            Long = OracleDbType.Long,
            LongRaw = OracleDbType.LongRaw,
            NChar = OracleDbType.NChar,
            NClob = OracleDbType.NClob,
            NVarchar2 = OracleDbType.NVarchar2,
            Raw = OracleDbType.Raw,
            TimeStamp = OracleDbType.TimeStamp
        };
        public enum DIRECTION
        {
            Input = ParameterDirection.Input,
            InputOutput = ParameterDirection.InputOutput,
            Output = ParameterDirection.Output,
            ReturnValue = ParameterDirection.ReturnValue
        };
        //Константы из Century
        public enum CUST_TYPE
        {
            BANK = 1,
            CORPS,
            PERSON
        };
        public enum ACC_TYPE
        {
            ACTIV = 1,
            PASSIV,
            ACTIVPASSIV
        };
        public enum OPER_TYPE
        {
            DEBET = 0,
            KREDIT,
            DEBET_INFO,
            KREDIT_INFO
        };
        public enum VIEWACC_TYPE
        {
            ALL_ACCOUNTS = 0,
            CUST_ACCOUNTS,
            TECH_ACCOUNTS,
            TECH_ACCOUNTS_EX,
            USER_ACCOUNTS,
            NALOG_ACCOUNTS,
            LNK_ACCOUNTS
        };
        public enum AVIEW
        {
            AVIEW_TECH = 0x0001,
            AVIEW_CUST = 0x0002,
            AVIEW_USER = 0x0004,
            AVIEW_ALL = 0x0008,
            AVIEW_ReadOnly = 0x0010,
            AVIEW_ExistOnly = 0x0400,
            AVIEW_NoClose = 0x8000,
            AVIEW_NoOpen = 0x10000,
            AVIEW_NoUpdate = 0x20000,
            AVIEW_NoEdit = 0x40000,
            AVIEW_Financial = 0x0020,
            AVIEW_Linked = 0x0040,
            AVIEW_Limit = 0x0080,
            AVIEW_Access = 0x0100,
            AVIEW_Special = 0x0200,
            AVIEW_Blocked = 0x0800,
            AVIEW_AllOptions = 0x2BE0,
            AVIEW_Interest = 0x2000,
            AVIEW_NoHistory = 0x1000,
            AVIEW_NoTurns = 0x4000,
            AVIEW_TAX = 0x0201,
            AVIEW_LINKED = 0x0202,
            AVIEW_HIST = 0x0100
        };
        public enum ACCESS
        {
            ACCESS_FULL = 1,
            ACCESS_READONLY,
            ACCESS_HOLDING
        };
        #endregion
    }
}
