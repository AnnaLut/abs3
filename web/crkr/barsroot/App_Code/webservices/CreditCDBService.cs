using System;
using System.Collections.Generic;
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
using Oracle.DataAccess.Types;

/// <summary>
/// Веб-сервіс для біржових операцій
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class CreditCDBService : BarsWebService
{
    public WsHeader WsHeaderValue;

    #region private методы
    private void LoginUser(String _userName)
    {
        // Інформація про поточного користувача
        UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(_userName);

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

    private ResponseClaimId PrepareResponse(OracleCommand _command)
    {
        string errorMessage = OracleHelper.GetParameterString(_command, "p_error_message");

        if (String.IsNullOrEmpty(errorMessage))
        {
            int? cdbClaimId = OracleHelper.GetParameterInt(_command, "p_cdb_claim_id");

            if (cdbClaimId != null)
                return new ResponseClaimId() { CdbClaimId = cdbClaimId.Value };

            return new ResponseClaimId() { ErrorMessage = "Ідентифікатор нової заявки не переданий у вихідний параметр PL/SQL-процедури" };
        }

        return new ResponseClaimId() { ErrorMessage = errorMessage };
    }

    private ResponseClaimId WsMethodImplementation(string _procedureName, params OracleParameter[] _parameters)
    {
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(WsHeaderValue.UserName, WsHeaderValue.Password, true);

        if (isAuthenticated)
            LoginUser(WsHeaderValue.UserName);

        OracleConnection con = OraConnector.Handler.UserConnection;
        try
        {
            OracleCommand cmd = new OracleCommand(_procedureName, con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddRange(_parameters);
            
            cmd.Parameters.Add("p_cdb_claim_id", OracleDbType.Int32, ParameterDirection.Output);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, "", ParameterDirection.Output);
            
            cmd.ExecuteNonQuery();

            return PrepareResponse(cmd);
        }
        catch (Exception e)
        {
            return new ResponseClaimId { ErrorMessage = e.Message + "\n" + e.StackTrace };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    #endregion

    #region методы веб-сервиса

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public ResponseClaimId CreateNewDeal(string DealNumber, string LenderMfo, string BorrowerMfo, string OpenDate, string ExpiryDate, 
                                        string Amount, string CurrencyId, string InterestRate, string BaseYear, string AllegroComment, 
                                        string AllegroClaimId)
    {
        return WsMethodImplementation("cdb.cdb_allegro.create_new_deal",
            new OracleParameter("p_deal_number", OracleDbType.Varchar2, DealNumber, ParameterDirection.Input),
            new OracleParameter("p_lender_mfo", OracleDbType.Varchar2, LenderMfo, ParameterDirection.Input),
            new OracleParameter("p_borrower_mfo", OracleDbType.Varchar2, BorrowerMfo, ParameterDirection.Input),
            new OracleParameter("p_open_date", OracleDbType.Date, WsFormatHelper.GetDateTime(OpenDate), ParameterDirection.Input),
            new OracleParameter("p_expiry_date", OracleDbType.Date, WsFormatHelper.GetDateTime(ExpiryDate), ParameterDirection.Input),
            new OracleParameter("p_amount", OracleDbType.Decimal, WsFormatHelper.GetDecimal(Amount, false, 2), ParameterDirection.Input),
            new OracleParameter("p_currency_id", OracleDbType.Int16, WsFormatHelper.GetInt(CurrencyId, false), ParameterDirection.Input),
            new OracleParameter("p_interest_rate", OracleDbType.Decimal, WsFormatHelper.GetDecimal(InterestRate, false, 12), ParameterDirection.Input),
            new OracleParameter("p_base_year", OracleDbType.Int16, WsFormatHelper.GetInt(BaseYear, false), ParameterDirection.Input),
            new OracleParameter("p_allegro_comment", OracleDbType.Varchar2, AllegroComment, ParameterDirection.Input),
            new OracleParameter("p_allegro_claim_id", OracleDbType.Varchar2, AllegroClaimId, ParameterDirection.Input));
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public ResponseClaimId ChangeDealAmount(string DealNumber, string CurrencyId, string AmountDelta, string AllegroComment, string AllegroClaimId)
    {
        return WsMethodImplementation("cdb.cdb_allegro.change_deal_amount",
            new OracleParameter("p_deal_number", OracleDbType.Varchar2, DealNumber, ParameterDirection.Input),
            new OracleParameter("p_currency_id", OracleDbType.Int16, WsFormatHelper.GetInt(CurrencyId, false), ParameterDirection.Input),
            new OracleParameter("p_amount_delta", OracleDbType.Decimal, WsFormatHelper.GetDecimal(AmountDelta, false, 2), ParameterDirection.Input),
            new OracleParameter("p_allegro_comment", OracleDbType.Varchar2, AllegroComment, ParameterDirection.Input),
            new OracleParameter("p_allegro_claim_id", OracleDbType.Varchar2, AllegroClaimId, ParameterDirection.Input));
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public ResponseClaimId SetInterestRate(string DealNumber, string CurrencyId, string RateDate, string RateValue, string AllegroComment, string AllegroClaimId)
    {
        return WsMethodImplementation("cdb.cdb_allegro.set_interest_rate",
            new OracleParameter("p_deal_number", OracleDbType.Varchar2, DealNumber, ParameterDirection.Input),
            new OracleParameter("p_currency_id", OracleDbType.Int16, WsFormatHelper.GetInt(CurrencyId, false), ParameterDirection.Input),
            new OracleParameter("p_rate_date", OracleDbType.Date, WsFormatHelper.GetDateTime(RateDate), ParameterDirection.Input),
            new OracleParameter("p_rate_value", OracleDbType.Decimal, WsFormatHelper.GetDecimal(RateValue, false, 12), ParameterDirection.Input),
            new OracleParameter("p_allegro_comment", OracleDbType.Varchar2, AllegroComment, ParameterDirection.Input),
            new OracleParameter("p_allegro_claim_id", OracleDbType.Varchar2, AllegroClaimId, ParameterDirection.Input));
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public ResponseClaimId SetExpiryDate(string DealNumber, string CurrencyId, string ExpiryDate, string AllegroComment, string AllegroClaimId)
    {
        return WsMethodImplementation("cdb.cdb_allegro.set_expiry_date",
            new OracleParameter("p_deal_number", OracleDbType.Varchar2, DealNumber, ParameterDirection.Input),
            new OracleParameter("p_currency_id", OracleDbType.Int16, WsFormatHelper.GetInt(CurrencyId, false), ParameterDirection.Input),
            new OracleParameter("p_rate_date", OracleDbType.Date, WsFormatHelper.GetDateTime(ExpiryDate), ParameterDirection.Input),
            new OracleParameter("p_allegro_comment", OracleDbType.Varchar2, AllegroComment, ParameterDirection.Input),
            new OracleParameter("p_allegro_claim_id", OracleDbType.Varchar2, AllegroClaimId, ParameterDirection.Input));
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public ResponseClaimId CloseDeal(string DealNumber, string CurrencyId, string CloseDate, string AllegroComment, string AllegroClaimId)
    {
        return WsMethodImplementation("cdb.cdb_allegro.close_deal",
            new OracleParameter("p_deal_number", OracleDbType.Varchar2, DealNumber, ParameterDirection.Input),
            new OracleParameter("p_currency_id", OracleDbType.Int16, WsFormatHelper.GetInt(CurrencyId, false), ParameterDirection.Input),
            new OracleParameter("p_close_date", OracleDbType.Date, WsFormatHelper.GetDateTime(CloseDate), ParameterDirection.Input),
            new OracleParameter("p_allegro_comment", OracleDbType.Varchar2, AllegroComment, ParameterDirection.Input),
            new OracleParameter("p_allegro_claim_id", OracleDbType.Varchar2, AllegroClaimId, ParameterDirection.Input));
    }

    [WebMethod(EnableSession = true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public ResponseClaimState GetClaimState(string AllegroClaimId)
    {
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(WsHeaderValue.UserName, WsHeaderValue.Password, true);
        if (isAuthenticated)
            LoginUser(WsHeaderValue.UserName);

        OracleConnection con = OraConnector.Handler.UserConnection;
        try
        {
            OracleCommand cmd = new OracleCommand("cdb.cdb_allegro.get_claim_state", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("p_allegro_claim_id", OracleDbType.Varchar2, AllegroClaimId, ParameterDirection.Input);
            cmd.Parameters.Add("p_claim_state_code", OracleDbType.Varchar2, 30, "", ParameterDirection.Output);
            cmd.Parameters.Add("p_error_message", OracleDbType.Varchar2, 4000, "", ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            string errorMessage = OracleHelper.GetParameterString(cmd, "p_error_message");

            if (String.IsNullOrEmpty(errorMessage))
                return new ResponseClaimState { ClaimStateCode = OracleHelper.GetParameterString(cmd, "p_claim_state_code") };
            else
                return new ResponseClaimState() { ErrorMessage = errorMessage };
        }
        catch (Exception e)
        {
            return new ResponseClaimState { ErrorMessage = e.Message + e.StackTrace };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    [WebMethod(EnableSession=true)]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public NewDealClaimsData GetNewDealClaimsReport(string DateFrom, string DateTo)
    {
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(WsHeaderValue.UserName, WsHeaderValue.Password, true);
        if (isAuthenticated)
            LoginUser(WsHeaderValue.UserName);

        DateTime dateFrom = String.IsNullOrEmpty(DateFrom) ? DateTime.Today : DateTime.ParseExact(DateFrom, "dd.MM.yyyy", CultureInfo.InvariantCulture);
        DateTime dateTo = String.IsNullOrEmpty(DateTo) ? DateTime.Today : DateTime.ParseExact(DateTo, "dd.MM.yyyy", CultureInfo.InvariantCulture);

        OracleConnection con = OraConnector.Handler.UserConnection;
        try
        {
            NewDealClaimData[] claims = new NewDealClaimData[100];
            OracleCommand cmd = new OracleCommand("select * from v_cdb_new_deal_claim t where t.sys_time >= :p_date_from and t.sys_time < :p_date_to", con);
            cmd.Parameters.Add("p_date_from", OracleDbType.Date, dateFrom, ParameterDirection.Input);
            cmd.Parameters.Add("p_date_to", OracleDbType.Date, dateTo.AddDays(1), ParameterDirection.Input);
            OracleDataReader reader = cmd.ExecuteReader();

            int rowCounter = 0;
            if (reader.HasRows)
            {
                int idFieldId = reader.GetOrdinal("id");
                int dealNumberFieldId = reader.GetOrdinal("deal_number");
                int openDateFieldId = reader.GetOrdinal("open_date");
                int expiryDateFieldId = reader.GetOrdinal("expiry_date");
                int lenderCodeFieldId = reader.GetOrdinal("lender_code");
                int borrowerCodeFieldId = reader.GetOrdinal("borrower_code");
                int lenderNameFieldId = reader.GetOrdinal("lender_name");
                int borrowerNameFieldId = reader.GetOrdinal("borrower_name");
                int amountFieldId = reader.GetOrdinal("amount");
                int currencyIdFieldId = reader.GetOrdinal("currency_id");
                int interestRateFieldId = reader.GetOrdinal("interest_rate");
                int interestCalendarFieldId = reader.GetOrdinal("interest_calendar");
                int allegroCommentFieldId = reader.GetOrdinal("allegro_comment");
                int allegroClaimIdFieldId = reader.GetOrdinal("allegro_claim_id");
                int creationTimeFieldId = reader.GetOrdinal("sys_time");
                int claimStateFieldId = reader.GetOrdinal("claim_state");

                while (reader.Read())
                {
                    NewDealClaimData claimData = new NewDealClaimData();
                    claimData.Id = OracleHelper.GetIntString(reader, idFieldId);
                    claimData.DealNumber = OracleHelper.GetString(reader, dealNumberFieldId);
                    claimData.OpenDate = OracleHelper.GetDateTimeString(reader, openDateFieldId, "dd.MM.yyyy");
                    claimData.ExpiryDate = OracleHelper.GetDateTimeString(reader, expiryDateFieldId, "dd.MM.yyyy");
                    claimData.LenderMfo = OracleHelper.GetString(reader, lenderCodeFieldId);
                    claimData.LenderName = OracleHelper.GetString(reader, lenderNameFieldId);
                    claimData.BorrowerMfo = OracleHelper.GetString(reader, borrowerCodeFieldId);
                    claimData.BorrowerName = OracleHelper.GetString(reader, borrowerNameFieldId);
                    claimData.Amount = OracleHelper.GetDecimalString(reader, amountFieldId, "0.00");
                    claimData.Currencyid = OracleHelper.GetIntString(reader, currencyIdFieldId);
                    claimData.InterestRate = OracleHelper.GetDecimalString(reader, interestRateFieldId, "0.0000");
                    claimData.InterestCalendar = OracleHelper.GetString(reader, interestCalendarFieldId);
                    claimData.AllegroComment = OracleHelper.GetString(reader, allegroCommentFieldId);
                    claimData.AllegroClaimId = OracleHelper.GetString(reader, allegroClaimIdFieldId);
                    claimData.CreationTime = OracleHelper.GetDateTimeString(reader, creationTimeFieldId, "dd.MM.yyyy HH:mm:ss");
                    claimData.ClaimState = OracleHelper.GetString(reader, claimStateFieldId);

                    claims[rowCounter++] = claimData;
                    if (rowCounter % 100 == 0)
                        Array.Resize(ref claims, rowCounter + 100);
                }
            }
            Array.Resize(ref claims, rowCounter);

            return new NewDealClaimsData() { NewDealClaims = claims };
        }
        catch (Exception ex)
        {
            return new NewDealClaimsData() { ErrorMessage = ex.Message + "\n" + ex.StackTrace };
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    #endregion

    #region вспомогательные классы
    
    public class ResponseClaimId
    {
        public int CdbClaimId { get; set; }
        public string ErrorMessage { get; set; }
    }

    public class ResponseClaimState
    {
        public string ClaimStateCode { get; set; }
        public string ErrorMessage { get; set; }
    }

    public class NewDealClaimData
    {
        public string Id { get; set; }
        public string DealNumber { get; set; }
        public string OpenDate { get; set; }
        public string ExpiryDate { get; set; }
        public string LenderMfo { get; set; }
        public string LenderName { get; set; }
        public string BorrowerMfo { get; set; }
        public string BorrowerName { get; set; }
        public string Amount { get; set; }
        public string Currencyid { get; set; }
        public string InterestRate { get; set; }
        public string InterestCalendar { get; set; }
        public string AllegroComment { get; set; }
        public string AllegroClaimId { get; set; }
        public string ClaimState { get; set; }
        public string CreationTime { get; set; }
    }

    public class NewDealClaimsData
    {
        public NewDealClaimData[] NewDealClaims { get; set; }
        public string ErrorMessage { get; set; }
    }

    private static class OracleHelper
    {
        public static string GetString(OracleDataReader _reader, int _fieldId)
        {
            return _reader.IsDBNull(_fieldId) ? null : _reader.GetString(_fieldId);
        }
        
        public static string GetIntString(OracleDataReader _reader, int _fieldId)
        {
            return _reader.IsDBNull(_fieldId) ? null : _reader.GetInt32(_fieldId).ToString();
        }

        public static string GetDateTimeString(OracleDataReader _reader, int _fieldId, string _dateFormat)
        {
            return _reader.IsDBNull(_fieldId) ? null : _reader.GetDateTime(_fieldId).ToString(_dateFormat);
        }

        public static string GetDecimalString(OracleDataReader _reader, int _fieldId, string _decimalFormat)
        {
            return _reader.IsDBNull(_fieldId) ? null : _reader.GetDecimal(_fieldId).ToString(_decimalFormat);
        }

        private static OracleParameter GetParameter(OracleCommand _command, string _parameterName)
        {
            OracleParameter parameter = _command.Parameters[_parameterName];
            if (parameter == null)
                throw new KeyNotFoundException(String.Format("Parameter with name '{0}' not found", _parameterName));

            return parameter;
        }

        public static string GetParameterString(OracleCommand _command, string _parameterName)
        {
            OracleString oracleString = (OracleString)GetParameter(_command, _parameterName).Value;

            return oracleString == null ? null : oracleString.Value;
        }

        public static int? GetParameterInt(OracleCommand _command, string _parameterName)
        {
            OracleDecimal oracleDecimal = (OracleDecimal)GetParameter(_command, _parameterName).Value;

            return oracleDecimal.IsNull ? null : (int?)oracleDecimal.Value;
        }

        public static decimal? GetParameterDecimal(OracleCommand _command, string _parameterName)
        {
            OracleDecimal oracleDecimal = (OracleDecimal)GetParameter(_command, _parameterName).Value;

            return oracleDecimal.IsNull ? null : (decimal?)oracleDecimal.Value;
        }
    }

    private static class WsFormatHelper
    {
        public static DateTime? GetDateTime(string _dateTimeString)
        {
            return String.IsNullOrEmpty(_dateTimeString) ? null : (DateTime?)DateTime.ParseExact(_dateTimeString, "dd.MM.yyyy", CultureInfo.InvariantCulture);
        }

        public static int? GetInt(string _intString, bool _allowNegative)
        {
            return String.IsNullOrEmpty(_intString) ? null : (int?)Int32.Parse(_intString, _allowNegative ? NumberStyles.AllowLeadingSign : NumberStyles.None);
        }

        private static decimal? getDecimal(string _decimalString, bool? _allowNegative, short? _decimalPoint)
        {
            if (String.IsNullOrEmpty(_decimalString))
                return null;

            NumberStyles numberStyles = NumberStyles.AllowDecimalPoint;

            if (_allowNegative == null || _allowNegative.Value) // allowed by default
                numberStyles = numberStyles | NumberStyles.AllowLeadingSign;

            decimal decimalValue = Decimal.Parse(_decimalString, numberStyles);

            return _decimalPoint == null ? decimalValue : Math.Round(decimalValue, _decimalPoint.Value);
        }

        public static decimal? GetDecimal(string _decimalString, bool _allowNegative, short _decimalPoint)
        {
            return getDecimal(_decimalString, _allowNegative, _decimalPoint);
        }

        public static decimal? GetDecimal(string _decimalString, bool _allowNegative)
        {
            return getDecimal(_decimalString, _allowNegative, null);
        }

        public static decimal? GetDecimal(string _decimalString, short _decimalPoint)
        {
            return getDecimal(_decimalString, null, _decimalPoint);
        }

        public static decimal? GetDecimal(string _decimalString)
        {
            return getDecimal(_decimalString, null, null);
        }
    }

    #endregion
}

