﻿using System;
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
using Microsoft.Ajax.Utilities;
using CommandType = System.Data.CommandType;
using barsroot.core;
using System.Linq;
using BarsWeb.Core.Logger;
using System.IO;
using Bars.Configuration;
using System.Security.Principal;

namespace Bars
{
    public class BarsWebService : WebService
    {
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

        public DataSet SQL_SELECT_dataset(string query, int startpos, int takeRows, string[] data, LogParams lParams = null)
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

                    var orderParam = GetOrderParameter(query, sort[0]);

                    request.Sorts.Add(new SortDescriptor()
                    {
                        //Member = sort[0],

                        Member = orderParam,
                        SortDirection = sort.Length > 1 && sort[1].ToUpper() == "DESC" ? ListSortDirection.Descending : ListSortDirection.Ascending
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

            //4. Логируем запрос (если необходимо)
            if (null != lParams)
            {
                string sqlQuery = _command.CommandText;
                _command.Parameters.Cast<OracleParameter>().ForEach(p => { sqlQuery = sqlQuery.Replace(":" + p.ParameterName, p.Value.ToString()); });
                DbLoggerConstruct.NewDbLogger().Info(sqlQuery, lParams.CallerName);
            }

            adapter.Fill(ds);
            adapter.Dispose();
            return ds;
        }

        /// <summary>
        /// Отримує назву поля, по якому буде відбуватися сортування
        /// </summary>
        /// <param name="query">Запит, з якого буде вибиратися або псевдонім поля для сорутвання, або сама назва поля</param>
        /// <param name="sort">Поле, по якому буде відбуватися сортування</param>
        /// <returns></returns>
        private static string GetOrderParameter(string query, string sort)
        {
            if (sort.IsNullOrWhiteSpace())
            {
                return string.Empty;
            }

            int startPos = query.IndexOf(sort);
            if (startPos < 0) return sort;
            int endPosComa = query.IndexOf(",", startPos);
            int endPosFrom = query.ToLower().IndexOf("from", startPos);
            int endPos = endPosComa < endPosFrom && endPosComa > 0 ? endPosComa : endPosFrom;
            string orderParamsStr = query.Substring(startPos, endPos - startPos);
            string[] orderParams = orderParamsStr.Split(' ').Where(p => !string.IsNullOrWhiteSpace(p)).ToArray();
            string orderParam = string.Empty;
            if (orderParams.Length > 1)
            {
                orderParam = orderParams[orderParams.Length - 1];
            }
            else if (orderParams[0].Contains("."))
            {
                orderParam = orderParams[0].Substring(orderParams[0].IndexOf("."));
            }
            else
            {
                orderParam = orderParams[0];
            }
            return orderParam;
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
        #region login user

        protected string GetHostName()
        {
            string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
                userHost = HttpContext.Current.Request.UserHostAddress;

            if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
                userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

            return userHost;
        }
        protected void LoginUser(String userName)
        {
            // информация о текущем пользователе
            UserMap userMap = ConfigurationSettings.GetUserInfo(userName);

            try
            {
                InitOraConnection();
                // установка первичных параметров
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);  //ERROR
                SetParameters("p_hostname", DB_TYPE.Varchar2, GetHostName(), DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");
            }
            finally
            {
                DisposeOraConnection();
            }

            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;
        }
        protected void LoginUserInt(String userName)
        {
            // информация о текущем пользователе
            UserMap userMap = ConfigurationSettings.GetUserInfo(userName);

            try
            {
                InitOraConnection();
                // установка первичных параметров
                ClearParameters();
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);
                SetParameters("p_hostname", DB_TYPE.Varchar2, RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");

                ClearParameters();
                SetParameters("p_info", DB_TYPE.Varchar2,
                    String.Format("WebService: авторизация. Хост {0}, пользователь {1}", RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), userName),
                    DIRECTION.Input);
                SQL_PROCEDURE("bars_audit.info");
            }
            finally
            {
                DisposeOraConnection();
            }

            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;
        }

        protected void LogOutUser()
        {
            var context = HttpContext.Current;
            if (ConfigurationSettings.AppSettings["CustomAuthentication.UseSession"] != "On")
            {
                string port = (context.Request.ServerVariables["SERVER_PORT"] == "80") ? ("") : (context.Request.ServerVariables["SERVER_PORT"]);
                string cookieName = ConfigurationSettings.AppSettings["CustomAuthentication.Cookie.Name"] + port;
                HttpCookie cookie = context.Request.Cookies[cookieName.ToUpper()];
                if (cookie != null)
                {
                    cookie.Expires = DateTime.Now.AddDays(-1);
                    context.Response.Cookies.Add(cookie);
                }
            }
            ClearSessionTmpDir();
            // clear session in db
            try
            {
                InitOraConnection();
                SQL_PROCEDURE("bars.bars_login.logout_user");
            }
            finally
            {
                DisposeOraConnection();
            }

            //clear context user
            //context.User = new GenericPrincipal(new GenericIdentity(string.Empty), null);
        }
        public void ClearSessionTmpDir()
        {
            var context = HttpContext.Current;
            if (context != null && context.Session != null && context.Session.SessionID != null)
            {
                string strTempDir = Path.Combine(Environment.GetEnvironmentVariable("TEMP") ?? Path.GetTempPath(),
                    context.Session.SessionID);
                DeletePatch(strTempDir);
            }
        }
        private void DeletePatch(string dir)
        {
            if (Directory.Exists(dir))
            {
                DirectoryInfo dirInfo = new DirectoryInfo(dir);
                foreach (var file in dirInfo.GetFiles())
                {
                    try
                    {
                        file.Delete();
                    }
                    catch (System.Exception)
                    {
                        //тушимо Exception на випадок якщо файл зайнятий
                    }
                }
                foreach (var d in dirInfo.GetDirectories())
                {
                    DeletePatch(d.FullName);
                }
                try
                {
                    dirInfo.Delete();
                }
                catch (System.Exception)
                {
                    //тушимо Exception на випадок якщо каталог зайнятий
                }
            }
        }

        protected void AuthenticateUser(String userName, String password)
        {
            // авторизация пользователя по хедеру
            Boolean isAuthenticated = Bars.Application.CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated)
                LoginUserInt(userName);
        }
        #endregion
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
            {
                query += " ORDER BY " + data[3];
            }


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

            //query.IndexOf()
            if (query.Contains("FROM saldoa a WHERE FDAT BETWEEN :dat1 and :dat2 and ACC"))
            {
                query = query.Replace("ORDER BY a.fdat desc", "");
            }

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

        public string BuildSelectStatementForTable(string fields, string tables, string cond, string[] data)
        {
            return BuildSelectStatementForTable(fields, tables, cond, data, true);
        }

        public string BuildSelectStatementForTable(string fields, string tables, string cond, string[] data, bool addParams)
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
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
                    string seekOperator = idUserFilter.Contains(",") ? "in" : "=";
                    reader = SQL_reader(string.Format("SELECT from_clause, where_clause FROM dyn_filter where filter_id {0} ({1})", seekOperator, idUserFilter));
                    for (int i = 0; i < reader.Count; i++)
                    {
                        if (0 == i % 2 && Convert.ToString(reader[i]) != string.Empty) query += "," + reader[i].ToString().Replace("OUTER", "");
                        if (0 != i % 2 && Convert.ToString(reader[i]) != string.Empty) cond += " AND (" + Convert.ToString(reader[i]).Replace("$~~ALIAS~~$", TabAlias) + ") ";
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
                        {
                            if (addParams)
                                SetParameters(param_str, DB_TYPE.Varchar2, value_str, DIRECTION.Input);
                            else
                                cond1 = cond1.Replace(param_str, "'" + value_str + "'");
                        }
                        else if (type_str == "N")
                        {
                            if (addParams)
                                SetParameters(param_str, DB_TYPE.Decimal, value_str, DIRECTION.Input);
                            else
                                cond1 = cond1.Replace(param_str, value_str);
                        }
                        else if (type_str == "D")
                        {
                            if (addParams)
                                SetParameters(param_str, DB_TYPE.Date, Convert.ToDateTime(value_str, cinfo), DIRECTION.Input);
                            else
                                cond1 = cond1.Replace(param_str, "to_date('" + value_str + "', 'dd/MM/yyyy')");
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

            //adding kv nbs ob22 cond
            if (data.Length >= 24)
            {
                if (data[22] != "")
                    query += String.Format(" AND a.kv ={0}", data[22]);
                if (data[23] != "")
                    query += String.Format(" AND a.nbs = '{0}'", data[23]);
                if (data[24] != "")
                    query += String.Format(" AND a.kv = '{0}'", data[24]);
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


        public object[] BindTableWithNewFilter(string fields, string tables, string cond, string[] data, LogParams lParams = null)
        {
            //_command.Parameters.Clear();
            object[] obj = new object[3];
            DataSet ds = new DataSet();

            string query = BuildSelectStatementForTable(fields, tables, cond, data);
            int startpos = Convert.ToInt32(data[4]);
            int pageSize = Convert.ToInt32(data[5]);

            ds = SQL_SELECT_dataset(query, startpos, pageSize + 1, data, lParams);

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
            while (reader.Read())
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
    }

    public class LogParams
    {
        public string CallerName { get; set; }
    }
}
