using System;
using System.Globalization;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Collections.Generic;
using System.Web.Services.Protocols;
using System.Xml.Serialization;
using Bars;
using Bars.Classes;
using Bars.WebServices;
using Oracle.DataAccess.Client;
using System.Data;
using barsroot.core;
using Bars.Application;

/// <summary>
/// Веб-сервіс для біржових операцій
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class ExchangeOperationRUService : BarsWebService
{
    public WsHeader WsHeaderValue;

    #region private методы
    private void LoginUser(String userName)
    {
        // Інформація про поточного користувача
        UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        using (con)
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars.bars_login.login_user";

            cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, Session.SessionID, ParameterDirection.Input);
            cmd.Parameters.Add("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input);
            cmd.Parameters.Add("p_hostname", OracleDbType.Varchar2, GetHostName(), ParameterDirection.Input);
            cmd.Parameters.Add("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        Session["UserLoggedIn"] = true;
    }

    private string GetHostName()
    {
        string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
            userHost = HttpContext.Current.Request.UserHostAddress;

        if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
            userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

        return userHost;
    }

    private DateTime? ParseDateFromString(string dateStr, string format)
    {
        DateTime result;
        if (DateTime.TryParseExact(dateStr, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out result))
        {
            //если смогли распарсить строку возвращаем объект DateTime
            return result;
        }
        //иначе возвращаем null
        return null;
    }

    #endregion

    #region методы веб-сервиса

    //[XmlType("ListOfDealerCourseInfo")]
    //public class ListOfDealerCourseInfo
    //{
    //    [XmlElement("Data")]
    //    public List<DealerCourseInfo> Data = new List<DealerCourseInfo>();
    //}

    /// <summary>
    /// Установить курсы дилера. ЦА-РУ. Веб-сервис для передачи состояния таблицы DILER_KURS за дату и DILER_KURS_CONV за дату.
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> SetDealerCourse(string xmlDealerCourse, string xmlDealerCourseConv, string currentDate)
    {
        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
        if (isAuthenticated) LoginUser(barsUserName);

        OracleConnection con = OraConnector.Handler.UserConnection;
        try
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars_zay.iparse_dilerkurs";
            cmd.Parameters.Add(new OracleParameter("p_kurs_clob", OracleDbType.Clob) { Value = xmlDealerCourse });
            cmd.Parameters.Add(new OracleParameter("p_conv_clob", OracleDbType.Clob) { Value = xmlDealerCourseConv });
            cmd.Parameters.Add(new OracleParameter("p_dat", OracleDbType.Varchar2) { Value = currentDate });
            cmd.ExecuteNonQuery();
            return new Response<string>
            {
                Status = "ok",
                ErrorMessage = "",
                Data = null
            };
        }
        catch (Exception e)
        {
            return new Response<string>
            {
                Status = "error",
                ErrorMessage = e.Message + (e.InnerException == null? "" : ". " + e.InnerException.Message),
                Data = null
            };
        }
        finally
        {
            con.Close();
        }
    }

    /// <summary>
    /// Установить курсы дилера фактические. ЦА-РУ. Веб-сервис для передачи состояния таблицы DILER_KURS_FACT за дату.
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> SetDealerCourseFact(string xmlDealerCourseFact)
    {
        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
        if (isAuthenticated) LoginUser(barsUserName);

        OracleConnection con = OraConnector.Handler.UserConnection;
        try
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SetDealerCourse";
            cmd.Parameters.Add(new OracleParameter("SetDealerCourseFact", OracleDbType.Date) { Value = xmlDealerCourseFact });
            cmd.ExecuteNonQuery();
            return new Response<string>
            {
                Status = "ok",
                ErrorMessage = "",
                Data = null
            };
        }
        catch (Exception e)
        {
            return new Response<string>
            {
                Status = "error",
                ErrorMessage = e.Message + (e.InnerException == null ? "" : ". " + e.InnerException.Message),
                Data = null
            };
        }
        finally
        {
            con.Close();
        }
    }

    /// <summary>
    /// ЦА-РУ. Веб-сервис для передачи информации об изменении ZAYAVKA_RU.SOS на 1.
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> ChangeSOS(decimal? req_id, decimal? kurs_f, decimal? sos, string vdate, decimal? close_type, string datz, decimal? viza, decimal? id_back, string reason_comm)
    {
        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
        if (isAuthenticated) LoginUser(barsUserName);

        OracleConnection con = OraConnector.Handler.UserConnection;
        try
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars_zay.set_visa_in_ru";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new OracleParameter("p_id", OracleDbType.Decimal) { Value = req_id });
            cmd.Parameters.Add(new OracleParameter("p_kurs_f", OracleDbType.Decimal) { Value = kurs_f });
            cmd.Parameters.Add(new OracleParameter("p_sos", OracleDbType.Decimal) { Value = sos });
            cmd.Parameters.Add(new OracleParameter("p_vdate", OracleDbType.Date) { Value = ParseDateFromString(vdate, "dd.MM.yyyy") });
            cmd.Parameters.Add(new OracleParameter("p_close_type", OracleDbType.Decimal) { Value = close_type });
            cmd.Parameters.Add(new OracleParameter("p_datz", OracleDbType.Date) { Value = ParseDateFromString(datz, "dd.MM.yyyy") });
            cmd.Parameters.Add(new OracleParameter("p_viza", OracleDbType.Decimal) { Value = viza });
            cmd.Parameters.Add(new OracleParameter("p_id_back", OracleDbType.Decimal) { Value = id_back });
            cmd.Parameters.Add(new OracleParameter("p_reason_comm", OracleDbType.Varchar2) { Value = reason_comm });
            

            cmd.ExecuteNonQuery();
            return new Response<string>
            {
                Status = "ok",
                ErrorMessage = "",
                Data = null
            };
        }
        catch (Exception e)
        {
            return new Response<string>
            {
                Status = "error",
                ErrorMessage = e.Message + (e.InnerException == null ? "" : ". " + e.InnerException.Message),
                Data = null
            };
        }
        finally
        {
            con.Close();
        }
    }

    /// <summary>
    /// РУ-ЦА. Веб-сервис передачи поля ZAYAVKA.REF_SPS
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> SetRefSps(string mfo, decimal req_id, decimal ref_sps)
    {
        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
        if (isAuthenticated) LoginUser(barsUserName);

        OracleConnection con = OraConnector.Handler.UserConnection;
        try
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars_zay.set_refsps_in_ca";
            cmd.Parameters.Add(new OracleParameter("p_mfo", OracleDbType.Varchar2) { Value = mfo });
            cmd.Parameters.Add(new OracleParameter("p_id", OracleDbType.Decimal) { Value = req_id });
            cmd.Parameters.Add(new OracleParameter("p_ref_sps", OracleDbType.Decimal) { Value = ref_sps });
            cmd.ExecuteNonQuery();
            return new Response<string>
            {
                Status = "ok",
                ErrorMessage = "",
                Data = null
            };
        }
        catch (Exception e)
        {
            return new Response<string>
            {
                Status = "error",
                ErrorMessage = e.Message + (e.InnerException == null ? "" : ". " + e.InnerException.Message),
                Data = null
            };
        }
        finally
        {
            con.Close();
        }
    }

    /// <summary>
    /// ЦА -> РУ. Веб-сервис разбивки заявки p_zay_multiple
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> MultipleRequest(decimal req_id, decimal sum1, decimal sum2)
    {
        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
        if (isAuthenticated) LoginUser(barsUserName);

        OracleConnection con = OraConnector.Handler.UserConnection;
        try
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars_zay.p_zay_multiple";
            cmd.Parameters.Add(new OracleParameter("p_id", OracleDbType.Decimal) { Value = req_id });
            cmd.Parameters.Add(new OracleParameter("p_sum1", OracleDbType.Decimal) { Value = sum1 });
            cmd.Parameters.Add(new OracleParameter("p_sum2", OracleDbType.Decimal) { Value = sum2 });
            cmd.ExecuteNonQuery();
            return new Response<string>
            {
                Status = "ok",
                ErrorMessage = "",
                Data = null
            };
        }
        catch (Exception e)
        {
            return new Response<string>
            {
                Status = "error",
                ErrorMessage = e.Message + (e.InnerException == null ? "" : ". " + e.InnerException.Message),
                Data = null
            };
        }
        finally
        {
            con.Close();
        }
    }

    #endregion

    #region вспомогательные классы
    //public class DealerCourseInfo
    //{
    //    public DateTime? DAT { get; set; }
    //    public decimal? KV { get; set; }
    //    public decimal? ID { get; set; }
    //    public decimal? KURS_B { get; set; }
    //    public decimal? KURS_S { get; set; }
    //    public decimal? VIP_B { get; set; }
    //    public decimal? VIP_S { get; set; }
    //    public decimal? BLK { get; set; }
    //    public decimal? CODE { get; set; }
    //}

    //public class DealerCourseConvInfo
    //{
    //    public decimal? KV1 { get; set; }
    //    public decimal? KV2 { get; set; }
    //    public DateTime? DAT { get; set; }
    //    public decimal? KURS_I { get; set; }
    //    public decimal? KURS_F { get; set; }
    //}

    //public class DealerCourseFactInfo
    //{
    //    public DateTime? DAT { get; set; }
    //    public decimal? KV { get; set; }
    //    public decimal? ID { get; set; }
    //    public decimal? KURS_B { get; set; }
    //    public decimal? KURS_S { get; set; }
    //    public decimal? CODE { get; set; }
    //}

    public class Response<T>
    {
        public string Status { get; set; }
        public string ErrorMessage { get; set; }
        public T Data { get; set; }
    }
    #endregion
}
