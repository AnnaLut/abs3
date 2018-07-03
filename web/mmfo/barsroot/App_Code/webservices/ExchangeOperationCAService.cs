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
public class ExchangeOperationCAService : BarsWebService
{
    public WsHeader WsHeaderValue;

    #region private методы
    private void LoginUser(String userName)
    {
        // Інформація про поточного користувача
        UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

        using(OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
        using(OracleCommand cmd = con.CreateCommand())
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
        string operid_nokk, decimal? req_type, string vdate_plan, decimal? custtype)
    {
        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
        if (isAuthenticated) LoginUser(barsUserName);

        InitOraConnection();
        try

        {
            ClearParameters();

            SetParameters("p_flag", DB_TYPE.Decimal, flag, DIRECTION.Input);
            SetParameters("p_mfo", DB_TYPE.Varchar2,mfo, DIRECTION.Input);
            SetParameters("p_id", DB_TYPE.Decimal,id, DIRECTION.Input);
            SetParameters("p_dk", DB_TYPE.Decimal,dk, DIRECTION.Input);
            SetParameters("p_obz", DB_TYPE.Decimal,obz, DIRECTION.Input);
            SetParameters("p_nd", DB_TYPE.Varchar2,nd, DIRECTION.Input);
            SetParameters("p_fdat", DB_TYPE.Date,ParseDateFromString(fdat, "dd.MM.yyyy"), DIRECTION.Input);
            SetParameters("p_datt", DB_TYPE.Date,ParseDateFromString(datt, "dd.MM.yyyy"), DIRECTION.Input);
            SetParameters("p_rnk", DB_TYPE.Varchar2, rnk, DIRECTION.Input);
            SetParameters("p_nmk", DB_TYPE.Varchar2,nmk, DIRECTION.Input);
            SetParameters("p_nd_rnk", DB_TYPE.Varchar2, nd_rnk, DIRECTION.Input);
            SetParameters("p_kv_conv", DB_TYPE.Decimal,kv_conv, DIRECTION.Input);
            SetParameters("p_lcv_conv", DB_TYPE.Varchar2,lcv_conv, DIRECTION.Input);
            SetParameters("p_kv2", DB_TYPE.Decimal,kv2, DIRECTION.Input);
            SetParameters("p_lcv", DB_TYPE.Varchar2, lcv, DIRECTION.Input);
            SetParameters("p_dig", DB_TYPE.Decimal,dig, DIRECTION.Input);
            SetParameters("p_s2", DB_TYPE.Decimal,s2, DIRECTION.Input);
            SetParameters("p_s2s", DB_TYPE.Decimal,s2s, DIRECTION.Input);
            SetParameters("p_s3", DB_TYPE.Decimal, s3, DIRECTION.Input);
            SetParameters("p_kom", DB_TYPE.Decimal, kom, DIRECTION.Input);
            SetParameters("p_skom", DB_TYPE.Decimal, skom, DIRECTION.Input);
            SetParameters("p_kurs_z", DB_TYPE.Decimal, kurs_z, DIRECTION.Input);
            SetParameters("p_kurs_f", DB_TYPE.Decimal, kurs_f, DIRECTION.Input);
            SetParameters("p_vdate", DB_TYPE.Date, ParseDateFromString(vdate, "dd.MM.yyyy"), DIRECTION.Input);
            SetParameters("p_datz", DB_TYPE.Date,ParseDateFromString(datz, "dd.MM.yyyy"), DIRECTION.Input);
            SetParameters("p_acc0", DB_TYPE.Decimal, acc0, DIRECTION.Input);
            SetParameters("p_nls_acc0", DB_TYPE.Varchar2,nls_acc0, DIRECTION.Input);
            SetParameters("p_mfo0", DB_TYPE.Varchar2,mfo0, DIRECTION.Input);
            SetParameters("p_nls0", DB_TYPE.Varchar2,nls0, DIRECTION.Input);
            SetParameters("p_okpo0", DB_TYPE.Varchar2, okpo0, DIRECTION.Input);
            SetParameters("p_ostc0", DB_TYPE.Decimal, ostc0, DIRECTION.Input);
            SetParameters("p_acc1", DB_TYPE.Decimal,acc1, DIRECTION.Input);
            SetParameters("p_ostc", DB_TYPE.Decimal,ostc, DIRECTION.Input);
            SetParameters("p_nls", DB_TYPE.Varchar2,nls, DIRECTION.Input);
            SetParameters("p_sos", DB_TYPE.Decimal,sos, DIRECTION.Input);
            SetParameters("p_ref", DB_TYPE.Decimal, @ref, DIRECTION.Input);
            SetParameters("p_viza", DB_TYPE.Decimal,viza, DIRECTION.Input);
            SetParameters("p_priority", DB_TYPE.Decimal,priority, DIRECTION.Input);
            SetParameters("p_priorname", DB_TYPE.Varchar2, priorname, DIRECTION.Input);
            SetParameters("p_priorverify", DB_TYPE.Decimal,priorverify, DIRECTION.Input);
            SetParameters("p_idback", DB_TYPE.Decimal, idback, DIRECTION.Input);
            SetParameters("p_fl_pf", DB_TYPE.Decimal,fl_pf, DIRECTION.Input);
            SetParameters("p_mfop", DB_TYPE.Varchar2, mfop, DIRECTION.Input);
            SetParameters("p_nlsp", DB_TYPE.Varchar2,nlsp, DIRECTION.Input);
            SetParameters("p_okpop", DB_TYPE.Varchar2, okpop, DIRECTION.Input);
            SetParameters("p_rnk_pf", DB_TYPE.Varchar2, rnk_pf, DIRECTION.Input);
            SetParameters("p_pid", DB_TYPE.Decimal, pid, DIRECTION.Input);
            SetParameters("p_contract", DB_TYPE.Varchar2, contract, DIRECTION.Input);
            SetParameters("p_dat2_vmd", DB_TYPE.Date, ParseDateFromString(dat2_vmd, "dd.MM.yyyy"), DIRECTION.Input);
            SetParameters("p_meta", DB_TYPE.Decimal, meta, DIRECTION.Input);
            SetParameters("p_aim_name", DB_TYPE.Varchar2,aim_name, DIRECTION.Input);
            SetParameters("p_basis", DB_TYPE.Varchar2,basis, DIRECTION.Input);
            SetParameters("p_product_group", DB_TYPE.Varchar2, product_group, DIRECTION.Input);
            SetParameters("p_product_group_name", DB_TYPE.Varchar2, product_group_name, DIRECTION.Input);
            SetParameters("p_num_vmd", DB_TYPE.Varchar2, num_vmd, DIRECTION.Input);
            SetParameters("p_dat_vmd", DB_TYPE.Date, ParseDateFromString(dat_vmd, "dd.MM.yyyy"), DIRECTION.Input);
            SetParameters("p_dat5_vmd", DB_TYPE.Varchar2, dat5_vmd, DIRECTION.Input);
            SetParameters("p_country", DB_TYPE.Decimal, country, DIRECTION.Input);
            SetParameters("p_benefcountry", DB_TYPE.Decimal, benefcountry, DIRECTION.Input);
            SetParameters("p_bank_code", DB_TYPE.Varchar2, bank_code, DIRECTION.Input);
            SetParameters("p_bank_name", DB_TYPE.Varchar2, bank_name, DIRECTION.Input);
            SetParameters("p_userid", DB_TYPE.Decimal, userid, DIRECTION.Input);
            SetParameters("p_branch", DB_TYPE.Varchar2,branch, DIRECTION.Input);
            SetParameters("p_fl_kursz", DB_TYPE.Decimal, fl_kursz, DIRECTION.Input);
            SetParameters("p_identkb", DB_TYPE.Varchar2,identkb, DIRECTION.Input);
            SetParameters("p_comm", DB_TYPE.Varchar2, comm, DIRECTION.Input);
            SetParameters("p_cust_branch", DB_TYPE.Varchar2, cust_branch, DIRECTION.Input);
            SetParameters("p_kurs_kl", DB_TYPE.Varchar2, kurs_kl, DIRECTION.Input);
            SetParameters("p_contact_fio", DB_TYPE.Varchar2, contact_fio, DIRECTION.Input);
            SetParameters("p_contact_tel", DB_TYPE.Varchar2,contact_tel, DIRECTION.Input);
            SetParameters("p_verify_opt", DB_TYPE.Decimal, verify_opt, DIRECTION.Input);
            SetParameters("p_close_type", DB_TYPE.Decimal, close_type, DIRECTION.Input);
            SetParameters("p_close_type_name", DB_TYPE.Varchar2,close_type_name, DIRECTION.Input);
            SetParameters("p_aims_code", DB_TYPE.Decimal,aims_code, DIRECTION.Input);
            SetParameters("p_s_pf", DB_TYPE.Decimal, s_pf, DIRECTION.Input);
            SetParameters("p_ref_pf", DB_TYPE.Decimal, ref_pf, DIRECTION.Input);
            SetParameters("p_ref_sps", DB_TYPE.Decimal, ref_sps, DIRECTION.Input);
            SetParameters("p_start_time", DB_TYPE.Date, ParseDateFromString(start_time, "dd.MM.yyyy H:mm:ss"), DIRECTION.Input);
            SetParameters("p_state", DB_TYPE.Varchar2, state, DIRECTION.Input);
            SetParameters("p_operid_nokk", DB_TYPE.Varchar2,operid_nokk, DIRECTION.Input);
            SetParameters("p_req_type", DB_TYPE.Decimal, req_type, DIRECTION.Input);
            SetParameters("p_vdateplan", DB_TYPE.Date, ParseDateFromString(vdate_plan, "dd.MM.yyyy"), DIRECTION.Input);
            SetParameters("p_custtype", DB_TYPE.Decimal, custtype, DIRECTION.Input);

            SQL_NONQUERY(@"begin
                        bc.go(300465);
                bars_zay.set_request_in_ca(:p_flag, 
				                           :p_mfo, 
										   :p_id, 
										   :p_dk, 
										   :p_obz, 
										   :p_nd, 
										   :p_fdat, 
										   :p_datt, 
										   :p_rnk,
										   :p_nmk,
										   :p_nd_rnk,
										   :p_kv_conv,
										   :p_lcv_conv,
										   :p_kv2,
										   :p_lcv,
										   :p_dig,
										   :p_s2,
										   :p_s2s,
										   :p_s3,
										   :p_kom,
										   :p_skom,
										   :p_kurs_z,
										   :p_kurs_f,
										   :p_vdate,
										   :p_datz,
										   :p_acc0,
										   :p_nls_acc0,
										   :p_mfo0,
										   :p_nls0,
										   :p_okpo0,
										   :p_ostc0,
										   :p_acc1,
										   :p_ostc,
										   :p_nls,
										   :p_sos,
										   :p_ref,
										   :p_viza,
										   :p_priority,
										   :p_priorname,
										   :p_priorverify,
										   :p_idback,
										   :p_fl_pf,
										   :p_mfop,
										   :p_nlsp,
										   :p_okpop,
										   :p_rnk_pf,
										   :p_pid,
										   :p_contract,
										   :p_dat2_vmd,
										   :p_meta,
										   :p_aim_name,
										   :p_basis,
										   :p_product_group,
										   :p_product_group_name,
										   :p_num_vmd,
										   :p_dat_vmd,
										   :p_dat5_vmd,
										   :p_country,
										   :p_benefcountry,
										   :p_bank_code,
										   :p_bank_name,
										   :p_userid,
										   :p_branch,
										   :p_fl_kursz,
										   :p_identkb,
										   :p_comm,
										   :p_cust_branch,
										   :p_kurs_kl,
										   :p_contact_fio,
										   :p_contact_tel,
										   :p_verify_opt,
										   :p_close_type,
										   :p_close_type_name,
										   :p_aims_code,
										   :p_s_pf,
										   :p_ref_pf,
										   :p_ref_sps,
										   :p_start_time,
										   :p_state,
										   :p_operid_nokk,
										   :p_req_type,
										   :p_vdateplan,
										   :p_custtype);
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
            DisposeOraConnection();
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

        InitOraConnection();
        try
        {

            ClearParameters();
            SetParameters("mfo", DB_TYPE.Varchar2,mfo, DIRECTION.Input);
            SetParameters("track_id", DB_TYPE.Decimal,track_id, DIRECTION.Input);
            SetParameters("req_id", DB_TYPE.Decimal,req_id, DIRECTION.Input);
            SetParameters("change_time", DB_TYPE.Date,ParseDateFromString(change_time, "dd.MM.yyyy H:mm:ss"), DIRECTION.Input);
            SetParameters("fio", DB_TYPE.Varchar2,fio, DIRECTION.Input);
            SetParameters("sos", DB_TYPE.Decimal,sos, DIRECTION.Input);
            SetParameters("viza", DB_TYPE.Decimal,viza, DIRECTION.Input);
            SetParameters("viza_name", DB_TYPE.Varchar2,viza_name, DIRECTION.Input);

            SQL_NONQUERY(@"begin
                            bc.go(300465);
                            BARS_ZAY.SET_ZAYTRACK_IN_CA(:mfo, :track_id, :req_id, :change_time, :fio, :sos, :viza, :viza_name);
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
            DisposeOraConnection();
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

        using (OracleConnection con = OraConnector.Handler.UserConnection)
        using (OracleCommand cmd = con.CreateCommand())
        {
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "TODO";
                cmd.Parameters.Add(new OracleParameter("viza", OracleDbType.Date) {Value = viza});
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

            SetParameters("p_mfo", DB_TYPE.Varchar2,mfo , DIRECTION.Input);
            SetParameters("p_id", DB_TYPE.Decimal,req_id, DIRECTION.Input);
            SetParameters("p_ref_sps", DB_TYPE.Decimal,ref_sps, DIRECTION.Input);

            SQL_NONQUERY(@"begin
                    bc.go(300465);
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
            DisposeOraConnection();
        }
    }

    /// <summary>
    /// Передача валюты ZAY_CURRENCY_INCOME. РУ-ЦА. 
    /// </summary>
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Response<string> SetCurrency(string currentMfo, string currentDate, string xmlCurrencyIncome)
    {
        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
        if (isAuthenticated) LoginUser(barsUserName);

        InitOraConnection();
        try
        {
            ClearParameters();
            //cmd.CommandText = "BARS_ZAY.IPARSE_CURRENCY_INCOME";
            SetParameters("p_mfo", DB_TYPE.Varchar2, currentMfo, DIRECTION.Input);
            SetParameters("p_date", DB_TYPE.Varchar2, currentDate, DIRECTION.Input);  //OracleDbType.Date) { Value = ParseDateFromString(p_date, "dd.MM.yyyy H:mm:ss") });
            SetParameters("p_currency_clob", DB_TYPE.Clob, xmlCurrencyIncome, DIRECTION.Input);
            SQL_NONQUERY(@"begin
                    bc.go(300465);
                    bars_zay.iparse_currency_income(:p_mfo, :p_date, :p_currency_clob);
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
            DisposeOraConnection();
        }
    }

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
