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
public class ExchangeOperationCAService : BarsWebService
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

    /// <summary>
    /// Создать/обновить пользовательскую заявку в CA по строке V_ZAY в RU. РУ-ЦА. 
    /// Веб-сервис для передачи информации о новой записи в ZAYAVKA. 
    /// Передавать информацию из V_ZAY по новому ID в таблицу ZAYAVKA_RU ЦА. 
    /// Также передавать после изменений полей SOS, VIZA состояние таблицы ZAY_TRACK
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> SetRequest(
        decimal? flag,
        string mfo, decimal? id, decimal? dk, decimal? obz, string nd, string fdat, string datt, string rnk, string nmk, string nd_rnk, 
        decimal? kv_conv, string lcv_conv, decimal? kv2, string lcv, decimal? dig, decimal? s2, decimal? s2s, decimal? s3, decimal? kom, 
        decimal? skom, decimal? kurs_z, decimal? kurs_f, string vdate, string datz, decimal? acc0, string nls_acc0, string mfo0, string nls0, 
        string okpo0, decimal? ostc0, decimal? acc1, decimal? ostc, string nls, decimal? sos, decimal? @ref, decimal? viza, decimal? priority, 
        string priorname, decimal? priorverify, decimal? idback, decimal? fl_pf, string mfop, string nlsp, string okpop, string rnk_pf, 
        decimal? pid, string contract, string dat2_vmd, decimal? meta, string aim_name, string basis, string product_group, 
        string product_group_name, string num_vmd, string dat_vmd, string dat5_vmd, decimal? country, decimal? benefcountry,
        string bank_code, string bank_name, decimal? userid, string branch, decimal? fl_kursz, string identkb, string comm, 
        string cust_branch, string kurs_kl, string contact_fio, string contact_tel, decimal? verify_opt, decimal? close_type, 
        string close_type_name, decimal? aims_code, decimal? s_pf, decimal? ref_pf, decimal? ref_sps, string start_time, string state,
        string operid_nokk, decimal? req_type)
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
            cmd.CommandText = "BARS_ZAY.SET_REQUEST_IN_CA";
            cmd.Parameters.Add(new OracleParameter("p_flag", OracleDbType.Decimal) { Value = flag });
            cmd.Parameters.Add(new OracleParameter("p_mfo", OracleDbType.Varchar2) { Value = mfo });
            cmd.Parameters.Add(new OracleParameter("p_id", OracleDbType.Decimal) { Value = id });
            cmd.Parameters.Add(new OracleParameter("p_dk", OracleDbType.Decimal) { Value = dk });
            cmd.Parameters.Add(new OracleParameter("p_obz", OracleDbType.Decimal) { Value = obz });
            cmd.Parameters.Add(new OracleParameter("p_nd", OracleDbType.Varchar2) { Value = nd });
            cmd.Parameters.Add(new OracleParameter("p_fdat", OracleDbType.Date) { Value = ParseDateFromString(fdat, "dd.MM.yyyy") });
            cmd.Parameters.Add(new OracleParameter("p_datt", OracleDbType.Date) { Value = ParseDateFromString(datt, "dd.MM.yyyy") });
            cmd.Parameters.Add(new OracleParameter("p_rnk", OracleDbType.Varchar2) { Value = rnk });
            cmd.Parameters.Add(new OracleParameter("p_nmk", OracleDbType.Varchar2) { Value = nmk });
            cmd.Parameters.Add(new OracleParameter("p_nd_rnk", OracleDbType.Varchar2) { Value = nd_rnk });
            cmd.Parameters.Add(new OracleParameter("p_kv_conv", OracleDbType.Decimal) { Value = kv_conv });
            cmd.Parameters.Add(new OracleParameter("p_lcv_conv", OracleDbType.Varchar2) { Value = lcv_conv });
            cmd.Parameters.Add(new OracleParameter("p_kv2", OracleDbType.Decimal) { Value = kv2 });
            cmd.Parameters.Add(new OracleParameter("p_lcv", OracleDbType.Varchar2) { Value = lcv });
            cmd.Parameters.Add(new OracleParameter("p_dig", OracleDbType.Decimal) { Value = dig });
            cmd.Parameters.Add(new OracleParameter("p_s2", OracleDbType.Decimal) { Value = s2 });
            cmd.Parameters.Add(new OracleParameter("p_s2s", OracleDbType.Decimal) { Value = s2s });
            cmd.Parameters.Add(new OracleParameter("p_s3", OracleDbType.Decimal) { Value = s3 });
            cmd.Parameters.Add(new OracleParameter("p_kom", OracleDbType.Decimal) { Value = kom });
            cmd.Parameters.Add(new OracleParameter("p_skom", OracleDbType.Decimal) { Value = skom });
            cmd.Parameters.Add(new OracleParameter("p_kurs_z", OracleDbType.Decimal) { Value = kurs_z });
            cmd.Parameters.Add(new OracleParameter("p_kurs_f", OracleDbType.Decimal) { Value = kurs_f });
            cmd.Parameters.Add(new OracleParameter("p_vdate", OracleDbType.Date) { Value = ParseDateFromString(vdate, "dd.MM.yyyy") });
            cmd.Parameters.Add(new OracleParameter("p_datz", OracleDbType.Date) { Value = ParseDateFromString(datz, "dd.MM.yyyy") });
            cmd.Parameters.Add(new OracleParameter("p_acc0", OracleDbType.Decimal) { Value = acc0 });
            cmd.Parameters.Add(new OracleParameter("p_nls_acc0", OracleDbType.Varchar2) { Value = nls_acc0 });
            cmd.Parameters.Add(new OracleParameter("p_mfo0", OracleDbType.Varchar2) { Value = mfo0 });
            cmd.Parameters.Add(new OracleParameter("p_nls0", OracleDbType.Varchar2) { Value = nls0 });
            cmd.Parameters.Add(new OracleParameter("p_okpo0", OracleDbType.Varchar2) { Value = okpo0 });
            cmd.Parameters.Add(new OracleParameter("p_ostc0", OracleDbType.Decimal) { Value = ostc0 });
            cmd.Parameters.Add(new OracleParameter("p_acc1", OracleDbType.Decimal) { Value = acc1 });
            cmd.Parameters.Add(new OracleParameter("p_ostc", OracleDbType.Decimal) { Value = ostc });
            cmd.Parameters.Add(new OracleParameter("p_nls", OracleDbType.Varchar2) { Value = nls });
            cmd.Parameters.Add(new OracleParameter("p_sos", OracleDbType.Decimal) { Value = sos });
            cmd.Parameters.Add(new OracleParameter("p_ref", OracleDbType.Decimal) { Value = @ref });
            cmd.Parameters.Add(new OracleParameter("p_viza", OracleDbType.Decimal) { Value = viza });
            cmd.Parameters.Add(new OracleParameter("p_priority", OracleDbType.Decimal) { Value = priority });
            cmd.Parameters.Add(new OracleParameter("p_priorname", OracleDbType.Varchar2) { Value = priorname });
            cmd.Parameters.Add(new OracleParameter("p_priorverify", OracleDbType.Decimal) { Value = priorverify });
            cmd.Parameters.Add(new OracleParameter("p_idback", OracleDbType.Decimal) { Value = idback });
            cmd.Parameters.Add(new OracleParameter("p_fl_pf", OracleDbType.Decimal) { Value = fl_pf });
            cmd.Parameters.Add(new OracleParameter("p_mfop", OracleDbType.Varchar2) { Value = mfop });
            cmd.Parameters.Add(new OracleParameter("p_nlsp", OracleDbType.Varchar2) { Value = nlsp });
            cmd.Parameters.Add(new OracleParameter("p_okpop", OracleDbType.Varchar2) { Value = okpop });
            cmd.Parameters.Add(new OracleParameter("p_rnk_pf", OracleDbType.Varchar2) { Value = rnk_pf });
            cmd.Parameters.Add(new OracleParameter("p_pid", OracleDbType.Decimal) { Value = pid });
            cmd.Parameters.Add(new OracleParameter("p_contract", OracleDbType.Varchar2) { Value = contract });
            cmd.Parameters.Add(new OracleParameter("p_dat2_vmd", OracleDbType.Date) { Value = ParseDateFromString(dat2_vmd, "dd.MM.yyyy") });
            cmd.Parameters.Add(new OracleParameter("p_meta", OracleDbType.Decimal) { Value = meta });
            cmd.Parameters.Add(new OracleParameter("p_aim_name", OracleDbType.Varchar2) { Value = aim_name });
            cmd.Parameters.Add(new OracleParameter("p_basis", OracleDbType.Varchar2) { Value = basis });
            cmd.Parameters.Add(new OracleParameter("p_product_group", OracleDbType.Varchar2) { Value = product_group });
            cmd.Parameters.Add(new OracleParameter("p_product_group_name", OracleDbType.Varchar2) { Value = product_group_name });
            cmd.Parameters.Add(new OracleParameter("p_num_vmd", OracleDbType.Varchar2) { Value = num_vmd });
            cmd.Parameters.Add(new OracleParameter("p_dat_vmd", OracleDbType.Date) { Value = ParseDateFromString(dat_vmd, "dd.MM.yyyy") });
            cmd.Parameters.Add(new OracleParameter("p_dat5_vmd", OracleDbType.Varchar2) { Value = dat5_vmd });
            cmd.Parameters.Add(new OracleParameter("p_country", OracleDbType.Decimal) { Value = country });
            cmd.Parameters.Add(new OracleParameter("p_benefcountry", OracleDbType.Decimal) { Value = benefcountry });
            cmd.Parameters.Add(new OracleParameter("p_bank_code", OracleDbType.Varchar2) { Value = bank_code });
            cmd.Parameters.Add(new OracleParameter("p_bank_name", OracleDbType.Varchar2) { Value = bank_name });
            cmd.Parameters.Add(new OracleParameter("p_userid", OracleDbType.Decimal) { Value = userid });
            cmd.Parameters.Add(new OracleParameter("p_branch", OracleDbType.Varchar2) { Value = branch });
            cmd.Parameters.Add(new OracleParameter("p_fl_kursz", OracleDbType.Decimal) { Value = fl_kursz });
            cmd.Parameters.Add(new OracleParameter("p_identkb", OracleDbType.Varchar2) { Value = identkb });
            cmd.Parameters.Add(new OracleParameter("p_comm", OracleDbType.Varchar2) { Value = comm });
            cmd.Parameters.Add(new OracleParameter("p_cust_branch", OracleDbType.Varchar2) { Value = cust_branch });
            cmd.Parameters.Add(new OracleParameter("p_kurs_kl", OracleDbType.Varchar2) { Value = kurs_kl });
            cmd.Parameters.Add(new OracleParameter("p_contact_fio", OracleDbType.Varchar2) { Value = contact_fio });
            cmd.Parameters.Add(new OracleParameter("p_contact_tel", OracleDbType.Varchar2) { Value = contact_tel });
            cmd.Parameters.Add(new OracleParameter("p_verify_opt", OracleDbType.Decimal) { Value = verify_opt });
            cmd.Parameters.Add(new OracleParameter("p_close_type", OracleDbType.Decimal) { Value = close_type });
            cmd.Parameters.Add(new OracleParameter("p_close_type_name", OracleDbType.Varchar2) { Value = close_type_name });
            cmd.Parameters.Add(new OracleParameter("p_aims_code", OracleDbType.Decimal) { Value = aims_code });
            cmd.Parameters.Add(new OracleParameter("p_s_pf", OracleDbType.Decimal) { Value = s_pf });
            cmd.Parameters.Add(new OracleParameter("p_ref_pf", OracleDbType.Decimal) { Value = ref_pf });
            cmd.Parameters.Add(new OracleParameter("p_ref_sps", OracleDbType.Decimal) { Value = ref_sps });
            cmd.Parameters.Add(new OracleParameter("p_start_time", OracleDbType.Date) { Value = ParseDateFromString(start_time, "dd.MM.yyyy H:mm:ss") });
            cmd.Parameters.Add(new OracleParameter("p_state", OracleDbType.Varchar2) { Value = state });
            cmd.Parameters.Add(new OracleParameter("p_operid_nokk", OracleDbType.Varchar2) { Value = operid_nokk });
            cmd.Parameters.Add(new OracleParameter("p_req_type", OracleDbType.Decimal) { Value = req_type });
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
    /// Передача состаяния таблицы ZAY_TRACK. РУ-ЦА. 
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> SetTrack(string mfo, decimal? track_id, decimal? req_id, string change_time, string fio, decimal? sos, decimal? viza, string viza_name)
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
            cmd.CommandText = "BARS_ZAY.SET_ZAYTRACK_IN_CA";
            cmd.Parameters.Add(new OracleParameter("mfo", OracleDbType.Varchar2) { Value = mfo });
            cmd.Parameters.Add(new OracleParameter("track_id", OracleDbType.Decimal) { Value = track_id });
            cmd.Parameters.Add(new OracleParameter("req_id", OracleDbType.Decimal) { Value = req_id });
            cmd.Parameters.Add(new OracleParameter("change_time", OracleDbType.Date) { Value = ParseDateFromString(change_time, "dd.MM.yyyy H:mm:ss") });
            cmd.Parameters.Add(new OracleParameter("fio", OracleDbType.Varchar2) { Value = fio });
            cmd.Parameters.Add(new OracleParameter("sos", OracleDbType.Decimal) { Value = sos });
            cmd.Parameters.Add(new OracleParameter("viza", OracleDbType.Decimal) { Value = viza });
            cmd.Parameters.Add(new OracleParameter("viza_name", OracleDbType.Varchar2) { Value = viza_name });
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
    /// Обновить поле VIZA в таблице ZAYAVKA_RU. РУ-ЦА. Веб-сервис для передачи информации об изменении ZAYAVKA.VIZA.
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> UpdateViza(string viza)
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
            cmd.CommandText = "TODO";
            cmd.Parameters.Add(new OracleParameter("viza", OracleDbType.Date) { Value = viza });
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

    ///// <summary>
    ///// Получить курсы дилера
    ///// </summary>
    ///// <returns>Данные таблицы DILER_KURS на дату</returns>
    //[WebMethod(EnableSession = true)]
    //[SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    //public Response<List<DealerCourseInfo>> GetDealerCourse(string currentDate)
    //{
    //    OracleConnection con = OraConnector.Handler.UserConnection;
    //    try
    //    {
    //        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
    //        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
    //        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
    //        if (isAuthenticated) LoginUser(barsUserName);

    //        var date = DateTime.ParseExact(currentDate, "ddMMyyyy", CultureInfo.InvariantCulture);

    //        OracleCommand cmd = con.CreateCommand();
    //        cmd.CommandText = "select * from DILER_KURS where TRUNC(DAT) = :dat";
    //        cmd.Parameters.Add(new OracleParameter("currentDate", OracleDbType.Date) { Value = date });
    //        var reader = cmd.ExecuteReader();
    //        var dealerCourses = new List<DealerCourseInfo>();
    //        while (reader.Read())
    //        {
    //            var dat = reader["DAT"] as DateTime?;
    //            var kv = reader["KV"] as decimal?;
    //            var id = reader["ID"] as decimal?;
    //            var kursb = reader["KURS_B"] as decimal?;
    //            var kurss = reader["KURS_S"] as decimal?;
    //            var vipb = reader["VIP_B"] as decimal?;
    //            var vips = reader["VIP_S"] as decimal?;
    //            var blk = reader["BLK"] as decimal?;
    //            var code = reader["CODE"] as decimal?;

    //            dealerCourses.Add(new DealerCourseInfo
    //            {
    //                DAT = dat,
    //                KV = kv,
    //                ID = id,
    //                KURS_B = kursb,
    //                KURS_S = kurss,
    //                VIP_B = vipb,
    //                VIP_S = vips,
    //                BLK = blk,
    //                CODE = code
    //            });
    //        }
    //        return new Response<List<DealerCourseInfo>>
    //        {
    //            Status = "ok", ErrorMessage = "", Data = dealerCourses
    //        };
    //    }
    //    catch (Exception e)
    //    {
    //        return new Response<List<DealerCourseInfo>>
    //        {
    //            Status = "error", ErrorMessage = e.Message + (e.InnerException == null? "" : ". " + e.InnerException.Message), Data = null
    //        };
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }
    //}

    ///// <summary>
    ///// Получить курсы конверсии дилера
    ///// </summary>
    ///// <returns>Данные таблицы DILER_KURS на дату</returns>
    //[WebMethod(EnableSession = true)]
    //[SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    //public Response<List<DealerCourseConvInfo>> GetDealerCourseConv(string currentDate)
    //{
    //    OracleConnection con = OraConnector.Handler.UserConnection;
    //    try
    //    {
    //        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
    //        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
    //        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
    //        if (isAuthenticated) LoginUser(barsUserName);

    //        var date = DateTime.ParseExact(currentDate, "ddMMyyyy", CultureInfo.InvariantCulture);

    //        OracleCommand cmd = con.CreateCommand();
    //        cmd.CommandText = "select * from DILER_KURS_CONV where TRUNC(DAT) = :dat";
    //        cmd.Parameters.Add(new OracleParameter("currentDate", OracleDbType.Date) { Value = date });
    //        var reader = cmd.ExecuteReader();
    //        var dealerCourses = new List<DealerCourseConvInfo>();
    //        while (reader.Read())
    //        {

    //            var kv1 = reader["KV1"] as decimal?;
    //            var kv2 = reader["KV2"] as decimal?;
    //            var dat = reader["DAT"] as DateTime?;
    //            var kursi = reader["KURS_I"] as decimal?;
    //            var kursf = reader["KURS_F"] as decimal?;

    //            dealerCourses.Add(new DealerCourseConvInfo
    //            {
    //                KV1 = kv1,
    //                KV2 = kv2,
    //                DAT = dat,
    //                KURS_I = kursi,
    //                KURS_F = kursf
    //            });
    //        }
    //        return new Response<List<DealerCourseConvInfo>>
    //        {
    //            Status = "ok",
    //            ErrorMessage = "",
    //            Data = dealerCourses
    //        };
    //    }
    //    catch (Exception e)
    //    {
    //        return new Response<List<DealerCourseConvInfo>>
    //        {
    //            Status = "error",
    //            ErrorMessage = e.Message + (e.InnerException == null ? "" : ". " + e.InnerException.Message),
    //            Data = null
    //        };
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }
    //}

    ///// <summary>
    ///// Получить курсы дилера фактические
    ///// </summary>
    ///// <returns>Данные таблицы DILER_KURS_FACT на дату</returns>
    //[WebMethod(EnableSession = true)]
    //[SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    //public Response<List<DealerCourseFactInfo>> GetDealerCourseFact(string currentDate)
    //{
    //    OracleConnection con = OraConnector.Handler.UserConnection;
    //    try
    //    {
    //        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
    //        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
    //        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
    //        if (isAuthenticated) LoginUser(barsUserName);

    //        var date = DateTime.ParseExact(currentDate, "ddMMyyyy", CultureInfo.InvariantCulture);

    //        OracleCommand cmd = con.CreateCommand();
    //        cmd.CommandText = "select * from DILER_KURS_FACT where TRUNC(DAT) = :dat";
    //        cmd.Parameters.Add(new OracleParameter("dat", OracleDbType.Date) { Value = date });
    //        var reader = cmd.ExecuteReader();
    //        var dealerCourses = new List<DealerCourseFactInfo>();
    //        while (reader.Read())
    //        {
    //            var dat = reader["DAT"] as DateTime?;
    //            var kv = reader["KV"] as decimal?;
    //            var id = reader["ID"] as decimal?;
    //            var kursb = reader["KURS_B"] as decimal?;
    //            var kurss = reader["KURS_S"] as decimal?;
    //            var code = reader["CODE"] as decimal?;

    //            dealerCourses.Add(new DealerCourseFactInfo
    //            {
    //                DAT = dat,
    //                KV = kv,
    //                ID = id,
    //                KURS_B = kursb,
    //                KURS_S = kurss,
    //                CODE = code
    //            });
    //        }
    //        return new Response<List<DealerCourseFactInfo>>
    //            {
    //                Status = "ok",
    //                ErrorMessage = "",
    //                Data = dealerCourses
    //            };
    //    }
    //    catch (Exception e)
    //    {
    //        return new Response<List<DealerCourseFactInfo>>
    //        {
    //            Status = "error",
    //            ErrorMessage = e.Message + (e.InnerException == null ? "" : ". " + e.InnerException.Message),
    //            Data = null
    //        };
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }
    //}

    #endregion

    #region вспомогательные классы
    public class Response<T>
    {
        public string Status { get; set; }
        public string ErrorMessage { get; set; }
        public T Data { get; set; }
    }

    #endregion
}
