using System;
using System.Globalization;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
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
                ErrorMessage = e.Message + (e.InnerException == null ? "" : ". " + e.InnerException.Message),
                Data = null
            };
        }
        finally
        {
            LogOutUser();
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
            LogOutUser();
            con.Close();
        }
    }

    /// <summary>
    /// ЦА-РУ. Веб-сервис для передачи информации об изменении ZAYAVKA_RU.SOS на 1.
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> ChangeSOS(decimal? req_id, decimal? kurs_f, decimal? sos, string vdate, decimal? close_type, string datz, decimal? viza, decimal? id_back, string reason_comm, string mfo)
    {
        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
        if (isAuthenticated) LoginUser(barsUserName);

        InitOraConnection();
        try
        {
            ClearParameters();
            SetParameters("p_mfo", DB_TYPE.Varchar2, mfo, DIRECTION.Input);
            SetParameters("p_id", DB_TYPE.Decimal, req_id, DIRECTION.Input);
            SetParameters("p_kurs_f", DB_TYPE.Decimal, kurs_f, DIRECTION.Input);
            SetParameters("p_sos", DB_TYPE.Decimal, sos, DIRECTION.Input);
            SetParameters("p_vdate", DB_TYPE.Date, ParseDateFromString(vdate, "dd.MM.yyyy"), DIRECTION.Input);
            SetParameters("p_close_type", DB_TYPE.Decimal, close_type, DIRECTION.Input);
            SetParameters("p_datz", DB_TYPE.Date, ParseDateFromString(datz, "dd.MM.yyyy"), DIRECTION.Input);
            SetParameters("p_viza", DB_TYPE.Decimal, viza, DIRECTION.Input);
            SetParameters("p_id_back", DB_TYPE.Decimal, id_back, DIRECTION.Input);
            SetParameters("p_reason_comm", DB_TYPE.Varchar2, reason_comm, DIRECTION.Input);


            SQL_NONQUERY(@"begin 
                bc.go(:p_mfo); 
                bars_zay.set_visa_in_ru(:p_id, :p_kurs_f, :p_sos, :p_vdate, :p_close_type, :p_datz, :p_viza, :p_id_back, :p_reason_comm);
                bc.home();
                end;");

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
            LogOutUser();
            DisposeOraConnection();
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

        InitOraConnection();
        try
        {
            ClearParameters();
            SetParameters("p_mfo2", DB_TYPE.Varchar2, mfo, DIRECTION.Input);
            SetParameters("p_mfo", DB_TYPE.Varchar2, mfo, DIRECTION.Input);
            SetParameters("p_id", DB_TYPE.Decimal, req_id, DIRECTION.Input);
            SetParameters("p_ref_sps", DB_TYPE.Decimal, ref_sps, DIRECTION.Input);


            SQL_NONQUERY(@"begin 
                bc.go(:p_mfo2); 
                bars_zay.set_refsps_in_ca(:p_mfo, :p_id, :p_ref_sps);
                bc.home();
                end;");
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
            LogOutUser();
            DisposeOraConnection();
        }
    }

    /// <summary>
    /// ЦА -> РУ. Веб-сервис разбивки заявки p_zay_multiple
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> MultipleRequest(decimal? req_id, decimal? sum1, decimal? sum2, string mfo)
    {
        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
        if (isAuthenticated) LoginUser(barsUserName);

        InitOraConnection();
        try
        {

            ClearParameters();
            SetParameters("p_mfo", DB_TYPE.Varchar2, mfo, DIRECTION.Input);
            SetParameters("p_id", DB_TYPE.Decimal, req_id, DIRECTION.Input);
            SetParameters("p_sum1", DB_TYPE.Decimal, sum1, DIRECTION.Input);
            SetParameters("p_sum2", DB_TYPE.Decimal, sum2, DIRECTION.Input);


            SQL_NONQUERY(@"begin
                           bc.go(:p_mfo);
                           bars_zay.p_zay_multiple(:p_id, :p_sum1, :p_sum2);
                           bc.home();
                          end;
                          ");
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
            LogOutUser();
            DisposeOraConnection();
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
