using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

using System.Xml;
using System.Globalization;
using System.Web.Script.Serialization;

using Bars.Application;
using Bars.WebServices;
using Bars.Classes;
using Bars.Exception;
using barsroot.core;
using Bars.Logger;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.IO;



namespace Bars.WebServices.Skrynka
{
    
    public class AddType
    {


        public AddType(
         Int64 O_SK,
         String Branch,
         String Name,
         Int64 EtalonID,
         Int64 CellCount)
        {



            DBLogger.Info("Addtype(" + O_SK.ToString() + "," + Branch + "," + Name + "," + EtalonID.ToString() + "," + CellCount.ToString() + ");", "Skrynka");
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.Parameters.Clear();
                cmd.CommandText = @"skrynka_sync.add_type";
                cmd.Parameters.Add("p_o_sk", OracleDbType.Decimal, O_SK, ParameterDirection.Input);
                cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, Branch, ParameterDirection.Input);
                cmd.Parameters.Add("p_name", OracleDbType.Varchar2, Name, ParameterDirection.Input);
                cmd.Parameters.Add("p_etalon_id", OracleDbType.Decimal, EtalonID, ParameterDirection.Input);
                cmd.Parameters.Add("p_cell_count", OracleDbType.Decimal, CellCount, ParameterDirection.Input);

                cmd.ExecuteNonQuery();


            }
            catch (System.Exception e)
            {
                DBLogger.Info("Помилка при " + e.Message, "Skrynka");
                throw e;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }

    public class AddND
    {

        public AddND(
         Int64 O_SK,
         String Branch,
         Int64 ND,
         String OpenDate,
         String CloseDate,
         String RenterName)
        {
            DBLogger.Info("AddND(" + O_SK.ToString() + "," + Branch + "," + ND.ToString() + "," + OpenDate + "," + CloseDate + "," + RenterName + ");", "Skrynka");
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.Parameters.Clear();
                cmd.CommandText = @"skrynka_sync.add_nd";
                cmd.Parameters.Add("p_o_sk", OracleDbType.Decimal, O_SK, ParameterDirection.Input);
                cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, Branch, ParameterDirection.Input);
                cmd.Parameters.Add("p_nd", OracleDbType.Decimal, ND, ParameterDirection.Input);
                cmd.Parameters.Add("p_open_date", OracleDbType.Varchar2, OpenDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_close_date", OracleDbType.Varchar2, CloseDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_renter_name", OracleDbType.Varchar2, RenterName, ParameterDirection.Input);

                cmd.ExecuteNonQuery();


            }
            catch (System.Exception e)
            {
                DBLogger.Info("Помилка при " + e.Message, "Skrynka");
                throw e;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }


    /// <summary>
    /// Сервис для передачі інформації від РУ до ГОУ для звітності по депозитним сейфам
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class SkrynkaService : Bars.BarsWebService
    {
        # region Константы
        public const String XMLVersion = "1.0";
        public const String XMLEncoding = "UTF-8";
        public const String DateFormat = "yyyy.MM.dd";
        public const String DateTimeFormat = "yyyy.MM.dd HH:mm:ss";
        public const String NumberFormat = "######################0.00##";
        public const String DecimalSeparator = ".";
        # endregion

        # region Конструкторы
        public SkrynkaService()
        {
        }
        # endregion

        # region Публичные свойства
        public WsHeader WsHeaderValue;
        # endregion

        # region Приватные методы
        private string GetHostName()
        {
            string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
                userHost = HttpContext.Current.Request.UserHostAddress;

            if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
                userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

            return userHost;
        }
        private void LoginUser(String userName)
        {
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            try
            {
                InitOraConnection();
                // установка первичных параметров
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);
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
        # endregion

        # region Веб-методы

        [WebMethod(EnableSession = true)]
        public void AddType(
         String UserName,
         String Password,
         Int64 O_SK,
         String Branch,
         String Name,
         Int64 EtalonId,
         Int64 CellCount)
        {
            try
            {
                Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
                if (isAuthenticated) LoginUser(UserName);

                AddType type = new Skrynka.AddType(O_SK, Branch, Name, EtalonId, CellCount);
            }
            catch (System.Exception e)
            {
                DBLogger.Info(e.Message, "Skrynka");
                throw e;
               
            }

        }

        [WebMethod(EnableSession = true)]
        public void AddND(
         String UserName,
         String Password,
         Int64 O_SK,
         String Branch,
         Int64 ND,
         String OpenDate,
         String CloseDate,
         String RenterName)
        {
            try
            {
                Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
                if (isAuthenticated) LoginUser(UserName);
                
                AddND nd = new Skrynka.AddND(O_SK, Branch, ND, OpenDate, CloseDate, RenterName);
            }
            catch (System.Exception e)
            {
                DBLogger.Info(e.Message, "Skrynka");
                throw e;
            }

        }

        # endregion
    }
}