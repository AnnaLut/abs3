using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Oracle;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Globalization;
using System.Text;

public partial class mobinet_mobipay : System.Web.UI.Page
{
    string USERNAME = "user";
    string PASSWORD = "psw";
    string NEWPASSWORD;
    int ACT = 0;
    decimal PAY_AMOUNT;
    int CURRENCY_CODE = 1;
    string MSISDN;
    int PAY_ID;
    int RECEIPT = 12344;
    int STATUS_CODE;
    string TIME_STAMP;
    string connectionString;

    //=====================================================

    protected void Page_Load(object sender, EventArgs e)
    {
        connectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.DateSeparator = ".";
        cinfo.NumberFormat.NumberDecimalSeparator = ".";
        cinfo.NumberFormat.NumberGroupSeparator = " ";

        HttpResponse Response = Context.Response;
        HttpRequest Request = Context.Request;
        if (Request.Params["ACT"] != null)
            ACT = Convert.ToInt32(Request.Params["ACT"]);
        else STATUS_CODE = -1;
        if (Request.Params["CURRENCY_CODE"] != null)
            CURRENCY_CODE = Convert.ToInt32(Request.Params["CURRENCY_CODE"]);
        if (Request.Params["PAY_ID"] != null)
            PAY_ID = Convert.ToInt32(Request.Params["PAY_ID"]);
        if (Request.Params["PAY_AMOUNT"] != null)
            PAY_AMOUNT = Convert.ToDecimal(Request.Params["PAY_AMOUNT"], cinfo);
        if (Request.Params["USERNAME"] != null)
            USERNAME = Convert.ToString(Request.Params["USERNAME"]);
        if (Request.Params["PASSWORD"] != null)
            PASSWORD = Convert.ToString(Request.Params["PASSWORD"]);
        if (Request.Params["NEWPASSWORD"] != null)
            NEWPASSWORD = Convert.ToString(Request.Params["NEWPASSWORD"]);
        if (Request.Params["MSISDN"] != null)
            MSISDN = Convert.ToString(Request.Params["MSISDN"]);

        if (AuthUser())
        {
            if (ACT == 0) InvokePay();
            else if (ACT == 1) CommitInv();
            else if (ACT == 2) AbortInv();
            else if (ACT == 4) CheckInv();
            else if (ACT == 5) ChangePsw();
            else if (ACT == 7) GetUserInfo();
            else STATUS_CODE = -11;
        }

        Response.ContentType = "text/html";
        Response.Output.Write(WriteXmlOutput());
        Response.End();
    }
    private void GetUserInfo()
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
        OracleCommand command = new OracleCommand();
        command.Connection = connect;
        try
        {
            command.CommandText = "set role cust001";
            command.ExecuteNonQuery();
            command.CommandText = "SELECT TO_CHAR(SYSDATE,'DD.MM.YYYY HH24:MI:SS') FROM DUAL";
            TIME_STAMP = command.ExecuteScalar().ToString();
        }
        finally
        {
            connect.Close();
            connect.Dispose();
            command.Dispose();
        }
        if (MSISDN == "670000000")
            STATUS_CODE = -40;
        else
            STATUS_CODE = 21;
        return;
    }
    private bool AuthUser()
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
        OracleCommand command = new OracleCommand();
        command.Connection = connect;
        try
        {
            command.CommandText = "set role cust001";
            command.ExecuteNonQuery();
            command.CommandText = "SELECT count(*) FROM MP_USER WHERE USERNAME='" + USERNAME + "' AND PASSWORD='" + PASSWORD + "'";
            if (Convert.ToDecimal(command.ExecuteScalar()) == 0)
            {
                STATUS_CODE = -3;
                return false;
            }
            else return true;
        }
        finally
        {
            connect.Close();
            connect.Dispose();
            command.Dispose();
        }
    }
    private void ChangePsw()
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
        OracleCommand command = new OracleCommand();
        command.Connection = connect;
        try
        {
            command.CommandText = "set role cust001";
            command.ExecuteNonQuery();
            command.CommandText = "UPDATE MP_USER SET PASSWORD='" + NEWPASSWORD + "' WHERE USERNAME='" + USERNAME + "' AND PASSWORD='" + PASSWORD + "'";
            int status = command.ExecuteNonQuery();
            if (status == 1)
            {
                STATUS_CODE = 60;
            }
            else STATUS_CODE = -60;
            command.CommandText = "SELECT TO_CHAR(SYSDATE,'DD.MM.YYYY HH24:MI:SS') FROM DUAL";
            TIME_STAMP = command.ExecuteScalar().ToString();
        }
        finally
        {
            connect.Close();
            connect.Dispose();
            command.Dispose();
        }
    }
    private void CommitInv()
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
        OracleCommand command = new OracleCommand();
        command.Connection = connect;
        try
        {
            command.CommandText = "set role cust001";
            command.ExecuteNonQuery();

            command.CommandText = "SELECT ID_PAY FROM MP_TRANS WHERE COMMIT_PAY=1 AND ID_PAY=" + PAY_ID;

            OracleDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                STATUS_CODE = -26;
                return;
            }
            reader.Close();
            reader.Dispose();

            command.CommandText = "UPDATE MP_TRANS SET COMMIT_PAY=1 WHERE ID_PAY=" + PAY_ID;
            int status = command.ExecuteNonQuery();
            if (status == 1)
            {
                STATUS_CODE = 22;
            }
            else STATUS_CODE = -27;
            command.CommandText = "SELECT TO_CHAR(SYSDATE,'DD.MM.YYYY HH24:MI:SS') FROM DUAL";
            TIME_STAMP = command.ExecuteScalar().ToString();
        }
        finally
        {
            connect.Close();
            connect.Dispose();
            command.Dispose();
        }
    }
    private void CheckInv()
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
        OracleCommand command = new OracleCommand();
        command.Connection = connect;
        try
        {
            command.CommandText = "set role cust001";
            command.ExecuteNonQuery();

            command.CommandText = "SELECT ID_PAY FROM MP_TRANS WHERE COMMIT_PAY=1 AND ID_PAY=" + PAY_ID;

            OracleDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                STATUS_CODE = -26;
                return;
            }
            reader.Close();
            reader.Dispose();

            command.CommandText = "SELECT COUNT(ID_PAY)FROM MP_TRANS WHERE ID_PAY=" + PAY_ID;
            if (Convert.ToDecimal(command.ExecuteScalar()) != 0)
            {
                STATUS_CODE = 21;
            }
            else STATUS_CODE = 21;
            command.CommandText = "SELECT TO_CHAR(SYSDATE,'DD.MM.YYYY HH24:MI:SS') FROM DUAL";
            TIME_STAMP = command.ExecuteScalar().ToString();
        }
        finally
        {
            connect.Close();
            connect.Dispose();
            command.Dispose();
        }
    }
    private string WriteXmlOutput()
    {
        StringBuilder str = new StringBuilder();
        str.Append("<?xml version=\"1.0\" encoding=\"windows-1251\" ?>\n");
        str.Append(" <pay-response>\n");
        if (ACT == 7)
        {
            if (STATUS_CODE > 0)
            {
                str.Append("  <balance>14515.47</balance> \n");
                str.Append("  <name>Василий</name> \n");
                str.Append("  <account>52654</account> \n");
            }
            str.Append("  <status_code>" + STATUS_CODE + "</status_code> \n");
            str.Append("  <time_stamp>" + TIME_STAMP + "</time_stamp>\n");
        }
        else
        {
            if (ACT == 0 && STATUS_CODE > 0) str.Append("  <pay_id>" + PAY_ID + "</pay_id>\n");
            else if (ACT == 1) str.Append("  <receipt>" + RECEIPT + "</receipt>\n");
            if (STATUS_CODE.ToString() != null) str.Append("  <status_code>" + STATUS_CODE + "</status_code> \n");
            if (TIME_STAMP != null && ACT != 5) str.Append("   <time_stamp>" + TIME_STAMP + "</time_stamp>\n");
        }
        str.Append(" </pay-response>");
        return str.ToString();
    }
    private void InvokePay()
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
        
        OracleCommand command = new OracleCommand();
        OracleDataReader reader = null;
        command.Connection = connect;
        try
        {
            command.CommandText = "set role cust001";
            command.ExecuteNonQuery();

            command.Parameters.Clear();
            command.Parameters.Add("PAY_AMOUNT", OracleDbType.Decimal, PAY_AMOUNT, System.Data.ParameterDirection.Input);
            command.CommandText = "INSERT INTO MP_TRANS(ID_PAY,STATUS_CODE,MSISDN,PAY_AMOUNT,TIME_STAMP) VALUES(0,0,'" + MSISDN + "',:PAY_AMOUNT,sysdate)";
            command.ExecuteNonQuery();

            command.Parameters.Clear();
            command.CommandText = "SELECT ID_PAY,TO_CHAR(TIME_STAMP,'DD.MM.YYYY HH24:MI:SS') FROM MP_TRANS WHERE COMMIT_PAY=0 AND MSISDN=" + MSISDN;
            reader = command.ExecuteReader();
            if (reader.Read())
            {
                PAY_ID = Convert.ToInt32(reader.GetValue(0));
                STATUS_CODE = 20;
                TIME_STAMP = reader.GetValue(1).ToString();
            }
            else
                STATUS_CODE = -20;
            command.CommandText = "COMMIT";
            command.ExecuteNonQuery();
        }
        finally
        {
            connect.Close();
            connect.Dispose();
            reader.Close();
            reader.Dispose();
            command.Dispose();
        }
    }
    private void AbortInv()
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
        
        OracleCommand command = new OracleCommand();
        command.Connection = connect;
        try
        {
            command.CommandText = "set role cust001";
            command.ExecuteNonQuery();
            command.CommandText = "DELETE FROM MP_TRANS WHERE COMMIT_PAY=0 AND ID_PAY=" + PAY_ID;
            int status = command.ExecuteNonQuery();
            if (status == 1)
            {
                STATUS_CODE = 23;
            }
            else STATUS_CODE = -27;
            command.CommandText = "SELECT TO_CHAR(SYSDATE,'DD.MM.YYYY HH24:MI:SS') FROM DUAL";
            TIME_STAMP = command.ExecuteScalar().ToString();
        }
        finally
        {
            connect.Close();
            connect.Dispose();
            command.Dispose();
        }
    }
}
