using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Xml;
using System.Globalization;
using System.Web.Script.Serialization;

using Bars.Application;
using Bars.WebServices;
using Bars.Classes;
using Bars.Exception;
using barsroot.core;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.WebServices.CRM
{
    public class PmtDate
    {
        public DateTime FDAT;
        public Decimal? Plan_Limit;
        public Decimal? Plan_Body;
        public Decimal? Plan_Interest;
        public Decimal? Fact_Sum;
        public Int16? Fact_KV;
        public String Fact_SumDetails;
        public String Fact_Branch;

        public PmtDate(DateTime FDAT, Decimal? Plan_Limit, Decimal? Plan_Body, Decimal? Plan_Interest, Decimal? Fact_Sum, Int16? Fact_KV, String Fact_SumDetails, String Fact_Branch)
        {
            this.FDAT = FDAT;
            this.Plan_Limit = Plan_Limit;
            this.Plan_Body = Plan_Body;
            this.Plan_Interest = Plan_Interest;
            this.Fact_Sum = Fact_Sum;
            this.Fact_KV = Fact_KV;
            this.Fact_SumDetails = Fact_SumDetails;
            this.Fact_Branch = Fact_Branch;
        }

        # region Публичные методы
        public static List<PmtDate> GetList(Int64 ND, OracleConnection con)
        {
            List<PmtDate> PmtDates = new List<PmtDate>();

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select nvl(plan.fdat, fact.fdat) as fdat,
                                       plan.lim2,
                                       plan.body,
                                       plan.interest,
                                       fact.s,
                                       fact.kv,
                                       fact.sums,
                                       fact.branch
                                  from (select cl.fdat,
                                               cl.lim2,
                                               cl.sumg as body,
                                               (cl.sumo - cl.sumg) as interest
                                          from cc_lim cl
                                         where cl.nd = :p_nd) plan
                                  full outer join (select p2.fdat,
                                                          sum(p2.s) as s,
                                                          max(p2.kv_d) as kv,
                                                          dbms_lob.substr(wm_concat(t.name || ' - ' ||
                                                                                    trim(to_char(p2.s,
                                                                                                 '9999999999999999990.00')) || '; ')) as sums,
                                                          max(p2.branch) as branch
                                                     from (select p.fdat,
                                                                  p.ref,
                                                                  o.branch,
                                                                  p.stmt,
                                                                  p.tt,
                                                                  max(p.s) as s,
                                                                  max(decode(p.rec_type, 'D', p.nls, '0')) as nls_d,
                                                                  max(decode(p.rec_type, 'D', p.kv, 0)) as kv_d,
                                                                  max(decode(p.rec_type, 'K', p.nls, '0')) as nls_k,
                                                                  max(decode(p.rec_type, 'K', p.tip, '0')) as tip_k
                                                             from (select 'D' as rec_type,
                                                                          od.fdat,
                                                                          od.ref,
                                                                          od.stmt,
                                                                          od.tt,
                                                                          od.s,
                                                                          a.nls,
                                                                          a.kv,
                                                                          a.tip
                                                                     from opldok od, nd_acc na, accounts a
                                                                    where od.acc = a.acc
                                                                      and a.acc = na.acc
                                                                      and na.nd = :p_nd
                                                                      and a.nbs not like '22%'
                                                                      and a.nbs not like '35%'
                                                                      and od.dk = 0
                                                                      and od.fdat >= gl.bd - 90
                                                                   union all
                                                                   select 'K' as rec_type,
                                                                          od.fdat,
                                                                          od.ref,
                                                                          od.stmt,
                                                                          od.tt,
                                                                          od.s,
                                                                          a.nls,
                                                                          a.kv,
                                                                          a.tip
                                                                     from opldok od, nd_acc na, accounts a
                                                                    where od.acc = a.acc
                                                                      and a.acc = na.acc
                                                                      and na.nd = :p_nd
                                                                      and (a.nbs like '22%' or
                                                                          a.nbs like '35%')
                                                                      and od.dk = 1
                                                                      and od.fdat >= gl.bd - 90) p,
                                                                  oper o
                                                            where p.ref = o.ref
                                                            group by p.fdat, p.ref, o.branch, p.stmt, p.tt) p2,
                                                          tips t
                                                    where p2.tip_k = t.tip
                                                    group by p2.fdat) fact
                                    on plan.fdat = fact.fdat
                                 order by 1";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_nd", OracleDbType.Int64, ND, ParameterDirection.Input);

            OracleDataReader rdr = null;
            try
            {
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                    PmtDates.Add(new PmtDate(
                        (DateTime)rdr["fdat"],
                        rdr["lim2"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["lim2"]),
                        rdr["body"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["body"]),
                        rdr["interest"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["interest"]),
                        rdr["s"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["s"]),
                        rdr["kv"] == DBNull.Value ? (Int16?)null : Convert.ToInt16(rdr["kv"]),
                        rdr["sums"] == DBNull.Value ? (String)null : (String)rdr["sums"],
                        rdr["branch"] == DBNull.Value ? (String)null : (String)rdr["branch"]));
            }
            catch (System.Exception e)
            {
                // !!!!
            }
            finally
            {
                rdr.Close();
                rdr.Dispose();
            }

            return PmtDates;
        }
        # endregion
    }
    public class Credit
    {
        public Int64 ND;
        public String Number;
        public DateTime StartDate;
        public String TypeID;
        public String TypeName;
        public Int16 KV;
        public Decimal Sum;
        public Decimal UnpayedSum;

        public List<PmtDate> PmtDates;

        public Credit(Int64 ND, String Number, DateTime StartDate, String TypeID, String TypeName, Int16 KV, Decimal Sum, Decimal UnpayedSum, OracleConnection con)
        {
            this.ND = ND;
            this.Number = Number;
            this.StartDate = StartDate;
            this.TypeID = TypeID;
            this.TypeName = TypeName;
            this.KV = KV;
            this.Sum = Sum;
            this.UnpayedSum = UnpayedSum;

            this.PmtDates = PmtDate.GetList(ND, con);
        }

        # region Публичные методы
        public static List<Credit> GetList(Int64 RNK, OracleConnection con)
        {
            List<Credit> Credits = new List<Credit>();

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select cd.nd,
                                       cd.cc_id,
                                       cd.sdate,
                                       substr(cd.prod, 1, 6) as product_id,
                                       (select ob.txt
                                          from sb_ob22 ob
                                         where ob.r020 = substr(cd.prod, 1, 4)
                                           and ob.ob22 = substr(cd.prod, 5, 2)) as product_name,
                                       a89.kv,
                                       (select nvl(sum(bars.gl.p_ncurval(a89.kv,
                                                                         bars.gl.p_icurval(a.kv,
                                                                                           bars.fost(a.acc,
                                                                                                     gl.bd),
                                                                                           gl.bd),
                                                                         gl.bd)) / 100,
                                                   0)
                                          from nd_acc na, accounts a, accounts a89
                                         where na.nd = cd.nd
                                           and na.acc = a.acc
                                           and a.accc = a89.acc
                                           and a89.tip = 'LIM'
                                           and a89.nbs = '8999'
                                           and a.tip in ('SS ',
                                                         'SP ',
                                                         'SL ',
                                                         'SN ',
                                                         'SPN',
                                                         'SLN',
                                                         'SK0',
                                                         'SK9',
                                                         'SN8')) as summ,
                                       (select nvl(sum(bars.gl.p_ncurval(a89.kv,
                                                                         bars.gl.p_icurval(a.kv,
                                                                                           bars.fost(a.acc,
                                                                                                     gl.bd),
                                                                                           gl.bd),
                                                                         gl.bd)) / 100,
                                                   0)
                                          from nd_acc na, accounts a, accounts a89
                                         where na.nd = cd.nd
                                           and na.acc = a.acc
                                           and a.accc = a89.acc
                                           and a89.tip = 'LIM'
                                           and a89.nbs = '8999'
                                           and a.tip in ('SP ', 'SPN', 'SK9')) as unpayedsum
                                  from cc_deal cd, nd_acc na, accounts a89
                                 where cd.rnk = :p_rnk
                                   and cd.vidd in (11, 12, 13)
                                   and cd.sos >= 10
                                   and cd.nd = na.nd
                                   and na.acc = a89.acc
                                   and a89.tip = 'LIM'
                                   and a89.nbs = '8999'
                                   and (a89.dazs is null or a89.dazs > gl.bd)
                                   and a89.daos <= gl.bd
                                 order by cd.sdate";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, RNK, ParameterDirection.Input);

            OracleDataReader rdr = null;
            try
            {
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                    Credits.Add(new Credit(Convert.ToInt64(rdr["nd"]), (String)rdr["cc_id"], (DateTime)rdr["sdate"], (String)rdr["product_id"], (String)rdr["product_name"], Convert.ToInt16(rdr["kv"]), Convert.ToDecimal(rdr["summ"]), Convert.ToDecimal(rdr["unpayedsum"]), con));
            }
            finally
            {
                rdr.Close();
                rdr.Dispose();
            }

            return Credits;
        }
        # endregion
    }
    public class CurrentAccount
    {
        public Int64 ACC;
        public String NLS;
        public Int16 KV;
        public Decimal Balance;

        public CurrentAccount(Int64 ACC, String NLS, Int16 KV, Decimal Balance)
        {
            this.ACC = ACC;
            this.NLS = NLS;
            this.KV = KV;
            this.Balance = Balance;
        }

        # region Публичные методы
        public static List<CurrentAccount> GetList(Int64 RNK, OracleConnection con)
        {
            List<CurrentAccount> CurAccounts = new List<CurrentAccount>();

            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select a.acc, a.nls, a.kv, fost(a.acc, gl.bd) / 100 as ost
                                  from accounts a
                                 where nbs = '2620'
                                   and (a.dazs is null or a.dazs > gl.bd)
                                   and a.daos <= gl.bd
                                   and rnk = :p_rnk";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, RNK, ParameterDirection.Input);

            OracleDataReader rdr = null;
            try
            {
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                    CurAccounts.Add(new CurrentAccount(Convert.ToInt64(rdr["acc"]), (String)rdr["nls"], Convert.ToInt16(rdr["kv"]), Convert.ToDecimal(rdr["ost"])));
            }
            finally
            {
                rdr.Close();
                rdr.Dispose();
            }

            return CurAccounts;
        }
        # endregion
    }
    public class Client
    {
        public String MFO;
        public Int64 RNK;
        public Int32 ResultCode;
        public String ResultDescription;
        public String FIO;
        public String Documnet;
        public String IPN;
        public String Address;

        public List<CurrentAccount> CurAccounts;
        public List<Credit> Credits;

        public Client(String MFO, Int64 RNK)
        {
            this.MFO = MFO;
            this.RNK = RNK;
            this.ResultCode = 0;
            this.ResultDescription = String.Empty;

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = @"select c.rnk,
                                           c.nmk,
                                           p.passp as doc_type_id,
                                           (select psp.name from passp psp where psp.passp = p.passp) as doc_type_name,
                                           p.ser,
                                           p.numdoc,
                                           p.organ,
                                           p.pdate,
                                           c.okpo,
                                           car.zip,
                                           car.domain,
                                           car.region,
                                           car.locality,
                                           car.address
                                      from customer c,
                                           person p,
                                           (select rnk, zip, domain, region, locality, address
                                              from customer_address ca
                                             where ca.type_id = 1) car
                                     where c.rnk = p.rnk
                                       and c.custtype = 3
                                       and c.rnk = car.rnk
                                       and c.rnk = :p_rnk
                                       and c.branch like '/' || :p_mfo || '/%'";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_rnk", OracleDbType.Int64, RNK, ParameterDirection.Input);
                cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, MFO, ParameterDirection.Input);

                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    this.FIO = (String)rdr["nmk"];
                    this.Documnet = String.Format("{0} {1}{2} виданий {3} від {4:d}", rdr["doc_type_name"], rdr["ser"], rdr["numdoc"], rdr["organ"], rdr["pdate"]);
                    this.IPN = (String)rdr["okpo"];
                    this.Address = String.Format("{0}, {1}, {2}, {3}, {4}", rdr["zip"], rdr["domain"], rdr["region"], rdr["locality"], rdr["address"]);

                    // тек счета
                    this.CurAccounts = CurrentAccount.GetList(RNK, con);
                    this.Credits = Credit.GetList(RNK, con);
                }
                else
                {
                    this.ResultCode = 1;
                    this.ResultDescription = String.Format("Клієнта РНК = {0} МФО = {1} не знайдено", this.RNK, this.MFO);
                }
            }
            catch (System.Exception e)
            {
                this.ResultCode = 2;
                this.ResultDescription = String.Format("Помилка при пошуку клієнта: {0}", e.Message);
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
    public class ClientCreditsResult
    {
        public DateTime ResultDate;
        public String ServiceName;
        public Int32 ResultCode;
        public String ResultDescription;

        public Client ResultClient;

        public ClientCreditsResult()
        {
            this.ResultDate = DateTime.Now;
            this.ServiceName = "CRM Exchange";
            this.ResultCode = 0;
            this.ResultDescription = String.Empty;
        }
    }

    /// <summary>
    /// Сервис для интеграции с задачей CRM
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class CRMService : Bars.BarsWebService
    {
        # region Константы
        public const String XMLVersion = "1.0";
        public const String XMLEncoding = "UTF-8";
        public const String DateFormat = "yyyy-MM-dd";
        public const String DateTimeFormat = "yyyy-MM-dd HH:mm:ss";
        public const String NumberFormat = "######################0.00##";
        public const String DecimalSeparator = ".";
        # endregion

        # region Конструкторы
        public CRMService()
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
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public String GetClientCredits(String MFO, Int64 RNK, String CRMUserLogin, String CRMUserFIO)
        {
            ClientCreditsResult res = new ClientCreditsResult();

            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "absadm";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "qwerty";

            // авторизация пользователя по хедеру
            try
            {
                Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
                if (isAuthenticated) LoginUser(userName);

                // исключения не выбрасываются, а корректно обработываются
                res.ResultClient = new Client(MFO, RNK);
            }
            catch (System.Exception e)
            {
                res.ResultCode = 1;
                res.ResultDescription = String.Format("Помилка авторизації: {0}", e.Message);
            }

            return new JavaScriptSerializer().Serialize(res);
        }
        # endregion
    }
}