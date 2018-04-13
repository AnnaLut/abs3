using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Data;


/// <summary>
/// Summary description for SocialService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class SocialService :Bars.BarsWebService  
{
    public SocialService () {}
    [WebMethod(EnableSession = true)]
    public string CheckCardNls(String nls) 
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdCkCardAcc = connect.CreateCommand();
            cmdCkCardAcc.CommandText = "select dpt_social.check_tm_card(:nls) from dual";
            cmdCkCardAcc.Parameters.Add("nls",OracleDbType.Varchar2,nls,ParameterDirection.Input);

            return Convert.ToString(cmdCkCardAcc.ExecuteScalar());
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
    public String[] CheckNls(String agntype, String nls,String type,String branch)
    {
        String[] result = new String[3];
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdCkAcc = connect.CreateCommand();
            cmdCkAcc.CommandType = CommandType.StoredProcedure;
            cmdCkAcc.CommandText = "dpt_social.check_agency_account";
            cmdCkAcc.Parameters.Add(":agntype", OracleDbType.Char,      agntype, ParameterDirection.Input);
            cmdCkAcc.Parameters.Add(":type",    OracleDbType.Char,      type,   ParameterDirection.Input);
            cmdCkAcc.Parameters.Add(":branch",  OracleDbType.Varchar2,  branch, ParameterDirection.Input);
            OracleParameter o_nls = cmdCkAcc.Parameters.Add(":nls",     OracleDbType.Varchar2, 20,  nls,    ParameterDirection.InputOutput);            
            OracleParameter err = cmdCkAcc.Parameters.Add(":error",   OracleDbType.Decimal, ParameterDirection.Output);
            OracleParameter com = cmdCkAcc.Parameters.Add(":comment", OracleDbType.Varchar2, 5000);
            com.Direction = ParameterDirection.Output;

            cmdCkAcc.ExecuteNonQuery();

            result[0] = Convert.ToString(com.Value);
            result[1] = Convert.ToString(err.Value);
            result[2] = Convert.ToString(o_nls.Value);

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
    public String[] req_field(String atype)
    {
        String[] result = { "0", "0", "0", "0" };
        OracleConnection connect = new OracleConnection();
        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            // Открываем соединение с БД
            

            // Установка роли
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetAcc = connect.CreateCommand();
            cmdGetAcc.CommandText = "select account_typeid " +
                "from v_socialagencyacctypes " +
                "where agency_typeid = :atype";
            cmdGetAcc.Parameters.Add("atype", OracleDbType.Decimal, atype, ParameterDirection.Input);

            OracleDataReader rdr = cmdGetAcc.ExecuteReader();

            while (rdr.Read())
            {
                String par = Convert.ToString(rdr.GetOracleString(0).Value);
                if (par == "C")
                    result[2] = "1";
                else if (par == "K")
                    result[1] = "1";
                else if (par == "D")
                    result[0] = "1";
                else if (par == "M")
                    result[3] = "1";
            }
            
            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();

            return result;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

}

