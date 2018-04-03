using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Data;
using Bars.Oracle;
using Bars.Logger;
using System.Globalization;

/// <summary>
/// Summary description for QueryService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class QueryService : Bars.BarsWebService
{

    public QueryService () {
    }

    [WebMethod(EnableSession = true)]
    public string SubmitQuery(string [] answers) 
    {
        String result = String.Empty;

        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = conn.GetUserConnection(Context);

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSubmitQuery = connect.CreateCommand();
            cmdSubmitQuery.CommandText = "begin bars_gqdpt.create_balance_query( " +
                    ":p_querytype, " +
                    ":p_branch, " +
                    ":p_dptnum, " +
                    ":p_custfirstname, " +
                    ":p_custmiddlename, " +
                    ":p_custlastname, " +
                    ":p_custidcode, " +
                    ":p_custdocserial, " +
                    ":p_custdocnumber, " +
                    ":p_custdocdate, " +
                    ":p_amount, " +
                    ":p_queryid); end; ";

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
            cinfo.NumberFormat.CurrencyDecimalSeparator = ".";

            cmdSubmitQuery.Parameters.Add("p_querytype",        OracleDbType.Decimal,   Convert.ToDecimal(answers[0]),              ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_branch",           OracleDbType.Varchar2,  answers[1],                                 ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_dptnum",           OracleDbType.Decimal,   Convert.ToDecimal(answers[2]),              ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_custfirstname",    OracleDbType.Varchar2,  answers[3],                                 ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_custmiddlename",   OracleDbType.Varchar2,  answers[4],                                 ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_custlastname",     OracleDbType.Varchar2,  answers[5],                                 ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_custidcode",       OracleDbType.Varchar2,  answers[6],                                 ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_custdocserial",    OracleDbType.Varchar2,  answers[7],                                 ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_custdocnumber",    OracleDbType.Varchar2,  answers[8],                                 ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_custdocdate",      OracleDbType.Date,      Convert.ToDateTime(answers[9],cinfo),       ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_amount",           OracleDbType.Decimal,   Convert.ToDecimal(answers[10],cinfo)*100,   ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_queryid",          OracleDbType.Decimal,   result,                                     ParameterDirection.Input);

            cmdSubmitQuery.ExecuteNonQuery();

            result = (String)cmdSubmitQuery.Parameters["p_queryid"].Value;

            return result;
        }
        catch (Exception ex)
        {
            SaveExeption(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    [WebMethod(EnableSession = true)]
    public object[] LoadQueries(string[] data)
    {
        InitOraConnection();

        try
        {
            SetRole("DPT_ROLE");

            object[] obj = BindTableWithNewFilter(@"QUERY_ID,QUERYTYPE_NAME,USER_ID,FIO,
                    to_char(REQUEST_DATE,'dd/mm/yyyy') as DAT_S,
                    to_char(RESPONSE_DATE,'dd/mm/yyyy') as DAT_E,
                    QUERY_STATUS,STATUS",
                "V_GQ_QUERY_ACTIVE", "", data);

            return obj;
        }
        catch (Exception e)
        {
            SaveExeption(e);
            throw e;
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    [WebMethod(EnableSession = true)]
    public object[] LoadResponse(string query)
    {
        object[] result = new object[26];
        String str = "                                                                                                                                                                                        ";

        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = conn.GetUserConnection(Context);

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSubmitQuery = connect.CreateCommand();
            cmdSubmitQuery.CommandText = "begin bars_gqdpt.get_balance_query( " +
                ":p_queryid, " +
                ":p_querystatus, " +
                ":p_errmsg, " +
                ":p_dptaccnum, " +
                ":p_dptacccur, " +
                ":p_dptaccbal, " +
                ":p_dptaccbalavl, " +
                ":p_intaccnum, " +
                ":p_intacccur, " +
                ":p_intaccbal, " +
                ":p_intaccbalavl, " +
                ":p_transfamount, " +
                ":p_transfdocref, " +
                ":p_branch, " +
                ":p_dptnum, " +
                ":p_custfirstname, " +
                ":p_custmiddlename, " +
                ":p_custlastname, " +
                ":p_custidcode, " +
                ":p_custdocserial, " +
                ":p_custdocnumber, " +
                ":p_custdocdate, " +
                ":p_amount); end;";

            cmdSubmitQuery.Parameters.Add("p_queryid", OracleDbType.Decimal, query, ParameterDirection.Input);
            cmdSubmitQuery.Parameters.Add("p_querystatus", OracleDbType.Decimal,str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_errmsg", OracleDbType.Varchar2, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_dptaccnum", OracleDbType.Varchar2, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_dptacccur", OracleDbType.Decimal, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_dptaccbal", OracleDbType.Decimal, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_dptaccbalavl", OracleDbType.Decimal, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_intaccnum", OracleDbType.Varchar2, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_intacccur", OracleDbType.Decimal, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_intaccbal", OracleDbType.Decimal, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_intaccbalavl", OracleDbType.Decimal, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_transfamount", OracleDbType.Decimal, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_transfdocref", OracleDbType.Decimal, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_branch", OracleDbType.Varchar2, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_dptnum", OracleDbType.Decimal, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_custfirstname", OracleDbType.Varchar2, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_custmiddlename", OracleDbType.Varchar2, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_custlastname", OracleDbType.Varchar2, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_custidcode", OracleDbType.Varchar2, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_custdocserial", OracleDbType.Varchar2, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_custdocnumber", OracleDbType.Varchar2, str, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_custdocdate", OracleDbType.Date, DateTime.MinValue, ParameterDirection.InputOutput);
            cmdSubmitQuery.Parameters.Add("p_amount", OracleDbType.Decimal, str, ParameterDirection.InputOutput);

            cmdSubmitQuery.ExecuteNonQuery();

            result[0] = Convert.ToString(cmdSubmitQuery.Parameters["p_querystatus"].Value);
            if ((OracleString)cmdSubmitQuery.Parameters["p_errmsg"].Value != OracleString.Null)
                result[1] = Convert.ToString(cmdSubmitQuery.Parameters["p_errmsg"].Value);

            if ((OracleString)cmdSubmitQuery.Parameters["p_dptaccnum"].Value != OracleString.Null)
                result[2]  =Convert.ToString(cmdSubmitQuery.Parameters["p_dptaccnum"].Value);
            if ((OracleDecimal)cmdSubmitQuery.Parameters["p_dptacccur"].Value != OracleDecimal.Null)
                result[3] = Convert.ToString(cmdSubmitQuery.Parameters["p_dptacccur"].Value);
            if ((OracleDecimal)cmdSubmitQuery.Parameters["p_dptaccbal"].Value != OracleDecimal.Null)
                result[4] = Convert.ToString(cmdSubmitQuery.Parameters["p_dptaccbal"].Value);
            if ((OracleDecimal)cmdSubmitQuery.Parameters["p_dptaccbalavl"].Value != OracleDecimal.Null)
                result[5] = Convert.ToString(cmdSubmitQuery.Parameters["p_dptaccbalavl"].Value);
            if ((OracleString)cmdSubmitQuery.Parameters["p_intaccnum"].Value != OracleString.Null)
                result[6] = Convert.ToString(cmdSubmitQuery.Parameters["p_intaccnum"].Value);
            if ((OracleDecimal)cmdSubmitQuery.Parameters["p_dptaccbalavl"].Value != OracleDecimal.Null)
                result[7] = Convert.ToString(cmdSubmitQuery.Parameters["p_intacccur"].Value);
            if ((OracleDecimal)cmdSubmitQuery.Parameters["p_intaccbal"].Value != OracleDecimal.Null)
                result[8] = Convert.ToString(cmdSubmitQuery.Parameters["p_intaccbal"].Value);
            if ((OracleDecimal)cmdSubmitQuery.Parameters["p_intaccbalavl"].Value != OracleDecimal.Null)
                result[9] = Convert.ToString(cmdSubmitQuery.Parameters["p_intaccbalavl"].Value);
            if ((OracleDecimal)cmdSubmitQuery.Parameters["p_transfamount"].Value != OracleDecimal.Null)
                result[10] = Convert.ToString(cmdSubmitQuery.Parameters["p_transfamount"].Value);
            if ((OracleDecimal)cmdSubmitQuery.Parameters["p_transfdocref"].Value != OracleDecimal.Null)            
                result[11] = Convert.ToString(cmdSubmitQuery.Parameters["p_transfdocref"].Value);

            if ((OracleString)cmdSubmitQuery.Parameters["p_branch"].Value != OracleString.Null)            
                result[12] = Convert.ToString(cmdSubmitQuery.Parameters["p_branch"].Value);
            if ((OracleDecimal)cmdSubmitQuery.Parameters["p_dptnum"].Value != OracleDecimal.Null)            
                result[13] = Convert.ToString(cmdSubmitQuery.Parameters["p_dptnum"].Value);
            if ((OracleString)cmdSubmitQuery.Parameters["p_custfirstname"].Value != OracleString.Null)                        
                result[14] = Convert.ToString(cmdSubmitQuery.Parameters["p_custfirstname"].Value);
            if ((OracleString)cmdSubmitQuery.Parameters["p_custmiddlename"].Value != OracleString.Null)            
                result[15] = Convert.ToString(cmdSubmitQuery.Parameters["p_custmiddlename"].Value);
            if ((OracleString)cmdSubmitQuery.Parameters["p_custlastname"].Value != OracleString.Null)            
                result[16] = Convert.ToString(cmdSubmitQuery.Parameters["p_custlastname"].Value);
            if ((OracleString)cmdSubmitQuery.Parameters["p_custidcode"].Value != OracleString.Null)            
                result[17] = Convert.ToString(cmdSubmitQuery.Parameters["p_custidcode"].Value);
            if ((OracleString)cmdSubmitQuery.Parameters["p_custdocserial"].Value != OracleString.Null)            
                result[18] = Convert.ToString(cmdSubmitQuery.Parameters["p_custdocserial"].Value);
            if ((OracleString)cmdSubmitQuery.Parameters["p_custdocnumber"].Value != OracleString.Null)            
                result[19] = Convert.ToString(cmdSubmitQuery.Parameters["p_custdocnumber"].Value);
            
            OracleDate pdat = (OracleDate)cmdSubmitQuery.Parameters["p_custdocdate"].Value;
            if ((OracleDate)cmdSubmitQuery.Parameters["p_custdocdate"].Value != OracleDate.Null)
            {
                DateTime d = pdat.Value;
                result[20] = d.ToString("dd/MM/yyyy");
            }
            if ((OracleDecimal)cmdSubmitQuery.Parameters["p_amount"].Value != OracleDecimal.Null)            
                result[21] = Convert.ToString(cmdSubmitQuery.Parameters["p_amount"].Value);

            OracleCommand cmdGetTransNLS = connect.CreateCommand();
            cmdGetTransNLS.CommandText = "SELECT branch_edit.getbranchparams(sys_context('bars_context', 'user_branch'),'IB_TRANS') FROM dual";
            result[22] = Convert.ToString(cmdGetTransNLS.ExecuteScalar());

            OracleCommand cmdGetClientInfo = connect.CreateCommand();
            cmdGetClientInfo.CommandText = @"SELECT p.organ, to_char(p.bday,'dd/MM/yyyy'),c.adr
                FROM CUSTOMER c, PERSON p
                WHERE c.rnk = p.rnk AND c.okpo = :okpo and p.ser=:ser and p.numdoc=:num";

            cmdGetClientInfo.Parameters.Add("okpo", OracleDbType.Varchar2, Convert.ToString(result[17]), ParameterDirection.Input);
            cmdGetClientInfo.Parameters.Add("ser", OracleDbType.Varchar2, Convert.ToString(result[18]), ParameterDirection.Input);
            cmdGetClientInfo.Parameters.Add("num", OracleDbType.Varchar2, Convert.ToString(result[19]), ParameterDirection.Input);

            OracleDataReader rdr = cmdGetClientInfo.ExecuteReader();

            if (rdr.Read())
            {
                result[23] = Convert.ToString(rdr.GetOracleString(0).Value);
                result[24] = Convert.ToString(rdr.GetOracleString(1).Value);
                result[25] = Convert.ToString(rdr.GetOracleString(2).Value);
            }
            else
            {
                result[23] = "-";
                result[24] = "-";
                result[25] = "-";
            }
            rdr.Close();
            rdr.Dispose();

            return result;
        }
        catch (Exception ex)
        {
            SaveExeption(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    [WebMethod(EnableSession = true)]
    public void ClearQuest(string query)
    {
        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = conn.GetUserConnection(Context);

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSubmitQuery = connect.CreateCommand();
            cmdSubmitQuery.CommandText = "begin bars_gq.clear_active_query( " +
                    ":p_queryid); end; ";

            cmdSubmitQuery.Parameters.Add("p_queryid", OracleDbType.Decimal, query, ParameterDirection.Input);

            cmdSubmitQuery.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            SaveExeption(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}