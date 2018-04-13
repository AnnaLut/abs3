using System;
using System.Collections.Generic;
using System.Web;
using System.Xml;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Text.RegularExpressions;
using System.Globalization;
using System.IO;
using System.Xml.Serialization;
using System.Text;

using Bars.Oracle;
using Bars.Application;
using Bars.WebServices;
using Bars.Classes;
using Bars.Exception;
using Bars.Logger;
using barsroot.core;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public enum AllRequests { AccountSaldoRequest, 
                          AccountListRequest, 
                          STMRequest, 
                          CustomerRequest,
                          CurrencyRateRequest, 
                          BankListRequest, 
                          KvitRequest, 
                          PayordRequest,
                          PayordRemoveRequest
                        }

// <summary>
/// Summary description for DboService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class DboService : Bars.BarsWebService
{

    public DboService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    # region Публичные свойства
    public WsHeader WsHeaderValue;

    //Дессириализация
    public class Deserialization<T>
    {
        // Метод десериализует xml в класс
        public static T XmlToObject(string xmlString)
        {
            XmlSerializer xs = new XmlSerializer(typeof(T));
            MemoryStream memoryStream = new MemoryStream(StringToUtf8ByteArray(xmlString));
            TextReader reader = new StreamReader(memoryStream);
            return (T)xs.Deserialize(reader);
        }
        // Метод конвертирует строку в UTF8 Byte массив
        private static Byte[] StringToUtf8ByteArray(string xmlString)
        {
            UTF8Encoding encoding = new UTF8Encoding();
            byte[] byteArray = encoding.GetBytes(xmlString);
            return byteArray;
        }
    }
    //***************
    //Сериализация
    public static MemoryStream SerializeToStream(object o, Type t)
    {
        MemoryStream res = new MemoryStream();
        XmlSerializer xs = new XmlSerializer(t);
        xs.Serialize(res, o);
        return res;
    }
    //Ошибки
    public class Error
    {
        public int ErrCode;
        public string ErrMessage;
    }
    //******

    //Список депозитов
    public class Account
    {
        public String Number { get; set; }
        public String CurrencyISOA3Code { get; set; }
        public String Name { get; set; }
        public String Type { get; set; }
        public String TypeName { get; set; }
        public Decimal? Percent { get; set; }
        public Decimal? AdPercent { get; set; }
        public Decimal? Saldo { get; set; }
        public DateTime? DateBegin { get; set; }
        public DateTime? DateEnd { get; set; }
        public DateTime? DateRepEnd { get; set; }
        public Decimal? Limit { get; set; }
        public Decimal? MinRep { get; set; }
        public String RefTdn { get; set; }
        public Decimal isPrologable { get; set; }
        public int isCapitalization { get; set; }
        public String PercentChargeAccount { get; set; }
        public String PercentAccount { get; set; }
        public String ExpireAccount { get; set; }
    }
    public class DepositListResponse
    {
        public List<Account> DepositList = new List<Account>();
        public List<Error> Errors = new List<Error>();
    }
    //*************

    //Создание депозита
    public class CreateDeposit
    {
        public Decimal CustomerId {get;set;}
        public Decimal REF {get;set;}
        public String AccountNumber {get;set;}
    }

    public class CreateDepositResponse 
    {
        public CreateDeposit Deposit = new CreateDeposit();
        public List<Error> Errors = new List<Error>();
    }

    public class PayOperationResponse
    {
        public Decimal REF {get;set;}
        public List<Error> Errors = new List<Error>();
    }
    //***********

    //Создание депозита
    public class DepositService
    {
        public Int64 CustomerID { get; set; }
        public String Reftdn { get; set; }
        public String Status { get; set; }
    }

    public class DepositServiceResponce
    {
        public DepositService Deposit = new DepositService();
        public List<Error> Errors = new List<Error>();
    }
    //***********

    //Список кредитов
    public class LoanListResponseDS
    {
        public LoansDS Loans = new LoansDS();
        public List<Error> Errors = new List<Error>();
    }
    public class LoanListResponse
    {
        public List<Loan> Loans = new List<Loan>();
        public List<Error> Errors = new List<Error>();
    }
    public class Loan
    {
        public String CredType { get; set; }
        public DateTime? ContractDate { get; set; }
        public String ContractNumber { get; set; }
        public DateTime? DateEnd { get; set; }
        public Decimal Percents { get; set; }
        public String PayPeriod { get; set; }
        public String CurrencyISOA3Code { get; set; }
        public Decimal? Amount { get; set; }
        public Decimal? Rest { get; set; }
        public String AccountNumber { get; set; }
        public Decimal? PercentAmount { get; set; }
        public DateTime? PercentPayTerm { get; set; }
        public Decimal? OutstandingDebt { get; set; }
        public Decimal? OutstandingPrc { get; set; }
        public Decimal? OutstandingPercent { get; set; }
        public int Status { get; set; }
        public DateTime? DateBegin { get; set; }
        public Decimal? MinRepay { get; set; }
        public Decimal? PercentPay { get; set; }
        public Decimal? OutFine { get; set; }
        public Decimal? TotalSum { get; set; }
        public DateTime? PayTerm { get; set; }
        public String RefTdn { get; set; }
        public Decimal? InqLoanPenalty { get; set; }
        public Decimal? InqIntPenalty { get; set; }
        public Decimal? AmountEarlyPay { get; set; }
        public DateTime? DateLastPay { get; set; }
        public Decimal? AmountLastPay { get; set; }
    }
    [XmlType("Loan")]
    public class LoanDS
    {
        [XmlElement("CredType")]
        public String CredType {get;set;}
        [XmlElement("ContractDate", IsNullable = true)]
        public DateTime? ContractDate { get; set; }
        [XmlElement("ContractNumber")]
        public String ContractNumber { get; set; }
        [XmlElement("DateEnd", IsNullable = true)]
        public DateTime? DateEnd { get; set; }
        [XmlElement("Percents")]
        public Decimal Percents { get; set; }
        [XmlElement("PayPeriod")]
        public String PayPeriod { get; set; }
        [XmlElement("CurrencyISOA3Code")]
        public String CurrencyISOA3Code { get; set; }
        [XmlElement("Amount", IsNullable = true)]
        public Decimal? Amount { get; set; }
        [XmlElement("Rest")]
        public String Rest { get; set; }
        [XmlElement("AccountNumber")]
        public String AccountNumber { get; set; }
        [XmlElement("PercentAmount")]
        public String PercentAmount { get; set; }
        [XmlElement("PercentPayTerm", IsNullable = true)]
        public DateTime? PercentPayTerm { get; set; }
        [XmlElement("OutstandingDebt")]
        public String OutstandingDebt { get; set; }
        [XmlElement("OutstandingPrc")]
        public String OutstandingPrc { get; set; }
        [XmlElement("OutstandingPercent")]
        public String OutstandingPercent { get; set; }
        [XmlElement("Status")]
        public int Status { get; set; }
        [XmlElement("DateBegin", IsNullable = true)]
        public DateTime? DateBegin { get; set; }
        [XmlElement("MinRepay", IsNullable = true)]
        public Decimal? MinRepay { get; set; }
        [XmlElement("PercentPay", IsNullable = true)]
        public Decimal? PercentPay { get; set; }
        [XmlElement("OutFine", IsNullable = true)]
        public Decimal? OutFine { get; set; }
        [XmlElement("TotalSum", IsNullable = true)]
        public Decimal? TotalSum { get; set; }
        [XmlElement("PayTerm", IsNullable = true)]
        public DateTime? PayTerm { get; set; }
        [XmlElement("RefTdn")]
        public String RefTdn { get; set; }
        [XmlElement("InqLoanPenalty")]
        public Decimal? InqLoanPenalty { get; set; }
        [XmlElement("InqIntPenalty")]
        public Decimal? InqIntPenalty { get; set; }
        [XmlElement("AmountEarlyPay")]
        public Decimal? AmountEarlyPay { get; set; }
        [XmlElement("DateLastPay")]
        public DateTime? DateLastPay { get; set; }
        [XmlElement("AmountLastPay")]
        public Decimal? AmountLastPay { get; set; }
    }
    [XmlRoot("Loans")]
    public class LoansDS
    {
        [XmlElement("Loan")]
        public List<LoanDS> loans = new List<LoanDS>();
    }
    //**********
    //График платежей(кредит)
    public class LoanPayListResponce
    {
        public LoanPayList PayList = new LoanPayList();
        public List<Error> Errors = new List<Error>();
    }

    [XmlRoot("LoanPayList")]
    public class LoanPayList
    {
        [XmlElement("DateBegin")]
        public DateTime DateBegin { get; set; }
        [XmlElement("DateEnd")]
        public DateTime DateEnd { get; set; }
        [XmlElement("DocNumber")]
        public String DocNumber { get; set; }
        [XmlElement("CurrencyISONCode")]
        public String CurrencyISONCode { get; set; }
        [XmlElement("AccountNumber")]
        public String AccountNumber { get; set; }
        [XmlElement("Amount")]
        public Decimal Amount { get; set; }
        [XmlElement("Percent")]
        public Decimal Percent { get; set; }
        [XmlElement("Commission")]
        public Decimal Commission { get; set; }
        [XmlElement("Pays")]
        public Pays Payss = new Pays();
    }
    [XmlType("Pays")]
    public class Pays
    {
        [XmlElement("TotalAmount")]
        public Decimal TotalAmount { get; set; }
        [XmlElement("TotalBodyPercent")]
        public Decimal TotalBodyPercent { get; set; }
        [XmlElement("TotalBody")]
        public Decimal TotalBody { get; set; }
        [XmlElement("TotalPercent")]
        public Decimal TotalPercent { get; set; }
        [XmlElement("TotalCommission")]
        public Decimal TotalCommission { get; set; }
        [XmlElement("Rest")]
        public Decimal Rest { get; set; }
        [XmlElement("Fact")]
        public Fact Facts = new Fact();
        [XmlElement("Plan")]
        public Plan Plans = new Plan();
    }
    [XmlType("Fact")]
    public class Fact
    {
        [XmlElement("TotalAmount")]
        public Decimal TotalAmount { get; set; }
        [XmlElement("TotalBody")]
        public Decimal TotalBody { get; set; }
        [XmlElement("TotalPercent")]
        public Decimal TotalPercent { get; set; }
        [XmlElement("TotalCommission")]
        public Decimal TotalCommission { get; set; }
        [XmlElement("Rest")]
        public Decimal Rest { get; set; }
        [XmlElement("Pay")]
        public List<Pay> Pays = new List<Pay>();
    }

    [XmlType("Plan")]
    public class Plan
    {
        [XmlElement("TotalAmount")]
        public Decimal TotalAmount { get; set; }
        [XmlElement("TotalBody")]
        public Decimal TotalBody { get; set; }
        [XmlElement("TotalPercent")]
        public Decimal TotalPercent { get; set; }
        [XmlElement("TotalCommission")]
        public Decimal TotalCommission { get; set; }
        [XmlElement("Rest")]
        public Decimal Rest { get; set; }
        [XmlElement("Pay")]
        public List<Pay> Pays = new List<Pay>();
    }

    [XmlType("Pay")]
    public class Pay
    {
        [XmlElement("Date")]
        public DateTime Date { get; set; }
        [XmlElement("Amount")]
        public Decimal Amount { get; set; }
        [XmlElement("Body")]
        public Decimal Body { get; set; }
        [XmlElement("Percent")]
        public Decimal Percent { get; set; }
        [XmlElement("Commission")]
        public Decimal Commision { get; set; }
        [XmlElement("Rest")]
        public Decimal Rest { get; set; }
    }
    //**********
    # endregion

    # region Приватные методы

    private String getNodeText(XmlNode srcNode, String nodeName, String defaultValue)
    {
        XmlNode res = srcNode.SelectSingleNode(nodeName);
        String result = res == null ? defaultValue : res.InnerText;
        return result;
    } 
    /// <summary>
    ///  Строка значений параметров из web_userparams
    /// </summary>
    /// <param name="params_str">строка имен параметров через запятую</param>
    /// <param name="role">имя роли</param>
    /// <returns>строка значений</returns>
    private string GetUserParams(string params_str, string role)
    {
        return String.Empty;
    }
    /// <summary>
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
    public XmlNode ProcessXmlRequest(XmlNode Xml)
    {
        if (null == Xml) return null;

        String rootElement = null;
            
        rootElement = Xml.Name;

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        try
        {
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated) LoginUser(userName);

            if (rootElement == AllRequests.AccountSaldoRequest.ToString())
                return processAccountSaldoRequest(Xml);
            if (rootElement == AllRequests.AccountListRequest.ToString())
                return processAccountListRequest(Xml);
            if (rootElement == AllRequests.STMRequest.ToString())
                return processSTMRequest(Xml);
            if (rootElement == AllRequests.CustomerRequest.ToString())
                return processCustomerRequest(Xml);
            if (rootElement == AllRequests.CurrencyRateRequest.ToString())
                return processСurrencyRateRequest(Xml);
            if (rootElement == AllRequests.BankListRequest.ToString())
                return processBankListRequest(Xml);
            if (rootElement == AllRequests.KvitRequest.ToString())
                return processKvitRequest(Xml);
            if (rootElement == AllRequests.PayordRequest.ToString())
                return processPayordRequest(Xml);
            if (rootElement == AllRequests.PayordRemoveRequest.ToString())
                return processPayordRemoveRequest(Xml);
        }
        catch (OracleException e)
        {
            return processErr(e, rootElement.Replace("Request","") + "Responce");
        }
        return processNotRequest(Xml);
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public DepositListResponse DepositListRequest(Decimal CustomerId)
    {
        DepositListResponse dep_list = new DepositListResponse();
        Error err = new Error();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;
        
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        Decimal aud_id = SoapAudit("Request=DepositListRequest;CustomerId=" + Convert.ToString(CustomerId) + ";");

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandText = "select * from v_dbo_deposit_list where cust_id = :p_rnk";
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerId, System.Data.ParameterDirection.Input);

            OracleDataReader reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                err.ErrCode = -1;
                err.ErrMessage = String.Format("Клієнта {0} не знайдено", CustomerId);
                dep_list.Errors.Add(err);

                return dep_list;
            }

            while (reader.Read())
            {
                Account dep = new Account();
                dep.Number = reader["dpt_accnum"].ToString();
                dep.CurrencyISOA3Code = reader["dpt_curcode"].ToString();
                dep.Name = reader["cust_name"].ToString();
                dep.Type = reader["vidd_code"].ToString();
                dep.TypeName = reader["vidd_name"].ToString();
                dep.Percent = reader["rate"] == null ? (Decimal?)null : (Decimal?)reader["rate"];
                dep.AdPercent = reader["int_kos"] == null ? (Decimal?)null : (Decimal?)reader["int_kos"];
                dep.Saldo = reader["dpt_saldo"] == null ? (Decimal?)null : (Decimal?)reader["dpt_saldo"];
                if (!String.IsNullOrEmpty(reader["dat_begin"].ToString()))
                    dep.DateBegin = (DateTime?)reader["dat_begin"];
                if (!String.IsNullOrEmpty(reader["dat_end"].ToString()))
                    dep.DateEnd = (DateTime?)reader["dat_end"];
                if (!String.IsNullOrEmpty(reader["term_add"].ToString()))
                    dep.DateRepEnd = (DateTime?)reader["term_add"];
                dep.Limit = String.IsNullOrEmpty(Convert.ToString(reader["lim"])) ? (Decimal?)null : (Decimal?)reader["lim"];
                dep.MinRep = String.IsNullOrEmpty(Convert.ToString(reader["minrep"])) ? (Decimal?)null : (Decimal?)reader["minrep"];
                dep.RefTdn = reader["dpt_id"].ToString();
                dep.isPrologable = (Decimal)reader["isprologable"];
                dep.isCapitalization = Convert.ToInt16(reader["iscapitalization"].ToString());
                dep.PercentChargeAccount = reader["percentchargeaccount"].ToString();
                dep.PercentAccount = reader["percentaccount"].ToString();
                dep.ExpireAccount = reader["expireaccount"].ToString();
                dep_list.DepositList.Add(dep);
            }
            MemoryStream stream = SerializeToStream(dep_list, typeof(DepositListResponse));
            StreamReader streader = new StreamReader(stream);
            streader.BaseStream.Position = 0;
            String OutXml = streader.ReadToEnd();
            UpdateAudit(aud_id, OutXml);

            return dep_list;
        }
        catch (System.Exception ex)
        {
            Decimal recId = DBLogger.Error("ex.InnerException = " + ex.InnerException + " ex.Message = " + ex.Message + " ex.Source = " + ex.Source + " ex.StackTrace = " + ex.StackTrace);
            err.ErrCode = -1;
            err.ErrMessage = "Системна помил. Зверніться до адміністратора. Номер запису аудиту " + Convert.ToString(recId);
            dep_list.Errors.Add(err);
            MemoryStream stream = SerializeToStream(dep_list, typeof(DepositListResponse));
            StreamReader streader = new StreamReader(stream);
            streader.BaseStream.Position = 0;
            String OutXml = streader.ReadToEnd();
            UpdateAudit(aud_id, OutXml);
            return dep_list;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public CreateDepositResponse CreateDepositRequest(Decimal CustomerId, String CurrencyISOA3Code, DateTime DocDate, String DocNumber, String Term, int Type, Decimal Amount, String ReplanishAccount, String PercentAccount, String PercentAccountBranch, String ExpireAccount, String ExpireAccountBranch)
    {
        CreateDepositResponse cdr = new CreateDepositResponse();
        CreateDeposit crd_one = new CreateDeposit();
        Error err = new Error();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        Decimal aud_id = SoapAudit("Request=CreateDepositRequest;CustomerId=" + Convert.ToString(CustomerId) + ";CurrencyISOA3Code=" + CurrencyISOA3Code + ";DocDate=" + Convert.ToString(DocDate) + ";DocNumber=" + DocNumber + ";Term=" + Term + ";Type=" + Convert.ToString(Type) + ";Amount=" + Convert.ToString(Amount) + ";ReplanishAccount=" + ReplanishAccount + ";PercentAccount=" + PercentAccount + ";PercentAccountBranch=" + PercentAccountBranch + ";ExpireAccount=" + ExpireAccount + ";ExpireAccountBranch=" + ExpireAccountBranch);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        try
        {
            cmd.CommandText = "bars_dbo.create_deposit_dbo";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerId, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_kv", OracleDbType.Varchar2, CurrencyISOA3Code, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_doc_date", OracleDbType.Date, DocDate, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_doc_number", OracleDbType.Varchar2, DocNumber, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_term", OracleDbType.Varchar2, Term, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_type", OracleDbType.Decimal, Type, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_ammount", OracleDbType.Decimal, Amount, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_replanish_account", OracleDbType.Varchar2, ReplanishAccount, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_percent_account", OracleDbType.Varchar2, PercentAccount, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_percent_account_branch", OracleDbType.Varchar2, PercentAccountBranch, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_expire_account", OracleDbType.Varchar2, ExpireAccount, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_expire_account_branch", OracleDbType.Varchar2, ExpireAccountBranch, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, 14, crd_one.AccountNumber, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add("p_errcode", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add("p_errmessage", OracleDbType.Varchar2, 4000, crd_one.AccountNumber, System.Data.ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            Decimal p_rnk = (Decimal)cmd.Parameters["p_rnk"].Value;
            OracleDecimal p_ref = (OracleDecimal)cmd.Parameters["p_ref"].Value;
            OracleString p_accnum = (OracleString)cmd.Parameters["p_nls"].Value;
            OracleDecimal p_errcode = (OracleDecimal)cmd.Parameters["p_errcode"].Value;
            OracleString p_errmessage = (OracleString)cmd.Parameters["p_errmessage"].Value;


            if (p_errcode == 0)
            {
                crd_one.CustomerId = (Decimal)cmd.Parameters["p_rnk"].Value;
                crd_one.REF = ((OracleDecimal)cmd.Parameters["p_ref"].Value).Value;
                crd_one.AccountNumber = ((OracleString)cmd.Parameters["p_nls"].Value).Value;
                cdr.Deposit = crd_one;
                MemoryStream stream = SerializeToStream(cdr, typeof(CreateDepositResponse));
                StreamReader streader = new StreamReader(stream);
                streader.BaseStream.Position = 0;
                String OutXml = streader.ReadToEnd();
                UpdateAudit(aud_id, OutXml);
                return cdr;
            }
            else
            {
                err.ErrCode = -1;
                err.ErrMessage = (String)p_errmessage;
                cdr.Errors.Add(err);
                MemoryStream stream = SerializeToStream(cdr, typeof(CreateDepositResponse));
                StreamReader streader = new StreamReader(stream);
                streader.BaseStream.Position = 0;
                String OutXml = streader.ReadToEnd();
                UpdateAudit(aud_id, OutXml);
                return cdr;
            }
        }
        catch (OracleException e)
        {
            err.ErrCode = -1;
            err.ErrMessage = ParseError(e.Message);
            cdr.Errors.Add(err);
            MemoryStream stream = SerializeToStream(cdr, typeof(CreateDepositResponse));
            StreamReader streader = new StreamReader(stream);
            streader.BaseStream.Position = 0;
            String OutXml = streader.ReadToEnd();
            UpdateAudit(aud_id, OutXml);
            return cdr;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public DepositServiceResponce DepositServiceRequest(Decimal? CustomerId, String RefTdn, DateTime? DocDate, String DocNumber, String Prolongation/*String PercentAccount, String PercentAccountBranch, String ExpireAccount, String ExpireAccountBranch*/)
    {
        DepositServiceResponce ds = new DepositServiceResponce();
        DepositService dep_service = new DepositService();
        Error err = new Error();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        Decimal aud_id = SoapAudit("Request=DepositServiceRequest;CustomerId=" + Convert.ToString(CustomerId) + ";RefTdn=" + RefTdn + ";DocDate=" + Convert.ToString(DocDate) + ";DocNumber=" + DocNumber + ";Prolongation=" + Prolongation/*";PercentAccount=" + PercentAccount + ";PercentAccountBranch=" + PercentAccountBranch + ";ExpireAccount=" + ExpireAccount + ";ExpireAccountBranch=" + ExpireAccountBranch*/);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        try
        {
            cmd.CommandText = "bars_dbo.deposit_service";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerId, System.Data.ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_reftdn", OracleDbType.Varchar2, 4000, RefTdn, System.Data.ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_doc_date", OracleDbType.Date, DocDate, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_doc_number", OracleDbType.Varchar2, DocNumber, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_prolongation", OracleDbType.Varchar2, Prolongation, System.Data.ParameterDirection.Input);
            /*cmd.Parameters.Add("p_percent_account", OracleDbType.Varchar2, PercentAccount, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_percent_account_branch", OracleDbType.Varchar2, PercentAccountBranch, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_expire_account", OracleDbType.Varchar2, ExpireAccount, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_expire_account_branch", OracleDbType.Varchar2, ExpireAccountBranch, System.Data.ParameterDirection.Input);*/
            cmd.Parameters.Add("p_status", OracleDbType.Varchar2, 4000, dep_service.Status, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add("p_errcode", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add("p_errmessage", OracleDbType.Varchar2, 4000, dep_service.Reftdn, System.Data.ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            /*OracleString p_reftdn = (OracleString)cmd.Parameters["p_reftdn"].Value;
            OracleString p_rnk = (OracleString)cmd.Parameters["p_rnk"].Value;
            OracleString p_status = (OracleString)cmd.Parameters["p_status"].Value;*/
            OracleDecimal? p_errcode = (OracleDecimal?)cmd.Parameters["p_errcode"].Value;
            OracleString p_errmessage = (OracleString)cmd.Parameters["p_errmessage"].Value;


            if (p_errcode == 0)
            {
                dep_service.CustomerID = Convert.ToInt64(cmd.Parameters["p_rnk"].Value.ToString());
                dep_service.Reftdn = ((OracleString)cmd.Parameters["p_reftdn"].Value).Value;
                dep_service.Status = ((OracleString)cmd.Parameters["p_status"].Value).Value;
                ds.Deposit = dep_service;
                MemoryStream stream = SerializeToStream(ds, typeof(DepositServiceResponce));
                StreamReader streader = new StreamReader(stream);
                streader.BaseStream.Position = 0;
                String OutXml = streader.ReadToEnd();
                UpdateAudit(aud_id, OutXml);
                return ds;
            }
            else
            {
                err.ErrCode = -1;
                err.ErrMessage = (String)p_errmessage;
                ds.Errors.Add(err);
                MemoryStream stream = SerializeToStream(ds, typeof(DepositServiceResponce));
                StreamReader streader = new StreamReader(stream);
                streader.BaseStream.Position = 0;
                String OutXml = streader.ReadToEnd();
                UpdateAudit(aud_id, OutXml);
                return ds;
            }
        }
        catch (OracleException e)
        {
            err.ErrCode = -1;
            err.ErrMessage = ParseError(e.Message);
            ds.Errors.Add(err);
            MemoryStream stream = SerializeToStream(ds, typeof(DepositServiceResponce));
            StreamReader streader = new StreamReader(stream);
            streader.BaseStream.Position = 0;
            String OutXml = streader.ReadToEnd();
            UpdateAudit(aud_id, OutXml);
            return ds;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public PayOperationResponse PayOperationRequest(Decimal? CustomerId, Decimal RefTdn, String ActionCode, DateTime DayDate, Decimal Amount, String CurrencyTag, String AccountNumber, String PaymentDetails)
    {
        PayOperationResponse pay_ref = new PayOperationResponse();
        Error err = new Error();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        Decimal aud_id = SoapAudit("Request=PayOperationRequest;CustomerId=" + Convert.ToString(CustomerId) + ";RefTdn=" + Convert.ToString(RefTdn) + ";ActionCode=" + ActionCode + ";DayDate=" + Convert.ToString(DayDate) + ";Amount=" + Convert.ToString(Amount) + ";CurrencyTag=" + CurrencyTag + ";AccountNumber=" + AccountNumber + "PaymentDetails=" + PaymentDetails);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        try
        {
            cmd.CommandText = "bars_dbo.pay_operation";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, String.IsNullOrEmpty(Convert.ToString(CustomerId)) ? -1 : CustomerId, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_refTnd", OracleDbType.Decimal, RefTdn, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_actionCode", OracleDbType.Varchar2, ActionCode, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_dayDate", OracleDbType.Date, DayDate, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_amount", OracleDbType.Decimal, Amount, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_abrevKV", OracleDbType.Varchar2, CurrencyTag, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_ammountNumber", OracleDbType.Varchar2, AccountNumber, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_nazn", OracleDbType.Varchar2, PaymentDetails, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add("p_errcod", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
            OracleParameter parerr = new OracleParameter("p_errmessage", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add(parerr);

            cmd.ExecuteNonQuery();
            
            OracleDecimal res = (OracleDecimal)cmd.Parameters["p_ref"].Value;
            OracleDecimal error = (OracleDecimal)cmd.Parameters["p_errcod"].Value;
            OracleString errmsg = (OracleString)cmd.Parameters["p_errmessage"].Value;

            
            if (error == 0)
            {
                pay_ref.REF = (Decimal)res;
                MemoryStream stream = SerializeToStream(pay_ref, typeof(PayOperationResponse));
                StreamReader streader = new StreamReader(stream);
                streader.BaseStream.Position = 0;
                String OutXml = streader.ReadToEnd();
                UpdateAudit(aud_id, OutXml);
                return pay_ref;
            }
            else
            {
                err.ErrCode = -1;
                err.ErrMessage = (String)errmsg;
                pay_ref.Errors.Add(err);
                MemoryStream stream = SerializeToStream(pay_ref, typeof(PayOperationResponse));
                StreamReader streader = new StreamReader(stream);
                streader.BaseStream.Position = 0;
                String OutXml = streader.ReadToEnd();
                UpdateAudit(aud_id, OutXml);
                return pay_ref;
            }
          
        }
        catch (Exception e)
        {
            err.ErrCode = -1;
            err.ErrMessage = Convert.ToString(e);
            pay_ref.Errors.Add(err);
            MemoryStream stream = SerializeToStream(pay_ref, typeof(PayOperationResponse));
            StreamReader streader = new StreamReader(stream);
            streader.BaseStream.Position = 0;
            String OutXml = streader.ReadToEnd();
            UpdateAudit(aud_id, OutXml);
            return pay_ref;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public LoanListResponse LoanListRequest(Decimal CustomerId)
    {
        LoansDS loanDS = new LoansDS();
        Loan loan = new Loan();
        LoanListResponse loan_list = new LoanListResponse();
        Error err = new Error();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        Decimal aud_id = SoapAudit("Request=LoanListRequest;CustomerId=" + Convert.ToString(CustomerId) + ";");

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        String stringXml = "";
        try
        {
            cmd.CommandText = "select bars_dbo.get_loan_list_xml(:p_rnk) from dual";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerId, System.Data.ParameterDirection.Input);
            OracleDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                stringXml += reader.IsDBNull(0) ? "" : reader.GetString(0);
            }

            reader.Close();

            if (String.IsNullOrEmpty(stringXml))
            {
                /*err.ErrCode = -1;
                err.ErrMessage = String.Format("Не знайдено кредитів у кліента РНК №{0}", CustomerId);
                loan_list.Errors.Add(err);*/
                UpdateAudit(aud_id, stringXml);
                return loan_list;
            }
            else
            {
                loanDS = Deserialization<LoansDS>.XmlToObject(stringXml);
                foreach (var d in loanDS.loans)
                {
                    var l = new Loan()
                    {
                        CredType = d.CredType,
                        ContractDate = d.ContractDate,
                        ContractNumber = d.ContractNumber,
                        DateEnd = d.DateEnd,
                        Percents = d.Percents,
                        PayPeriod = d.PayPeriod,
                        CurrencyISOA3Code = d.CurrencyISOA3Code,
                        Amount = d.Amount,
                        Rest = string.IsNullOrEmpty(d.Rest) ? (Decimal?)null : Convert.ToDecimal(d.Rest),
                        AccountNumber = d.AccountNumber,
                        PercentAmount = string.IsNullOrEmpty(d.PercentAmount) ? (Decimal?)null : Convert.ToDecimal(d.PercentAmount),
                        PercentPayTerm = d.PercentPayTerm,
                        OutstandingDebt = string.IsNullOrEmpty(d.OutstandingDebt) ? (Decimal?)null : Convert.ToDecimal(d.OutstandingDebt),
                        OutstandingPrc = string.IsNullOrEmpty(d.OutstandingPrc) ? (Decimal?)null : Convert.ToDecimal(d.OutstandingPrc),
                        OutstandingPercent = string.IsNullOrEmpty(d.OutstandingPercent) ? (Decimal?)null : Convert.ToDecimal(d.OutstandingPercent),
                        Status = d.Status,
                        DateBegin = d.DateBegin,
                        MinRepay = d.MinRepay,
                        PercentPay = d.PercentPay,
                        OutFine = d.OutFine,
                        TotalSum = d.TotalSum,
                        PayTerm = d.PayTerm,
                        RefTdn = d.RefTdn,
                        InqLoanPenalty = d.InqLoanPenalty,
                        InqIntPenalty = d.InqLoanPenalty,
                        AmountEarlyPay = d.AmountEarlyPay,
                        DateLastPay = d.DateLastPay,
                        AmountLastPay = d.AmountLastPay
                    };
                    loan_list.Loans.Add(l);
                }
                UpdateAudit(aud_id, stringXml);
                
                //loan_list.Loans = loan;

                return loan_list;
            }
        }
        catch (Exception e)
        {
            err.ErrCode = -1;
            err.ErrMessage = Convert.ToString(e);
            loan_list.Errors.Add(err);
            return loan_list;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public LoanPayListResponce LoanPayListRequest(Decimal CustomerId, String RefTdn)
    {
        LoanPayList pay_list = new LoanPayList();
        LoanPayListResponce loan_pay_list = new LoanPayListResponce();
        Error err = new Error();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        Decimal aud_id = SoapAudit("Request=LoanPayListRequest;CustomerId=" + Convert.ToString(CustomerId) + ";RefTdn=" + RefTdn + ";");

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        String stringXml = "";

        try
        {
            cmd.CommandText = "select bars_dbo.get_loan_pay_list_xml(:p_rnk,:p_nd) from dual";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerId, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_nd", OracleDbType.Decimal, Convert.ToDecimal(RefTdn), System.Data.ParameterDirection.Input);
            OracleDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                stringXml += reader.IsDBNull(0) ? "" : reader.GetString(0);
            }

            reader.Close();

            pay_list = Deserialization<LoanPayList>.XmlToObject(stringXml);
            loan_pay_list.PayList = pay_list;
            UpdateAudit(aud_id, stringXml);
            return loan_pay_list;
        }
        catch (Exception e)
        {
            err.ErrCode = -1;
            err.ErrMessage = Convert.ToString(e);
            loan_pay_list.Errors.Add(err);
            return loan_pay_list;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
    # endregion
    public XmlNode processAccountSaldoRequest(XmlNode Xml)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        XmlDocument doc_iner = new XmlDocument();
        doc_iner.LoadXml(Xml.OuterXml);

        Decimal aud_id = XmlAudit(Xml);

        XmlNode custIdnode = doc_iner.SelectSingleNode("/AccountSaldoRequest/CustomerId");
        Decimal cusId = custIdnode != null ? Convert.ToDecimal(custIdnode.InnerText) : 0;

        XmlDocument doc = new XmlDocument();

        XmlElement root = doc.CreateElement("AccountSaldoResponse");
        doc.AppendChild(root);
        
        XmlNodeList acc_list = doc_iner.SelectNodes("/AccountSaldoRequest/Account");

        for (int i = 0; i < acc_list.Count; i++)
        {
            try
            {
                string lcv = acc_list.Item(i).SelectSingleNode("CurrencyISOA3Code").InnerText;
                string nls = acc_list.Item(i).SelectSingleNode("Number").InnerText;

                cmd.CommandText = "select bars_dbo.get_account_saldo_xml(:p_rnk, :p_lcv, :p_nls) from dual";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, cusId, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_lcv", OracleDbType.Varchar2, lcv, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, nls, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    root.InnerXml += reader.IsDBNull(0) ? "" : reader.GetString(0);
                }
                UpdateAudit(aud_id, root.InnerXml);
                reader.Close();
            }
            catch (OracleException e)
            {
                root.InnerXml += ProcessingLine(e.Message);
                UpdateAudit(aud_id, root.InnerXml);
            }
        }
        con.Close();
        con.Dispose();
        return doc;

    }

    public XmlNode processAccountListRequest(XmlNode Xml)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        XmlDocument doc_iner = new XmlDocument();
        doc_iner.LoadXml(Xml.OuterXml);

        Decimal aud_id = XmlAudit(Xml);

        XmlNode custIdnode = doc_iner.SelectSingleNode("/AccountListRequest/CustomerId");
        Decimal cusId = custIdnode != null ? Convert.ToDecimal(custIdnode.InnerText) : 0;

        XmlDocument doc = new XmlDocument();

        XmlElement root = doc.CreateElement("AccountListResponse");
        doc.AppendChild(root);

        try
        {
            cmd.CommandText = "select bars_dbo.get_account_list_xml(:p_rnk) from dual";
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, cusId, System.Data.ParameterDirection.Input);

            OracleDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                root.InnerXml += reader.GetString(0);
            }
            UpdateAudit(aud_id, root.InnerXml);
            reader.Close();
        }
        catch (OracleException e)
        {
            root.InnerXml = ProcessingLine(e.Message);
            UpdateAudit(aud_id, root.InnerXml);
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        
        return doc;
    }

    public XmlNode processSTMRequest(XmlNode Xml)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.CommandTimeout = 280;

        XmlDocument doc_iner = new XmlDocument();
        doc_iner.LoadXml(Xml.OuterXml);

        Decimal aud_id = XmlAudit(Xml);

        XmlNode dateBegin = doc_iner.SelectSingleNode("/STMRequest/DateBegin");
        DateTime? dateB = DateTime.ParseExact(dateBegin.InnerText, "dd.MM.yyyy", CultureInfo.InvariantCulture); 

        XmlNode dateEnd = doc_iner.SelectSingleNode("/STMRequest/DateEnd");
        DateTime? dateE = DateTime.ParseExact(dateEnd.InnerText, "dd.MM.yyyy", CultureInfo.InvariantCulture);

        XmlDocument doc = new XmlDocument();
        XmlElement root = doc.CreateElement("STMResponse");
        doc.AppendChild(root);

        XmlElement date1 = doc.CreateElement("DateBegin");
        root.AppendChild(date1);
        date1.InnerText = String.Format("{0:dd.MM.yyyy}", dateB);

        XmlElement date2 = doc.CreateElement("DateEnd");
        root.AppendChild(date2);
        date2.InnerText = String.Format("{0:dd.MM.yyyy}", dateE);

        XmlNodeList acc_list = doc_iner.SelectNodes("/STMRequest/Accounts/Account");

        try
        {
            for (int i = 0; i < acc_list.Count; i++)
            {
                string acc = acc_list.Item(i).SelectSingleNode("AccountNumber").InnerText;
                string lcv = acc_list.Item(i).SelectSingleNode("CurrencyISOA3Code").InnerText;

                cmd.CommandText = "bars_dbo.get_statement";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_date1", OracleDbType.Date, dateB, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_date2", OracleDbType.Date, dateE, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, acc, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_lcv", OracleDbType.Varchar2, lcv, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_stm", OracleDbType.Clob, System.Data.ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                OracleClob res = (OracleClob)cmd.Parameters["p_stm"].Value;
                string accSTM = res.IsNull ? null : res.Value;

                res.Close();
                res.Dispose();

                root.InnerXml += accSTM;
                UpdateAudit(aud_id, root.InnerXml);
            }
            return doc;
        }
        catch (OracleException e)
        {
            root.InnerXml = "";
            root.InnerXml = ProcessingLine(e.Message);
            UpdateAudit(aud_id, root.InnerXml);
            return doc;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    public XmlNode processCustomerRequest(XmlNode Xml)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        XmlDocument doc_iner = new XmlDocument();
        doc_iner.LoadXml(Xml.OuterXml);

        Decimal aud_id = XmlAudit(Xml);

        XmlNode custIdnode = doc_iner.SelectSingleNode("/CustomerRequest/CustomerId");
        Decimal cusId = custIdnode != null ? Convert.ToDecimal(custIdnode.InnerText) : 0;

        XmlDocument doc = new XmlDocument();

        XmlElement root = doc.CreateElement("CustomerResponse");
        doc.AppendChild(root);

        try
        {
            cmd.CommandText = "select bars_dbo.get_customer_xml(:p_rnk) from dual";
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, cusId, System.Data.ParameterDirection.Input);

            OracleDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                root.InnerXml += reader.GetString(0);
            }
            UpdateAudit(aud_id, root.InnerXml);
            reader.Close();
        }
        catch (OracleException e)
        {
            root.InnerXml = ProcessingLine(e.Message);
            UpdateAudit(aud_id, root.InnerXml);
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return doc;
    }

    public XmlNode processСurrencyRateRequest(XmlNode Xml)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        XmlDocument doc = new XmlDocument();

        Decimal aud_id = XmlAudit(Xml);

        XmlElement root = doc.CreateElement("CurrencyRateResponse");
        doc.AppendChild(root);

        try
        {
            cmd.CommandText = "select bars_dbo.get_currency_rate_xml from dual";

            OracleDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                root.InnerXml += reader.GetString(0);
            }
            UpdateAudit(aud_id, root.InnerXml);
            reader.Close();
        }
        catch (OracleException e)
        {
            root.InnerXml = ProcessingLine(e.Message);
            UpdateAudit(aud_id, root.InnerXml);
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return doc;
    }

    public XmlNode processBankListRequest(XmlNode Xml)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        XmlDocument doc = new XmlDocument();

        Decimal aud_id = XmlAudit(Xml);

        XmlElement root = doc.CreateElement("BankListResponse");
        doc.AppendChild(root);

        try
        {
            cmd.CommandText = "select bars_dbo.get_banks_list_xml from dual";

            OracleDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                root.InnerXml += reader.GetString(0);
            }
            UpdateAudit(aud_id, root.InnerXml);
            reader.Close();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return doc;
    }

    public XmlNode processKvitRequest(XmlNode Xml)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        cmd.CommandTimeout = 480;

        XmlDocument doc_iner = new XmlDocument();
        doc_iner.LoadXml(Xml.OuterXml);

        Decimal aud_id = XmlAudit(Xml);

        XmlDocument doc = new XmlDocument();
        XmlElement root = doc.CreateElement("KvitResponse");
        doc.AppendChild(root);

        Decimal refr = 0;
        XmlNodeList refer = doc_iner.SelectNodes("/KvitRequest/Document/Ref");
        
        for (int i = 0; i < refer.Count; i++)
        {
            try
            {
                refr = Convert.ToDecimal(refer.Item(i).InnerText);

                cmd.CommandText = "select bars_dbo.get_kvit_xml(:p_ref) from dual";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_ref", OracleDbType.Decimal, refr, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    root.InnerXml += reader.IsDBNull(0) ? "" : reader.GetString(0);
                }
                UpdateAudit(aud_id, root.InnerXml);
                reader.Close();
            }
            catch (OracleException e)
            {
                root.InnerXml += ProcessingLine(e.Message);
                UpdateAudit(aud_id, root.InnerXml);
            }
        }

        con.Close();
        con.Dispose();
        return doc;
    }

    public XmlNode processPayordRequest(XmlNode Xml)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
         OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
       
        cmd.CommandTimeout = 500;

        XmlDocument doc_iner = new XmlDocument();
        doc_iner.LoadXml(Xml.OuterXml);

        Decimal aud_id = XmlAudit(Xml);

        Decimal p_type = Convert.ToDecimal(String.IsNullOrEmpty(getNodeText(doc_iner, "/PayordRequest/OperationKind", null)) ? "-1" : getNodeText(doc_iner, "/PayordRequest/OperationKind", "0"));
        string p_nd = getNodeText(doc_iner, "/PayordRequest/DocNumber", String.Empty);
        DateTime p_datd = DateTime.ParseExact(getNodeText(doc_iner, "/PayordRequest/DocDate", null), "dd.MM.yyyy", CultureInfo.InvariantCulture);
        string p_kv = getNodeText(doc_iner, "/PayordRequest/CurrencyISOA3Code", String.Empty);
        DateTime p_vdat = DateTime.ParseExact(getNodeText(doc_iner, "/PayordRequest/CurrencyDate", null), "dd.MM.yyyy", CultureInfo.InvariantCulture);
        Decimal p_s = Convert.ToDecimal(getNodeText(doc_iner, "/PayordRequest/Amount", null));
        string p_nazn = getNodeText(doc_iner, "/PayordRequest/PaymentDetails", String.Empty);
        Decimal p_rnka = Convert.ToDecimal(String.IsNullOrEmpty(getNodeText(doc_iner, "/PayordRequest/Sender/CustomerId", null)) ? "-1" : getNodeText(doc_iner, "/PayordRequest/Sender/CustomerId", null));
        string p_nlsa = getNodeText(doc_iner, "/PayordRequest/Sender/AccountNumber", String.Empty);
        Decimal p_mfob = Convert.ToDecimal(getNodeText(doc_iner, "/PayordRequest/Recipient/Mfo", null));
        string p_nmkb = getNodeText(doc_iner, "/PayordRequest/Recipient/Name", String.Empty);
        string p_nlsb = getNodeText(doc_iner, "/PayordRequest/Recipient/AccountNumber", String.Empty);
        string p_okpo = getNodeText(doc_iner, "/PayordRequest/Recipient/Okpo", String.Empty);
        string p_passport = getNodeText(doc_iner, "/PayordRequest/Recipient/Passport", String.Empty);
        XmlNodeList add_par = doc_iner.SelectNodes("/PayordRequest/AditionalParams/Param");
        String p_param = "";

        for (int i = 0; i < add_par.Count; i++)
        {
            p_param += add_par.Item(i).SelectSingleNode("Name").InnerText + "-" + add_par.Item(i).SelectSingleNode("Value").InnerText + ";";
        }

        XmlDocument doc = new XmlDocument();
        XmlElement root = doc.CreateElement("PayordResponse");
        doc.AppendChild(root);

        XmlElement refer = doc.CreateElement("Ref");
        root.AppendChild(refer);

        try
        {
            cmd.CommandText = "bars_dbo.payord";

            cmd.Parameters.Add("p_type", OracleDbType.Decimal, p_type, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_nd", OracleDbType.Varchar2, p_nd, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_datd", OracleDbType.Date, p_datd, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_kv", OracleDbType.Varchar2, p_kv, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_vdat", OracleDbType.Date, p_vdat, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_s", OracleDbType.Decimal, p_s, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_nazn", OracleDbType.Varchar2, p_nazn, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_rnka", OracleDbType.Decimal, p_rnka, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_nlsa", OracleDbType.Varchar2, p_nlsa, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_mfob", OracleDbType.Decimal, p_mfob, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_nmkb", OracleDbType.Varchar2, p_nmkb, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_nlsb", OracleDbType.Varchar2, p_nlsb, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, p_okpo, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_passport", OracleDbType.Varchar2, p_passport, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_param", OracleDbType.Varchar2, p_param, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add("p_errcod", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
            OracleParameter parerr = new OracleParameter("p_errmessage", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add(parerr);

            cmd.ExecuteNonQuery();

            OracleDecimal res = (OracleDecimal)cmd.Parameters["p_ref"].Value;
            OracleDecimal err = (OracleDecimal)cmd.Parameters["p_errcod"].Value;
            OracleString errmsg = (OracleString)cmd.Parameters["p_errmessage"].Value;

            if (err == 0)
            {
                Decimal? referens = res.Value;

                refer.InnerText = Convert.ToString(referens);
                UpdateAudit(aud_id, root.InnerXml);
                return doc;
            }
            else
            {
                if (err < 0)
                {
                    root.InnerXml = ProcessingLine(Convert.ToString(errmsg));
                    UpdateAudit(aud_id, root.InnerXml);
                }
                else
                {
                    String errorCode = String.Format("UPB-{0:000000}", err.Value);
                    root.InnerXml = "<Error><ErrCode>-1</ErrCode><ErrMessage>" + errorCode + " " + Convert.ToString(errmsg) + "</ErrMessage></Error>";
                    UpdateAudit(aud_id, root.InnerXml);
                }
                return doc;
            }
        }
        catch (OracleException e)
        {
            return processErr(e, "PayordResponce");
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

    }

    public XmlNode processPayordRemoveRequest(XmlNode Xml)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.CommandTimeout = 280;

        XmlDocument doc_iner = new XmlDocument();
        doc_iner.LoadXml(Xml.OuterXml);

        Decimal aud_id = XmlAudit(Xml);

        XmlNode reference = doc_iner.SelectSingleNode("/PayordRemoveRequest/REF");
        Decimal? ref_ = Convert.ToDecimal(reference.InnerText);

        XmlDocument doc = new XmlDocument();
        XmlElement root = doc.CreateElement("PayordRemoveResponse");
        doc.AppendChild(root);

        XmlElement refer = doc.CreateElement("REF");
        root.AppendChild(refer);

        try
        {
            cmd.CommandText = "bars_dbo.payordremove";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, ref_, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_errcod", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
            OracleParameter parerr = new OracleParameter("p_errmessage", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add(parerr);

            cmd.ExecuteNonQuery();

            OracleDecimal err = (OracleDecimal)cmd.Parameters["p_errcod"].Value;
            OracleString errmsg = (OracleString)cmd.Parameters["p_errmessage"].Value;

            if (err == 0)
            {
                refer.InnerText = Convert.ToString(ref_);
                UpdateAudit(aud_id, root.InnerXml);
                return doc;
            }
            else
            {
                if (err < 0)
                {
                    String message = errmsg.Value;
                    if (errmsg.Value.Length > 21)
                    {
                        message = message.Substring(11);
                        int idx = message.IndexOf("ORA");
                        if (idx > 0)
                        {
                            message = message.Substring(0, idx - 1);
                        }
                        root.InnerXml = "<Error><ErrCode>-1</ErrCode><ErrMessage>" + message + "</ErrMessage></Error>";
                        UpdateAudit(aud_id, root.InnerXml);
                    }
                    else
                    {
                        root.InnerXml = errmsg.Value;
                        UpdateAudit(aud_id, root.InnerXml);
                    }
                }
                else
                {
                    String errorCode = String.Format("UPB-{0:000000}", err.Value);
                    root.InnerXml = "<Error><ErrCode>-1</ErrCode><ErrMessage>" + errorCode + " " + Convert.ToString(errmsg) + "</ErrMessage></Error>";
                    UpdateAudit(aud_id, root.InnerXml);
                }
                return doc;
            }
        }
        catch (OracleException e)
        {
            root.InnerXml += ProcessingLine(e.Message);
            UpdateAudit(aud_id, root.InnerXml);
            return doc;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    public XmlNode processErr(OracleException e, String r)
    {
        XmlDocument doc = new XmlDocument();
        
        XmlElement root = doc.CreateElement(r);
        doc.AppendChild(root);

        XmlElement err = doc.CreateElement("Error");
        root.AppendChild(err);

        XmlElement errCode = doc.CreateElement("ErrCode");
        err.AppendChild(errCode);
        
        errCode.InnerText = Convert.ToString(e.ErrorCode);

        XmlElement errMsg = doc.CreateElement("ErrMessage");
        err.AppendChild(errMsg);

        errMsg.InnerText = ParseError(e.Message);

        return doc;
    }

    public XmlNode processNotRequest(XmlNode Xml)
    {
        XmlDocument doc = new XmlDocument();
        XmlElement root = doc.CreateElement("UnsupportedRequest");
        doc.AppendChild(root);

        XmlElement err = doc.CreateElement("Error");
        root.AppendChild(err);

        err.InnerText = "Запрос " + Xml.Name + " не найден";

        return doc;
    }

    public String ProcessingLine(String str)
    {
        String message = str;
        if (str.Length > 21)
        {
            message = message.Substring(21);
            int idx = message.IndexOf("ORA");
            if (idx > 0)
            {
                message = message.Substring(0, idx - 1);
            }

            Regex pat = new Regex(@"UPB-\d*");
            Match errcode = pat.Match(str);

            return "<Error><ErrCode>-1</ErrCode><ErrMessage>" + errcode.Value + " " + message + "</ErrMessage></Error>";
        }
        else
        {
            return str;
        }
    }

    public String ParseError(String str)
    {
        String message = str;
        if (str.Length > 21)
        {
            //int idx = message.IndexOf("UPB");
            message = message.Substring(21);
            int idx = message.IndexOf("ORA");
            if (idx > 0)
            {
                message = message.Substring(0, idx - 1);
            }

            Regex pat = new Regex(@"UPB-\d*");
            Match errcode = pat.Match(str);

            return errcode.Value + " " + message;
        }
        else
        {
            return str;
        }
    }
    static Decimal XmlAudit(XmlNode Xml)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        cmd.CommandText = "bars_dbo.set_audit_xml";
        cmd.Parameters.Add("p_inner_xml", OracleDbType.Clob, Xml.OuterXml, System.Data.ParameterDirection.Input);
        cmd.Parameters.Add("p_id", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
        cmd.ExecuteNonQuery();

        return Convert.ToDecimal(cmd.Parameters["p_id"].Value.ToString());

        con.Close();
        con.Dispose();
    }

    static Decimal SoapAudit(String Soap)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        cmd.CommandText = "bars_dbo.set_audit_xml";
        cmd.Parameters.Add("p_inner_xml", OracleDbType.Clob, Soap, System.Data.ParameterDirection.Input);
        cmd.Parameters.Add("p_id", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
        cmd.ExecuteNonQuery();

        return Convert.ToDecimal(cmd.Parameters["p_id"].Value.ToString());

        con.Close();
        con.Dispose();

    }
    static void UpdateAudit(Decimal id, String OutStr)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        cmd.CommandText = "bars_dbo.upd_audit_xml";
        cmd.Parameters.Add("p_id", OracleDbType.Decimal, id, System.Data.ParameterDirection.Input);
        cmd.Parameters.Add("p_outer_xml", OracleDbType.Clob, OutStr, System.Data.ParameterDirection.Input);
        cmd.ExecuteNonQuery();

        con.Close();
        con.Dispose();
    }
}
