using Bars.Classes;
using Bars.WebServices;
using BarsWeb.Areas.WebApi.Subvention.Infrastructure.DI.Abstract;
using BarsWeb.Areas.WebApi.Subvention.Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Data;
using System.Globalization;
using System.Web;

namespace BarsWeb.Areas.WebApi.Subvention.Infrastructure.DI.Implementation
{
    public class SubventionRepository : ISubventionRepository
    {
        private CultureInfo ci;
        public SubventionRepository()
        {
            ci = CultureInfo.CreateSpecificCulture("en-GB");
            ci.DateTimeFormat.ShortDatePattern = "ddMMyyyy";
            ci.DateTimeFormat.DateSeparator = "";
        }
        private void LoginUser()
        {
            string ipAddress = RequestHelpers.GetClientIpAddress(HttpContext.Current.Request);

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = "bars.bars_login.login_user";
                cmd.CommandType = CommandType.StoredProcedure;

                string ss = HttpContext.Current.Session.SessionID;

                cmd.Parameters.Add(new OracleParameter("p_session_id", OracleDbType.Varchar2, ss, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_user_id", OracleDbType.Varchar2, 1, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_hostname", OracleDbType.Varchar2, ipAddress, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input));
                cmd.ExecuteNonQuery();

                HttpContext.Current.Session["UserLoggedIn"] = true;
            }
        }

        public AccBalance GetAccBalance(string accNum, string accMfo, string _from, string _to)
        {
            LoginUser();
            DateTime from = DateTime.ParseExact(_from, "ddMMyyyy", ci);
            DateTime to = DateTime.ParseExact(_to, "ddMMyyyy", ci);

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter pAccNum = new OracleParameter("p_accnum", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                           pCurrentBalance = new OracleParameter("p_currentbalance", OracleDbType.Decimal, ParameterDirection.Output),
                           pCreditTurnOver = new OracleParameter("p_creditturnover", OracleDbType.Decimal, ParameterDirection.Output),
                                  pErrCode = new OracleParameter("p_errcode", OracleDbType.Decimal, ParameterDirection.Output),
                                   pErrMsg = new OracleParameter("p_errmsg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "bars.subsidy.getaccbalance";
                cmd.Parameters.Add(new OracleParameter("p_datefrom", OracleDbType.Date, from, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_dateto", OracleDbType.Date, to, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_nls", OracleDbType.Varchar2, accNum, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_mfo", OracleDbType.Varchar2, accMfo, ParameterDirection.Input));
                cmd.Parameters.Add(pAccNum);
                cmd.Parameters.Add(pCurrentBalance);
                cmd.Parameters.Add(pCreditTurnOver);
                cmd.Parameters.Add(pErrCode);
                cmd.Parameters.Add(pErrMsg);
                cmd.ExecuteNonQuery();

                ProcessError(pErrCode, pErrMsg);

                OracleDecimal _currentBalance = (OracleDecimal)pCurrentBalance.Value;
                OracleDecimal _creditTurnOver = (OracleDecimal)pCreditTurnOver.Value;
                OracleString _accNum = (OracleString)pAccNum.Value;

                return new AccBalance
                {
                    AccNum = _accNum.IsNull ? "" : _accNum.Value,
                    CreditTurnover = _creditTurnOver.IsNull ? 0 : Convert.ToInt64(_creditTurnOver.Value),
                    CurrentBalance = _currentBalance.IsNull ? 0 : Convert.ToInt64(_currentBalance.Value)
                };
            }
        }
        public string HouseholdPayments(HHPayments data)
        {
            LoginUser();
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter pErrCode = new OracleParameter("p_state", OracleDbType.Decimal, ParameterDirection.Output),
                                    pErrMsg = new OracleParameter("p_msg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                                    pBulkId = new OracleParameter("p_bulkid", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "bars.subsidy.HouseholdPayments";
                cmd.Parameters.Add(new OracleParameter("p_ext_id", OracleDbType.Varchar2, data.ExternalId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_request_data", OracleDbType.Clob, data.Data, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_hash", OracleDbType.Varchar2, data.Hash, ParameterDirection.Input));
                cmd.Parameters.Add(pErrCode);
                cmd.Parameters.Add(pErrMsg);
                cmd.Parameters.Add(pBulkId);
                cmd.ExecuteNonQuery();

                ProcessError(pErrCode, pErrMsg);

                OracleString _res = (OracleString)pBulkId.Value;
                return _res.Value;
            }
        }

        public string GetTicket(string requestId)
        {
            LoginUser();
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter pErrCode = new OracleParameter("p_state", OracleDbType.Decimal, ParameterDirection.Output),
                                    pErrMsg = new OracleParameter("p_msg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                                    pTicket = new OracleParameter("p_ticket", OracleDbType.Clob, ParameterDirection.Output))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "bars.subsidy.householdreceive";
                cmd.Parameters.Add(new OracleParameter("p_bulkid", OracleDbType.Varchar2, requestId, ParameterDirection.Input));
                cmd.Parameters.Add(pErrCode);
                cmd.Parameters.Add(pErrMsg);
                cmd.Parameters.Add(pTicket);
                cmd.ExecuteNonQuery();

                ProcessError(pErrCode, pErrMsg);

                OracleString _res = (OracleString)pTicket.Value;
                return _res.Value;
            }
        }

        private void ProcessError(OracleParameter code, OracleParameter msg)
        {
            OracleDecimal _errCode = (OracleDecimal)code.Value;
            OracleString _errMsg = (OracleString)msg.Value;
            if (!_errCode.IsNull && _errCode.Value != 0) throw new SubException(_errMsg.Value, _errCode.Value);
        }
    }

    public class SubException : Exception
    {
        public decimal Code { get; set; }
        public SubException(string msg, decimal code) : base(msg)
        {
            Code = code;
        }
    }
}
