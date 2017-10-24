using System;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using Bars.Oracle;
using Bars.Application;
using Bars.WebServices;
using barsroot.core;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

/// <summary>
/// Summary description for DboService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class CreditResourceService : Bars.BarsWebService
{
    public WsHeader WsHeaderValue;

    public class Errors
    {
        public string ErrMessage;
    }

    public class Deal
    {
        public int DealId { get; set; }
        public int MainAccountId { get; set; }
        public int InterestAccountId { get; set; }
    }

    public class AccountNumber
    {
        public String AccountNumberValue { get; set; }
    }

    public class Amount
    {
        public decimal AmountValue { get; set; }
    }

    public class Date
    {
        public DateTime DateValue { get; set; }
    }

    public class DocumentId
    {
        public int DocumentIdValue { get; set; }
    }

    public class DealContract
    { 
        public Deal Deal = new Deal();
        public Errors Error = new Errors();
    }

    public class AccountNumberContract
    {
        public AccountNumber AccountNumber = new AccountNumber();
        public Errors Error = new Errors();
    }

    public class AmountContract
    {
        public Amount Amount = new Amount();
        public Errors Error = new Errors();
    }

    public class DateContract
    {
        public Date Date = new Date();
        public Errors Error = new Errors();
    }

    public class DocumentIdContract
    {
        public DocumentId Document = new DocumentId();
        public Errors Error = new Errors();
    }

    private string GetHostName()
    {
        string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", StringComparison.OrdinalIgnoreCase) == 0)
            userHost = HttpContext.Current.Request.UserHostAddress;

        if (String.CompareOrdinal(userHost, HttpContext.Current.Request.UserHostName) != 0)
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
    
    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public DealContract OpenCreditContract(String ContractNumber, int ProductId, int ContractType, int CurrencyCode, int PartyId, String PartyMfo, String PartyName, DateTime? ContractDate, DateTime? ExpiryDate, Decimal InterestRate, Decimal Amount, int BaseYear, int BalanceKind, String MainDebtAccount, String InterestAccount, String PartyMainDebtAccount, String TransitAccount, String PartyInterestAccount, String PaymentPurpose)
    {
        DealContract dealContract = new DealContract();
        Deal deal = new Deal();
        Errors err = new Errors();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);

        OracleCommand cmd = new OracleCommand("bars.cdb_mediator.open_credit_contract", con) {CommandType = CommandType.StoredProcedure};
        try
        {
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_contract_number", OracleDbType.Varchar2, ContractNumber, ParameterDirection.Input);
            cmd.Parameters.Add("p_product_id", OracleDbType.Int32, ProductId, ParameterDirection.Input);
            cmd.Parameters.Add("p_contract_type", OracleDbType.Int32, ContractType, ParameterDirection.Input);
            cmd.Parameters.Add("p_currency_code", OracleDbType.Int32, CurrencyCode, ParameterDirection.Input);
            cmd.Parameters.Add("p_party_id", OracleDbType.Int32, PartyId, ParameterDirection.Input);
            cmd.Parameters.Add("p_party_mfo", OracleDbType.Varchar2, PartyMfo, ParameterDirection.Input);
            cmd.Parameters.Add("p_party_name", OracleDbType.Varchar2, PartyName, ParameterDirection.Input);
            cmd.Parameters.Add("p_contract_date", OracleDbType.Date, ContractDate, ParameterDirection.Input);
            cmd.Parameters.Add("p_expiry_date", OracleDbType.Date, ExpiryDate, ParameterDirection.Input);
            cmd.Parameters.Add("p_interest_rate", OracleDbType.Decimal, InterestRate, ParameterDirection.Input);
            cmd.Parameters.Add("p_amount", OracleDbType.Decimal, Amount, ParameterDirection.Input);
            cmd.Parameters.Add("p_base_year", OracleDbType.Int32, BaseYear, ParameterDirection.Input);
            cmd.Parameters.Add("p_balance_kind", OracleDbType.Int32, BalanceKind, ParameterDirection.Input);
            cmd.Parameters.Add("p_main_debt_account", OracleDbType.Varchar2, MainDebtAccount, ParameterDirection.Input);
            cmd.Parameters.Add("p_interest_account", OracleDbType.Varchar2, InterestAccount, ParameterDirection.Input);
            cmd.Parameters.Add("p_party_main_debt_account", OracleDbType.Varchar2, PartyMainDebtAccount, ParameterDirection.Input);
            cmd.Parameters.Add("p_party_interest_account", OracleDbType.Varchar2, PartyInterestAccount, ParameterDirection.Input);
            cmd.Parameters.Add("p_transit_account", OracleDbType.Varchar2, TransitAccount, ParameterDirection.Input);
            cmd.Parameters.Add("p_payment_purpose", OracleDbType.Varchar2, PaymentPurpose, ParameterDirection.Input);
            cmd.Parameters.Add("p_deal_id", OracleDbType.Int32, ParameterDirection.Output);
            cmd.Parameters.Add("p_main_account_id", OracleDbType.Int32, ParameterDirection.Output);
            cmd.Parameters.Add("p_interest_account_id", OracleDbType.Int32, ParameterDirection.Output);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, err.ErrMessage, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            int dealId = (int)((OracleDecimal)cmd.Parameters["p_deal_id"].Value).Value;
            int mainAccountId = (int)((OracleDecimal)cmd.Parameters["p_main_account_id"].Value).Value;
            int interestAccountId = (int)((OracleDecimal)cmd.Parameters["p_interest_account_id"].Value).Value;
            OracleString errorMesage = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (dealId != 0 && mainAccountId != 0 && interestAccountId != 0)
            {
                deal.DealId = dealId;
                deal.MainAccountId = mainAccountId;
                deal.InterestAccountId = interestAccountId;

                dealContract.Deal = deal;
                return dealContract;
            }
            else
            {
                err.ErrMessage = ((OracleString)errorMesage).Value;

                dealContract.Error = err;
                return dealContract;
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public AccountNumberContract GenerateAccountNumbers(int OurCustomerId, String BalanceAccount, int CurrencyCode)
    {
        AccountNumberContract accountNumberContract = new AccountNumberContract();
        AccountNumber accountNumber = new AccountNumber();
        Errors error = new Errors();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        try
        {
            string errorMessage = "";
            cmd.CommandText = "bars.CDB_MEDIATOR.generate_account_numbers";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_our_customer_id", OracleDbType.Int32, OurCustomerId, ParameterDirection.Input);
            cmd.Parameters.Add("p_balance_account", OracleDbType.Varchar2, BalanceAccount, ParameterDirection.Input);
            cmd.Parameters.Add("p_currency_code", OracleDbType.Int32, CurrencyCode, ParameterDirection.Input);
            cmd.Parameters.Add("p_account_numbers", OracleDbType.Varchar2, 4000, accountNumber.AccountNumberValue, ParameterDirection.Output);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, errorMessage, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString errorMesageParam = (OracleString)cmd.Parameters["p_error_message"].Value;
            if (errorMesageParam != null)
                errorMessage = errorMesageParam.Value;


            if (String.IsNullOrEmpty(errorMessage))
            {
                String accountNumbers = ((OracleString)cmd.Parameters["p_account_numbers"].Value).Value;
                accountNumber.AccountNumberValue = accountNumbers;

                accountNumberContract.AccountNumber = accountNumber;
                return accountNumberContract;
            }
            else
            {
                error.ErrMessage = errorMesageParam.Value;

                accountNumberContract.Error = error;
                return accountNumberContract;
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public DocumentIdContract MakeDocument(int DealId, String OperationType, int PartyA, int PartyB, String MfoA, String MfoB, String AccountA, String AccountB, int DocumentKindId, DateTime? DocumentDate, Decimal Amount, int Currency, String Purpose)
    {
        DocumentId doc = new DocumentId();
        Errors err = new Errors();
        DocumentIdContract mdoc = new DocumentIdContract();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        try
        {
            cmd.CommandText = "bars.CDB_MEDIATOR.make_document";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_deal_id", OracleDbType.Int32, DealId, ParameterDirection.Input);
            cmd.Parameters.Add("p_operation_type", OracleDbType.Varchar2, OperationType, ParameterDirection.Input);
            cmd.Parameters.Add("p_party_a", OracleDbType.Int32, PartyA, ParameterDirection.Input);
            cmd.Parameters.Add("p_party_b", OracleDbType.Int32, PartyB, ParameterDirection.Input);
            cmd.Parameters.Add("p_mfo_a", OracleDbType.Varchar2, MfoA, ParameterDirection.Input);
            cmd.Parameters.Add("p_mfo_b", OracleDbType.Varchar2, MfoB, ParameterDirection.Input);
            cmd.Parameters.Add("p_account_a", OracleDbType.Varchar2, AccountA, ParameterDirection.Input);
            cmd.Parameters.Add("p_account_b", OracleDbType.Varchar2, AccountB, ParameterDirection.Input);
            cmd.Parameters.Add("p_document_kind_id", OracleDbType.Int32, DocumentKindId, ParameterDirection.Input);
            cmd.Parameters.Add("p_document_date", OracleDbType.Date, DocumentDate, ParameterDirection.Input);
            cmd.Parameters.Add("p_amount", OracleDbType.Decimal, Amount, ParameterDirection.Input);
            cmd.Parameters.Add("p_currency", OracleDbType.Int32, Currency, ParameterDirection.Input);
            cmd.Parameters.Add("p_purpose", OracleDbType.Varchar2, Purpose, ParameterDirection.Input);
            cmd.Parameters.Add("p_operation_id", OracleDbType.Int32, ParameterDirection.Output);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            int operationId = (int)((OracleDecimal)cmd.Parameters["p_operation_id"].Value).Value;
            OracleString errorMesage = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (operationId > 0)
            {
                doc.DocumentIdValue = operationId;

                mdoc.Document = doc;
                return mdoc;
            }
            else
            {
                err.ErrMessage = errorMesage.Value;

                mdoc.Error = err;
                return mdoc;
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public AmountContract GetAccountRest(String AccountNumber, int CurrencyCode)
    {
        AmountContract accountRests = new AmountContract();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        try
        {
            string errorMessage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.get_account_rest";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_account_number", OracleDbType.Varchar2, 4000, AccountNumber, ParameterDirection.Input);
            cmd.Parameters.Add("p_currency_code", OracleDbType.Int16, CurrencyCode, ParameterDirection.Input);
            cmd.Parameters.Add("p_account_rest", OracleDbType.Decimal, ParameterDirection.Output);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString _errorMessage = (OracleString) cmd.Parameters["p_error_message"].Value;

            if (_errorMessage != null)
                errorMessage = _errorMessage.Value;

            if (String.IsNullOrEmpty(errorMessage))
            {
                decimal accountRest = ((OracleDecimal)cmd.Parameters["p_account_rest"].Value).Value;
                accountRests.Amount = new Amount() { AmountValue = accountRest };
            }
            else
            {
                accountRests.Error = new Errors() { ErrMessage = errorMessage };
            }
            
            return accountRests;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public AmountContract GetDealAmount(int DealId)
    {
        AmountContract amountContract = new AmountContract();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.get_deal_amount";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_deal_id", OracleDbType.Int32, DealId, ParameterDirection.Input);
            cmd.Parameters.Add("p_deal_amount", OracleDbType.Decimal, ParameterDirection.Output);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString errorMessageParam = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (errorMessageParam != null)
                errorMesage = errorMessageParam.Value;

            if (String.IsNullOrEmpty(errorMesage))
            {
                decimal dealAmount = ((OracleDecimal)cmd.Parameters["p_deal_amount"].Value).Value;
                amountContract.Amount = new Amount() { AmountValue = dealAmount };
            }
            else
            {
                amountContract.Error = new Errors() { ErrMessage = errorMesage };
            }

            return amountContract;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public DateContract GetDealExpiryDate(int DealId)
    {
        DateContract dateContract = new DateContract();

        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.get_deal_expiry_date";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_deal_id", OracleDbType.Int32, DealId, ParameterDirection.Input);
            cmd.Parameters.Add("p_deal_expiry_date", OracleDbType.Date, ParameterDirection.Output);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, ParameterDirection.Output);
            try
            {
                cmd.ExecuteNonQuery();

                OracleString errorMessageParam = (OracleString) cmd.Parameters["p_error_message"].Value;

                if (errorMessageParam != null)
                    errorMesage = errorMessageParam.Value;

                if (String.IsNullOrEmpty(errorMesage))
                {
                    if (cmd.Parameters["p_deal_expiry_date"] != null)
                    {
                        dateContract.Date.DateValue = ((OracleDate)cmd.Parameters["p_deal_expiry_date"].Value).Value;
                    }
                    else
                    {
                        dateContract.Error = new Errors() { ErrMessage = "Deal expiry date not set" };
                    }
                }
                else
                {
                    dateContract.Error = new Errors() { ErrMessage = errorMesage };
                }
            }
            catch (Exception ex)
            {
                dateContract.Error = new Errors() { ErrMessage = ex.Message + "\n" + ex.StackTrace };
            }
            return dateContract;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Errors SetDealAmount(int DealId, decimal DealAmount)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.set_deal_amount";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_deal_id", OracleDbType.Int32, DealId, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_deal_amount", OracleDbType.Decimal, DealAmount, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, errorMesage, System.Data.ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString errorMessageParam = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (errorMessageParam != null)
                errorMesage = errorMessageParam.Value;

            return new Errors() { ErrMessage = errorMesage };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Errors SetDealInterestRate(string AccountNumber, int CurrencyCode, int RateKind, DateTime RateDate, decimal RateValue)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.set_interest_rate";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_account_number", OracleDbType.Decimal, AccountNumber, ParameterDirection.Input);
            cmd.Parameters.Add("p_currency_code", OracleDbType.Decimal, CurrencyCode, ParameterDirection.Input);
            cmd.Parameters.Add("p_rate_kind", OracleDbType.Int16, RateKind, ParameterDirection.Input);
            cmd.Parameters.Add("p_rate_date", OracleDbType.Date, RateDate, ParameterDirection.Input);
            cmd.Parameters.Add("p_rate_value", OracleDbType.Decimal, RateValue, ParameterDirection.Input);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString errorMessageParam = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (errorMessageParam != null)
                errorMesage = errorMessageParam.Value;

            return new Errors() { ErrMessage = errorMesage };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Errors SetDealExpiryDate(int DealId, DateTime ExpiryDate)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.set_deal_expiry_date";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_deal_id", OracleDbType.Int32, DealId, ParameterDirection.Input);
            cmd.Parameters.Add("p_expiry_date", OracleDbType.Date, ExpiryDate, ParameterDirection.Input);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString errorMessageParam = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (errorMessageParam != null)
                errorMesage = errorMessageParam.Value;

            return new Errors() { ErrMessage = errorMesage };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Errors CheckDealBeforeClose(int DealId)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.check_deal_before_close";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_deal_id", OracleDbType.Int32, DealId, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, errorMesage, System.Data.ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString oracleErrorMessage = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (oracleErrorMessage != null)
                errorMesage = oracleErrorMessage.Value;

            return new Errors() { ErrMessage = errorMesage };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Errors CheckAccountBeforeClose(string AccountNumber, int CurrencyCode)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.check_account_before_close";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_account_number", OracleDbType.Varchar2, 14, AccountNumber, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_currency_code", OracleDbType.Int32, CurrencyCode, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, errorMesage, System.Data.ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString oracleErrorMessage = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (oracleErrorMessage != null)
                errorMesage = oracleErrorMessage.Value;

            return new Errors() { ErrMessage = errorMesage };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Errors CheckDealInterestRate(int DealId, int InterestKind, string InterestRates)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.check_deal_interest_rates";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_deal_id", OracleDbType.Int32, DealId, ParameterDirection.Input);
            cmd.Parameters.Add("p_interest_kind", OracleDbType.Int16, InterestKind, ParameterDirection.Input);
            cmd.Parameters.Add("p_interest_rates", OracleDbType.Varchar2, 4000, InterestRates, ParameterDirection.Input);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString oracleErrorMessage = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (oracleErrorMessage != null)
                errorMesage = oracleErrorMessage.Value;

            return new Errors() { ErrMessage = errorMesage };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Errors CloseAccount(string AccountNumber, int CurrencyCode, DateTime CloseDate)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.close_account";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_account_number", OracleDbType.Varchar2, 14, AccountNumber, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_currency_code", OracleDbType.Int16, CurrencyCode, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_close_date", OracleDbType.Date, CloseDate, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, errorMesage, System.Data.ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString oracleErrorMessage = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (oracleErrorMessage != null)
                errorMesage = oracleErrorMessage.Value;

            return new Errors() { ErrMessage = errorMesage };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Errors CloseDeal(int DealId, DateTime CloseDate)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.close_credit_deal";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_deal_Id", DealId);
            cmd.Parameters.Add("p_close_date", OracleDbType.Date, CloseDate, ParameterDirection.Input);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString oracleErrorMessage = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (!oracleErrorMessage.IsNull && oracleErrorMessage.Value != null)
                errorMesage = oracleErrorMessage.Value;

            return new Errors() { ErrMessage = errorMesage };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public Errors AddDealComment(int DealId, string Comment)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        try
        {
            string errorMesage = null;
            cmd.CommandText = "bars.CDB_MEDIATOR.add_deal_comment";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_deal_id", OracleDbType.Int32, DealId, ParameterDirection.Input);
            cmd.Parameters.Add("p_deal_comment", OracleDbType.Varchar2, 4000, Comment, ParameterDirection.Input);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            OracleString oracleErrorMessage = (OracleString)cmd.Parameters["p_error_message"].Value;

            if (oracleErrorMessage != null)
                errorMesage = oracleErrorMessage.Value;

            return new Errors() { ErrMessage = errorMesage };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
}
