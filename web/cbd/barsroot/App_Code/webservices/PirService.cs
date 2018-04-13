using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Net;
using System.Linq;
using System.ServiceModel;

using System.Security.Cryptography.X509Certificates;
using System.Net.Security;

using Bars.Application;
using Bars.WebServices;
using Bars.Classes;
using Bars.Oracle;
using Bars.Exception;
using barsroot.core;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

using ibank.objlayer;
using ibank.core;
using ibank.core.Exceptions;
using Bars.Logger;

namespace Bars.PirWebServices
{
    public class PirRequestHelpers
    {
        public static string GetClientIpAddress(HttpRequest request)
        {
            try
            {
                string szRemoteAddr = request.ServerVariables["REMOTE_ADDR"];
                string szXForwardedFor = request.ServerVariables["X_FORWARDED_FOR"];
                string szIP = "";

                if (szXForwardedFor == null && szRemoteAddr != "::1")
                {
                    szIP = szRemoteAddr;
                }
                else
                {
                    szIP = szXForwardedFor;
                    if (szIP.IndexOf(",") > 0)
                    {
                        string[] arIPs = szIP.Split(',');

                        foreach (string item in arIPs)
                        {
                            if (!IsPrivateIpAddress(item))
                            {
                                return item;
                            }
                        }
                    }
                }
                return szIP;
            }
            catch (System.Exception)
            {
                // Always return all zeroes for any failure (my calling code expects it)
                return "0.0.0.0";
            }
        }

        private static bool IsPrivateIpAddress(string ipAddress)
        {
            // http://en.wikipedia.org/wiki/Private_network
            // Private IP Addresses are: 
            //  24-bit block: 10.0.0.0 through 10.255.255.255
            //  20-bit block: 172.16.0.0 through 172.31.255.255
            //  16-bit block: 192.168.0.0 through 192.168.255.255
            //  Link-local addresses: 169.254.0.0 through 169.254.255.255 (http://en.wikipedia.org/wiki/Link-local_address)

            var ip = IPAddress.Parse(ipAddress);
            var octets = ip.GetAddressBytes();

            var is24BitBlock = octets[0] == 10;
            if (is24BitBlock) return true; // Return to prevent further processing

            var is20BitBlock = octets[0] == 172 && octets[1] >= 16 && octets[1] <= 31;
            if (is20BitBlock) return true; // Return to prevent further processing

            var is16BitBlock = octets[0] == 192 && octets[1] == 168;
            if (is16BitBlock) return true; // Return to prevent further processing

            var is0BitBlock = octets[0] == 129 && octets[1] == 0;
            if (is0BitBlock) return true; // Return to prevent further processing

            var isLinkLocalAddress = octets[0] == 169 && octets[1] == 254;
            return isLinkLocalAddress;
        }
    }

    /// <summary>
    /// Варианты исхода обращения к веб-сервису :)
    /// </summary>
    public enum PirResultKinds { Success, Error }

    /// <summary>
    /// Класс сообщения об ошибке
    /// </summary>
    public class PirErrorMessage
    {
        /// <summary>
        /// Код ошибки
        /// </summary>
        public string Code { get; set; }
        /// <summary>
        /// Текст ошибки
        /// </summary>
        public string Message { get; set; }
    }

    /// <summary>
    /// Базовый класс результата запроса
    /// </summary>
    public class PirRequestResult
    {
        public PirRequestResult()
        {
            Errors = new List<PirErrorMessage>();
            Kind = PirResultKinds.Success;
        }
        /// <summary>
        /// Тип результата - успех или ошибка
        /// </summary>
        public PirResultKinds Kind { get; set; }
        /// <summary>
        /// Список ошибок
        /// </summary>
        public List<PirErrorMessage> Errors { get; set; }
    }

    /// <summary>
    /// Результат запроса Информации о клиенте
    /// </summary>
    public class PirCustData
    {
        public decimal Rnk { get; set; }
        public string Nmk { get; set; }
        public string Okpo { get; set; }
        public string Adr { get; set; }
        public string Bday { get; set; }
        public string Passp { get; set; }
        public string Ser { get; set; }
        public string NumDoc { get; set; }
        public string DocName { get; set; }
    }

    /// <summary>
    /// Результат запроса Информации о продуктах по клиенту(в разрезе заявки)
    /// </summary>
    public class PirReqData
    {
        public decimal req_id { get; set; }
        public string deal_type { get; set; }
        public string deal_type_name { get; set; }
        public decimal deal_id { get; set; }
        public string deal_num { get; set; }
        public string sdate { get; set; }
        public string comm { get; set; }
        public decimal summ { get; set; }
        public decimal summproc { get; set; }
        public decimal kv { get; set; }
        public decimal approved { get; set; }
        public string reff { get; set; }
    }

    /// <summary>
    /// Результат запроса истории заявки
    /// </summary>
    public class PirReqHistoryData
    {
        public string state_id { get; set; }
        public string state_name { get; set; }
        public string set_date { get; set; }
        public string upd_staff { get; set; }
        public string comm { get; set; }
    }

    /// <summary>
    // история прохождения заявки
    /// </summary>
    public class PirResponseReqHistory : PirRequestResult
    {
        public List<PirReqHistoryData> PirReqHistoryData { get; set; }
    }
    /// <summary>
    /// Результат запроса Информации о клиенте
    /// </summary>
    public class PirRequestCustData : PirRequestResult
    {
        public List<PirCustData> PirCustData { get; set; }
    }
    // продукты клиента из функции
    public class ResponseReqData : PirRequestResult
    {
        public List<PirReqData> PirReqData { get; set; }
    }

    // ид и статус заявки по клиенту
    public class PirResponseReqInfo : PirRequestResult
    {
        public decimal ReqId { get; set; }
        public string ReqCreateDate { get; set; }
        public string ReqStatus { get; set; }
        public string ReqStatusName { get; set; }
        public string ReqCreateMfo { get; set; }
        public string ReqCreateMfoName { get; set; }
        public string ReqCreateBranch { get; set; }
        public string ReqCreateUserName { get; set; }
    }

    // создание заявки
    public class ResponseCreateReq : PirRequestResult
    {
        public decimal NewDiReq { get; set; }
    }

    public class ActivateCardException : System.Exception
    {
        public ActivateCardException(String Code, String Message) : base(Code.ToString() + ": " + Message) { }

    }

    /// <summary>
    /// Веб-сервис для взаимодействия с внешними системами 
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class PirService : BarsWebService
    {
        public WsHeader WsHeaderValue;

        #region //////////////// private methods /////////////////

        private void LoginUserInt(String userName)
        {
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            try
            {
                InitOraConnection();
                // установка первичных параметров
                ClearParameters();
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);
                SetParameters("p_hostname", DB_TYPE.Varchar2, PirRequestHelpers.GetClientIpAddress(HttpContext.Current.Request), DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");

                ClearParameters();
                SetParameters("p_info", DB_TYPE.Varchar2,
                    String.Format("PirCustInfo: авторизация. Хост {0}, пользователь {1}", PirRequestHelpers.GetClientIpAddress(HttpContext.Current.Request), userName),
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

        private PirRequestResult LoginUser()
        {
            PirRequestResult res = new PirRequestResult();

            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "absadm";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "qwerty";

            // авторизация пользователя по хедеру
            try
            {
                Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
                if (isAuthenticated)
                {
                    LoginUserInt(userName);
                    res.Kind = PirResultKinds.Success;
                }
                else
                {
                    res.Kind = PirResultKinds.Error;
                    res.Errors.Add(new PirErrorMessage() { Code = "ERR_AUTH_UNKNOWN", Message = "Невідома помилка авторизації, звернітся до адміністратора" });
                }
            }
            catch (System.Exception e)
            {
                res.Kind = PirResultKinds.Error;
                res.Errors.Add(new PirErrorMessage() { Code = "ERR_AUTH_UNAMEPASSW", Message = String.Format("Помилка авторизації: {0}", e.Message) });
            }

            return res;
        }

        private bool tryLogin(PirRequestResult res)
        {
            PirRequestResult authRes = LoginUser();
            if (authRes.Kind == PirResultKinds.Error)
            {
                res.Kind = authRes.Kind;
                res.Errors.AddRange(authRes.Errors);
                return false;
            }
            return true;
        }



        // Информация о клиенте
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        public PirRequestCustData GetCustInfo(String p_cust_rnk, String p_cust_code, String p_cust_fio, String p_cust_birthday, String p_cust_doc_type, String p_cust_doc_serial, String p_cust_doc_number)
        {
            PirRequestCustData res = new PirRequestCustData();
            res.PirCustData = new List<PirCustData>();

            if (!tryLogin(res)) return res;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = @"select c.rnk,
                            c.nmk,
                            c.okpo,
                            c.adr,
                            to_char(p.bday,'dd.mm.yyyy') bday,
                            pp.name||' '|| p.ser||' '|| p.numdoc passp,
                            p.ser,
                            p.numdoc,
                            pp.name doc_name
                          from customer c,
                            person p,
                            passp pp 
                          where c.rnk = p.rnk
                            and p.passp = pp.passp
                            and c.date_off is null
                            and c.custtype = 3
                            and nvl(trim(c.sed), '00') != '91'";

                if (!String.IsNullOrEmpty(p_cust_rnk))
                {
                    cmd.Parameters.Add("p_cust_rnk", OracleDbType.Decimal, 38, p_cust_rnk, ParameterDirection.Input);
                    cmd.CommandText += " and c.rnk = :p_cust_rnk";
                }
                else if (!String.IsNullOrEmpty(p_cust_code))
                {
                    cmd.Parameters.Add("p_cust_code", OracleDbType.Varchar2, 14, p_cust_code, ParameterDirection.Input);
                    cmd.CommandText += " and c.okpo =  :p_cust_code";
                }
                else if (!String.IsNullOrEmpty(p_cust_fio) && !String.IsNullOrEmpty(p_cust_birthday))
                {
                    cmd.Parameters.Add("p_cust_fio", OracleDbType.Varchar2, 100, p_cust_fio, ParameterDirection.Input);
                    cmd.Parameters.Add("p_cust_birthday", OracleDbType.Varchar2, 20, p_cust_birthday, ParameterDirection.Input);
                    cmd.CommandText += " and upper(c.nmk) = upper(:p_cust_fio) and to_char(p.bday,'dd.mm.yyyy') = substr(:p_cust_birthday,1,10)";
                }
                else if (!String.IsNullOrEmpty(p_cust_doc_type) && !String.IsNullOrEmpty(p_cust_doc_serial) && !String.IsNullOrEmpty(p_cust_doc_number))
                {
                    cmd.Parameters.Add("p_cust_doc_type", OracleDbType.Varchar2, 3, p_cust_doc_type, ParameterDirection.Input);
                    cmd.Parameters.Add("p_cust_doc_serial", OracleDbType.Varchar2, 4, p_cust_doc_serial, ParameterDirection.Input);
                    cmd.Parameters.Add("p_cust_doc_number", OracleDbType.Varchar2, 10, p_cust_doc_number, ParameterDirection.Input);

                    cmd.CommandText += " and p.passp = to_number(:p_cust_doc_type) and p.ser = :p_cust_doc_serial and p.numdoc = :p_cust_doc_number";
                }
                else
                {
                    cmd.CommandText += " and 1=2";
                    res.Kind = PirResultKinds.Error;
                    res.Errors.Add(new PirErrorMessage() { Code = "ERR_CUSTINFONODATAFOUND", Message = "Вказаних параметрів пошуку недостатньо" });
                }
                cmd.BindByName = true;

                OracleDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    var cust = new PirCustData();
                    cust.Rnk = Convert.ToDecimal(rdr["rnk"]);
                    cust.Nmk = rdr["nmk"].ToString();
                    cust.Okpo = rdr["okpo"].ToString();
                    cust.Adr = rdr["adr"].ToString();
                    cust.Bday = rdr["bday"].ToString();
                    //  cust.Passp = rdr["passp"].ToString();
                    cust.Passp = rdr["doc_name"].ToString() + " " + rdr["ser"].ToString() + " " + rdr["numdoc"].ToString();
                    cust.Ser = rdr["ser"].ToString();
                    cust.NumDoc = rdr["numdoc"].ToString();
                    cust.DocName = rdr["doc_name"].ToString();

                    res.PirCustData.Add(cust);
                }

                res.Kind = PirResultKinds.Success;
            }
            catch (System.Exception e)
            {
                // res.ReturnRnk = 0;
                //res.ReturnNmk = e.Message;
                res.Kind = PirResultKinds.Error;
                // res.Errors.Add(new ErrorMessage() { Code = "ERR_CUSTINFOSERVICE", Message = e.Message });
                res.Errors.Add(new PirErrorMessage() { Code = "ERR_CUSTINFO", Message = e.Message });

            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }

            return res;
        }

        //Ищем заявку
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        public PirResponseReqInfo GetReqId(Decimal? p_cust_rnk, Decimal? p_rnk_ext)
        {
            decimal p_id = 0;
            decimal p_count = 0;

            PirResponseReqInfo res = new PirResponseReqInfo();
            res.ReqId = 0;

            if (!tryLogin(res)) return res;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("p_cust_rnk", OracleDbType.Decimal, 38, p_cust_rnk, ParameterDirection.Input);
                cmd.BindByName = true;
                cmd.CommandText = "select nvl(pir_request.get_reqid_rnk(:p_cust_rnk),0) Reqid from dual";

                OracleDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {

                    res.ReqId = Convert.ToDecimal(rdr["Reqid"]);
                    p_id = Convert.ToDecimal(rdr["Reqid"]);
                }

                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_id", OracleDbType.Decimal, 38, p_id, ParameterDirection.Input);
                cmd.CommandText = @"select r.state_id,
                                      to_char(r.crt_date,'dd.mm.yyyy hh24:mi:ss') create_date,
                                      r.crt_staff,
                                      r.mfo_name||' ( МФО '||r.mfo||')' mfo,
                                      r.branch_name||' ('||r.branch||')' branch,
                                      s.name 
                                    from pir_requests r, 
                                    pir_req_states s
                                    where r.state_id = s.id
                                    and r.id = :p_id";
                OracleDataReader newrdr = cmd.ExecuteReader();

                while (newrdr.Read())
                {
                    res.ReqStatus = newrdr["state_id"].ToString();
                    res.ReqStatusName = newrdr["name"].ToString();
                    res.ReqCreateDate = newrdr["create_date"].ToString();
                    res.ReqCreateMfo = newrdr["mfo"].ToString();
                    res.ReqCreateUserName = newrdr["crt_staff"].ToString();
                    res.ReqCreateBranch = newrdr["branch"].ToString();

                }

                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_rnk_ext", OracleDbType.Decimal, 38, p_rnk_ext, ParameterDirection.Input);
                cmd.Parameters.Add("p_Req_id", OracleDbType.Decimal, 38, res.ReqId, ParameterDirection.Input);
                cmd.CommandText = "select count(cd.req_id) count_req from pir_req_clients_data cd where cd.req_id = :p_Req_id and rnk_ext = :p_rnk_ext ";
                OracleDataReader extrdr = cmd.ExecuteReader();

                while (extrdr.Read())
                {
                    p_count = Convert.ToDecimal(extrdr["count_req"]);
                }

                if (res.ReqId != 0 && p_count == 0)
                {
                    res.Kind = PirResultKinds.Error;
                    res.Errors.Add(new PirErrorMessage() { Code = "ERR_GETReqID", Message = "Заявка №" + res.ReqId + " створена для виплати клієнту, РНК якого відрізняється від " + p_rnk_ext });
                }
                else
                {
                    res.Kind = PirResultKinds.Success;
                }
            }
            catch (System.Exception e)
            {
                // res.ReturnRnk = 0;
                //res.ReturnNmk = e.Message;
                res.Kind = PirResultKinds.Error;
                // res.Errors.Add(new ErrorMessage() { Code = "ERR_CUSTINFOSERVICE", Message = e.Message });
                res.Errors.Add(new PirErrorMessage() { Code = "ERR_GETReqID", Message = e.Message });

            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return res;
        }

        //Создаём заявку
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        public ResponseCreateReq CreateReq(String p_crt_staff, String p_mfo, String p_crt_mfo_name,
                                           String p_branch, String p_crt_branch_name, Decimal p_rnk, Decimal p_rnkext,
                                           String p_fio_ext, String p_bdate_ext, Decimal p_doctype_ext,
                                           String p_docser_ext, String p_docnum_ext, String p_inn_ext)
        {
            ResponseCreateReq res = new ResponseCreateReq();
            res.NewDiReq = 0;

            if (!tryLogin(res)) return res;

            decimal? p_new_id = 0;

            OracleDecimal new_id = 0;

            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            OracleConnection oraCon = conn.GetUserConnection(HttpContext.Current);
            try
            {
                try
                {
                    OracleCommand comm = oraCon.CreateCommand();
                    comm.CommandType = System.Data.CommandType.Text;
                    comm.Parameters.Clear();

                    comm.Parameters.Add(new OracleParameter("p_crt_staff", OracleDbType.Varchar2, 128, p_crt_staff, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_mfo", OracleDbType.Varchar2, 20, p_mfo, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_crt_mfo_name", OracleDbType.Varchar2, 20, p_crt_mfo_name, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_branch", OracleDbType.Varchar2, 128, p_branch, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_crt_branch_name", OracleDbType.Varchar2, 128, p_crt_branch_name, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_rnk", OracleDbType.Decimal, p_rnk, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_rnkext", OracleDbType.Decimal, p_rnkext, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_fio_ext", OracleDbType.Varchar2, 100, p_fio_ext, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_bdate_ext", OracleDbType.Varchar2, 128, p_bdate_ext, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_doctype_ext", OracleDbType.Decimal, p_doctype_ext, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_docser_ext", OracleDbType.Varchar2, 7, p_docser_ext, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_docnum_ext", OracleDbType.Varchar2, 20, p_docnum_ext, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_inn_ext", OracleDbType.Varchar2, 14, p_inn_ext, ParameterDirection.Input));
                    comm.Parameters.Add(new OracleParameter("p_new_id", OracleDbType.Decimal, new_id, ParameterDirection.Output));

                    comm.CommandText = @"begin
                                           Pir_request.create_req_with_client(:p_crt_staff,
                                                                              :p_mfo,
                                                                              :p_crt_mfo_name,
                                                                              :p_branch,
                                                                              :p_crt_branch_name,
                                                                              :p_rnk,
                                                                              :p_rnkext,
                                                                              :p_fio_ext,
                                                                              to_date(:p_bdate_ext,'dd.mm.yyyy'),
                                                                              :p_doctype_ext,
                                                                              :p_docser_ext,
                                                                              :p_docnum_ext,
                                                                              :p_inn_ext,
                                                                              :p_new_id); 
                                         end;";
                    comm.BindByName = true;

                    comm.ExecuteNonQuery();

                    new_id = (OracleDecimal)comm.Parameters["p_new_id"].Value;

                    res.Errors.Add(new PirErrorMessage() { Code = "create", Message = "create_req_with_client" });

                    if (new_id != 0)
                    {
                        //comm.Parameters.Add(new OracleParameter("p_new_id", OracleDbType.Decimal, p_new_id, ParameterDirection.Input));
                        //comm.BindByName = true;

                        comm.CommandText = "begin pir_request.build_deal_data(" + new_id + "); end;";
                        comm.ExecuteNonQuery();

                        res.Errors.Add(new PirErrorMessage() { Code = "create2", Message = "build_deal_data" });
                    }
                }
                finally
                {
                    oraCon.Close();
                    oraCon.Dispose();
                    oraCon = null;
                }

                p_new_id = new_id.IsNull ? 0 : new_id.Value;
                res.NewDiReq = Convert.ToDecimal(p_new_id);
                res.Kind = PirResultKinds.Success;

            }
            catch (System.Exception e)
            {
                res.Kind = PirResultKinds.Error;
                res.Errors.Add(new PirErrorMessage() { Code = "ERR_CREATEReq", Message = e.Message });
            }
            return res;
        }

        // Записываем счета на которые будем выплачивать средства
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        public PirRequestResult SetCustAcc(Decimal? p_Req_id, String p_kf, Decimal? p_rnkext, String p_nls2625, Decimal? p_kv, String p_branch)
        {
            PirRequestResult res = new PirRequestResult();

            if (!tryLogin(res)) return res;

            InitOraConnection();
            try
            {
                ClearParameters();
                SetParameters("p_Req_id", DB_TYPE.Decimal, p_Req_id, DIRECTION.Input);
                SetParameters("p_kf", DB_TYPE.Varchar2, p_kf, DIRECTION.Input);
                SetParameters("p_rnkext", DB_TYPE.Decimal, p_rnkext, DIRECTION.Input);
                SetParameters("p_nls2625", DB_TYPE.Varchar2, p_nls2625, DIRECTION.Input);
                SetParameters("p_kv", DB_TYPE.Decimal, p_kv, DIRECTION.Input);
                SetParameters("p_branch", DB_TYPE.Varchar2, p_branch, DIRECTION.Input);

                SQL_NONQUERY("begin pir_request.create_card_data(:p_Req_id,:p_kf,:p_rnkext,:p_nls2625,:p_kv,:p_branch); end;");

                res.Kind = PirResultKinds.Success;
            }
            catch (System.Exception e)
            {
                // res.ReturnRnk = 0;
                //res.ReturnNmk = e.Message;
                res.Kind = PirResultKinds.Error;
                // res.Errors.Add(new ErrorMessage() { Code = "ERR_CUSTINFOSERVICE", Message = e.Message });
                res.Errors.Add(new PirErrorMessage() { Code = "ERR_ADD_CUST_ACC", Message = e.Message });
            }

            finally
            {
                DisposeOraConnection();
            }
            return res;
        }

        //Получаем продукты по заявке
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        public ResponseReqData GetReqData(Decimal? p_Req_id, String type)
        {
            ResponseReqData res = new ResponseReqData();
            res.PirReqData = new List<PirReqData>();

            if (!tryLogin(res)) return res;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("p_Req_id", OracleDbType.Decimal, 38, p_Req_id, ParameterDirection.Input);
                cmd.BindByName = true;

                if (type == "1")
                {
                    cmd.CommandText = "select v.req_id, v.deal_type, v.deal_type_name, v.deal_id, v.deal_num,to_char(v.sdate,'dd.mm.yyyy') sdate,v.comm,v.summ,v.summproc,v.kv,v.approved,v.ref from v_pir_deals_data_doc v where v.req_id = :p_Req_id";
                }
                else
                {
                    cmd.CommandText = "select v.req_id, v.deal_type, v.deal_type_name, v.deal_id, v.deal_num,to_char(v.sdate,'dd.mm.yyyy') sdate, v.comm, v.summ, v.summproc, v.kv, v.approved, v.ref from v_pir_deals_data_doc v where v.req_id = :p_Req_id and approved = 1";
                }

                OracleDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    var Data = new PirReqData();
                    Data.req_id = Convert.ToDecimal(rdr["req_id"]);
                    Data.deal_type = rdr["deal_type"].ToString();
                    Data.deal_type_name = rdr["deal_type_name"].ToString();
                    Data.deal_id = Convert.ToDecimal(rdr["deal_id"]);
                    Data.deal_num = rdr["deal_num"].ToString();
                    Data.sdate = rdr["sdate"].ToString();
                    Data.comm = rdr["comm"].ToString();
                    Data.summ = Convert.ToDecimal(rdr["summ"]);
                    Data.summproc = Convert.ToDecimal(rdr["summproc"]);
                    Data.kv = Convert.ToDecimal(rdr["kv"]);
                    Data.approved = Convert.ToDecimal(rdr["approved"]);
                    Data.reff = rdr["ref"].ToString();

                    res.PirReqData.Add(Data);
                }
                res.Kind = PirResultKinds.Success;
            }
            catch (System.Exception e)
            {
                // res.ReturnRnk = 0;
                //res.ReturnNmk = e.Message;
                res.Kind = PirResultKinds.Error;
                // res.Errors.Add(new ErrorMessage() { Code = "ERR_CUSTINFOSERVICE", Message = e.Message });
                res.Errors.Add(new PirErrorMessage() { Code = "ERR_GETReqDATA", Message = e.Message });
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return res;
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        //Подтверждаем выбраные продукты
        public PirRequestResult SetReqApprove(Decimal? p_Req_id, String p_deal_type, Decimal? p_deal_id, String p_crt_staff)
        {
            PirRequestResult res = new PirRequestResult();

            if (!tryLogin(res)) return res;

            InitOraConnection();
            try
            {
                ClearParameters();
                SetParameters("p_Req_id", DB_TYPE.Decimal, p_Req_id, DIRECTION.Input);
                SetParameters("p_deal_type", DB_TYPE.Varchar2, p_deal_type, DIRECTION.Input);
                SetParameters("p_deal_id", DB_TYPE.Decimal, p_deal_id, DIRECTION.Input);

                SQL_NONQUERY("begin pir_request.approve_deal_data(:p_Req_id,:p_deal_type,:p_deal_id); end;");

                ClearParameters();
                SetParameters("p_Req_id", DB_TYPE.Decimal, p_Req_id, DIRECTION.Input);
                SetParameters("p_crt_staff", DB_TYPE.Varchar2, 128, p_crt_staff, DIRECTION.Input);

                // Встановлення статусу заявки
                SQL_NONQUERY("begin pir_request.set_req_state(:p_Req_id,'APPROVED',:p_crt_staff,'Підтвердження продуктів') ; end;");

                res.Kind = PirResultKinds.Success;
            }
            catch (System.Exception e)
            {
                // res.ReturnRnk = 0;
                //res.ReturnNmk = e.Message;
                res.Kind = PirResultKinds.Error;
                // res.Errors.Add(new ErrorMessage() { Code = "ERR_CUSTINFOSERVICE", Message = e.Message });
                res.Errors.Add(new PirErrorMessage() { Code = "ERR_APPROVEReq", Message = e.Message });
            }

            finally
            {
                DisposeOraConnection();
            }

            return res;
        }
        // Отменяем подтверждение выбраных продуктов
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        public PirRequestResult SetReqDeapprove(Decimal? p_Req_id, String p_user_upd)
        {
            PirRequestResult res = new PirRequestResult();

            if (!tryLogin(res)) return res;

            InitOraConnection();
            try
            {
                ClearParameters();

                SetParameters("p_Req_id", DB_TYPE.Decimal, p_Req_id, DIRECTION.Input);
                SetParameters("p_Req_id", DB_TYPE.Varchar2, p_user_upd, DIRECTION.Input);

                SQL_NONQUERY("begin pir_request.deapprove_deal_data(:p_Req_id,:p_user_upd); end;");

                res.Kind = PirResultKinds.Success;
            }
            catch (System.Exception e)
            {
                // res.ReturnRnk = 0;
                //res.ReturnNmk = e.Message;
                res.Kind = PirResultKinds.Error;
                // res.Errors.Add(new ErrorMessage() { Code = "ERR_CUSTINFOSERVICE", Message = e.Message });
                res.Errors.Add(new PirErrorMessage() { Code = "ERR_DEAPROVE_Req", Message = e.Message });
            }

            finally
            {
                DisposeOraConnection();
            }
            return res;
        }

        //подписываем заявку
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        public PirRequestResult SetEdsRu(Decimal? p_req_id, String p_user_upd, String p_buff)
        {
            PirRequestResult res = new PirRequestResult();

            if (!tryLogin(res)) return res;

            InitOraConnection();
            try
            {
                ClearParameters();

                SetParameters("p_Req_id", DB_TYPE.Decimal, p_req_id, DIRECTION.Input);
                SetParameters("p_user_upd", DB_TYPE.Varchar2, p_user_upd, DIRECTION.Input);
                SetParameters("p_buff", DB_TYPE.Varchar2, p_buff, DIRECTION.Input);

                SQL_NONQUERY("begin pir_request.set_eds_ru(:p_req_id,:p_user_upd,:p_buff); end;");

                res.Kind = PirResultKinds.Success;
            }
            catch (System.Exception e)
            {
                // res.ReturnRnk = 0;
                //res.ReturnNmk = e.Message;
                res.Kind = PirResultKinds.Error;
                // res.Errors.Add(new ErrorMessage() { Code = "ERR_CUSTINFOSERVICE", Message = e.Message });
                res.Errors.Add(new PirErrorMessage() { Code = "ERR_SETEDSRU", Message = e.Message });
            }

            finally
            {
                DisposeOraConnection();
            }
            return res;
        }

        //История статусов по заявке
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        public PirResponseReqHistory GetReqHistory(Decimal? req_id)
        {
            PirResponseReqHistory res = new PirResponseReqHistory();
            res.PirReqHistoryData = new List<PirReqHistoryData>();

            if (!tryLogin(res)) return res;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("req_id", OracleDbType.Decimal, 38, req_id, ParameterDirection.Input);
                cmd.BindByName = true;

                cmd.CommandText = @"select 
                                      r.state_id,
                                      s.name state_name,
                                      to_char(r.set_date,'dd.mm.yyyy hh24:mi:ss') set_date,
                                      r.upd_staff,
                                      r.comm
                                    from pir_req_states_history r,
                                      pir_req_states s 
                                    where r.req_id = :req_id
                                      and r.state_id = s.id
                                    order by r.id";

                OracleDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    var Data = new PirReqHistoryData();
                    Data.state_id = rdr["state_id"].ToString();
                    Data.state_name = rdr["state_name"].ToString();
                    Data.set_date = rdr["set_date"].ToString();
                    Data.upd_staff = rdr["upd_staff"].ToString();
                    Data.comm = rdr["comm"].ToString();

                    res.PirReqHistoryData.Add(Data);
                }
                res.Kind = PirResultKinds.Success;
            }
            catch (System.Exception e)
            {
                // res.ReturnRnk = 0;
                //res.ReturnNmk = e.Message;
                res.Kind = PirResultKinds.Error;
                // res.Errors.Add(new ErrorMessage() { Code = "ERR_CUSTINFOSERVICE", Message = e.Message });
                res.Errors.Add(new PirErrorMessage() { Code = "ERR_GetReqHistory", Message = e.Message });
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
            return res;
        }

    }
        #endregion //////////////////////////////////////
}
