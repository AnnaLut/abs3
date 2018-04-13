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
using System.Web.Services;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Classes;

public partial class safe_deposit_dialog_createsafe : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            InitControls();
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitControls()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleDataAdapter adapterSafeType = new OracleDataAdapter();
            OracleCommand cmdSelectSafeType = connect.CreateCommand();
            cmdSelectSafeType.CommandText = "SELECT O_SK, NAME FROM SKRYNKA_TIP WHERE branch = sys_context('bars_context','user_branch') ORDER BY O_SK";
            adapterSafeType.SelectCommand = cmdSelectSafeType;
            DataSet dsSafeType = new DataSet();
            adapterSafeType.Fill(dsSafeType);

            listSafeSize.DataSource = dsSafeType;
            listSafeSize.DataTextField = "NAME";
            listSafeSize.DataValueField = "O_SK";
            listSafeSize.DataBind();

            cmdSelectSafeType.Dispose();
            adapterSafeType.Dispose();

            OracleCommand cmdGetMfo = connect.CreateCommand();
            cmdGetMfo.CommandText = "SELECT f_ourmfo FROM DUAL";
            MFO.Value = Convert.ToString(cmdGetMfo.ExecuteScalar());
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="safe_id"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public static String GetNls(String safe_id)
    {
        /// Якщо прийшли порожні дані - повертаємо порожню стрічку
        if (String.IsNullOrEmpty(safe_id))
            return String.Empty;

        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"SELECT substr(f_newnls(1,'SCRN','2909'),1,14) FROM dual";
            cmd.Parameters.Add("safe_id", OracleDbType.Varchar2, safe_id, ParameterDirection.Input);

            return Convert.ToString(cmd.ExecuteScalar());            
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            safe_deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="safe_id"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public static String SafeIdExists(String safe_id)
    {
        /// Якщо прийшли порожні дані - повертаємо порожню стрічку
        if (String.IsNullOrEmpty(safe_id))
            return String.Empty;

        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select snum from skrynka where snum = :snum and branch = sys_context('bars_context','user_branch_mask')";
            cmd.Parameters.Add("safe_id", OracleDbType.Varchar2, safe_id, ParameterDirection.Input);

            String result = Convert.ToString(cmd.ExecuteScalar());
            return (result == safe_id ? "1" : "0");
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            safe_deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btCreateSafe_Click(object sender, EventArgs e)
    {
        if (SafeIdExists(SAFE_ID.Text) == "1")
        {
            Response.Write("<script>alert('Сейф с указаным номером уже существует!');</script>");
            Response.Flush();
            return;
        }

        safe_deposit sdpt = new safe_deposit();
        sdpt.CreateSafe(SAFE_ID.Text, 
            Convert.ToDecimal(listSafeSize.SelectedValue),
            NLS.Text);

        SAFE_ID.Text = String.Empty;
        NLS.Text = String.Empty;
        listSafeSize.SelectedIndex = 0;

        Response.Write("<script>alert('Сейф успешно открыт!');</script>");
        Response.Flush();
    }
}
