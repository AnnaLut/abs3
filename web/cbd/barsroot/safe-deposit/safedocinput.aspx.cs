using System;
using System.Data;
//using System.Configuration;
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
using System.Web.Services;
using Bars.Configuration;


public partial class safe_deposit_safedocinput : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        

        if (Request["safe_id"] == null)
            Response.Redirect("safeportfolio.aspx");

        if (!IsPostBack)
        {
            n_sk.Value = Convert.ToString(Request["safe_id"]);
            nd.Value = Convert.ToString(Request["nd"]);
            lbTitle.Text = lbTitle.Text.Replace("%s", 
                safe_deposit.GetNumById(Convert.ToDecimal(n_sk.Value)));
            InitList();
        }


        bt1.NavigateUrl = "/barsroot/safe-deposit/safedealdocs.aspx?nd=" + nd.Value + "&safe_id=" + n_sk.Value;
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitList()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleDataAdapter adapterTT = new OracleDataAdapter();
            OracleCommand cmdTT = connect.CreateCommand();
            cmdTT.CommandText = "SELECT item,name from SKRYNKA_MENU where type = 'SKRN' order by item";
            adapterTT.SelectCommand = cmdTT;
            DataSet dsTT = new DataSet();
            adapterTT.Fill(dsTT);

            listTT.DataSource = dsTT;
            listTT.DataTextField = "name";
            listTT.DataValueField = "item";
            listTT.DataBind();

            SetParamFields(listTT.SelectedValue);

            cmdTT.Dispose();
            adapterTT.Dispose();
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
    protected void listTT_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetParamFields(listTT.SelectedValue);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="item"></param>
    private void SetParamFields(String item)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdParam = connect.CreateCommand();
            cmdParam.CommandText = " SELECT datename1,datename2,numparname FROM SKRYNKA_MENU WHERE  item = :item";
            cmdParam.Parameters.Add("item",OracleDbType.Decimal,item,ParameterDirection.Input);

            OracleDataReader rdr = cmdParam.ExecuteReader();

            if (!rdr.Read())
            {
                rdat1.Visible = false;
                rdat2.Visible = false;
                rnumpar.Visible = false;
            }

            if (!rdr.IsDBNull(0))
            {
                lbDAT1.Text = Convert.ToString(rdr.GetValue(0));
                rdat1.Visible = true;
            }
            else
                rdat1.Visible = false;

            if (!rdr.IsDBNull(1))
            {
                lbDAT2.Text = Convert.ToString(rdr.GetValue(1));
                rdat2.Visible = true;
            }
            else
                rdat2.Visible = false;

            if (!rdr.IsDBNull(2))
            {
                lbNUMPAR.Text = Convert.ToString(rdr.GetValue(2));
                rnumpar.Visible = true;
            }
            else
                rnumpar.Visible = false;

            rdr.Close();
            rdr.Dispose();
            cmdParam.Dispose();
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
    protected void btPay_Click(object sender, EventArgs e)
    {
        
        /// numpar ІГНОРУЄТЬСЯ - замість нього передається deal_id
        safe_deposit sdpt = new safe_deposit();
        sdpt.Pay(Convert.ToDecimal(n_sk.Value), Convert.ToDecimal(listTT.SelectedValue), DAT1.Date, DAT2.Date, nd.Value);
        //Response.Write("test  " +  Session["Skrn_Dat2"]);

        Random r = new Random();
        String script = @"<script>
            alert('Оплата прошла успешно!');
            </script>";

        Response.Write(script);
        
        //if ("NADRA" == Convert.ToString(ConfigurationSettings.AppSettings["Product.Spec"]))
        Response.Write("<script>window.location.reload('/barsroot/safe-deposit/safedealdocs.aspx?nd=" + nd.Value + "&safe_id=" + n_sk.Value + "');</script>");
        Response.Flush();
        
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btCalc_Click(object sender, EventArgs e)
    {
//        begin SKRN.p_prepare_ptotocol( :DAT1,:DAT2,:N_SK ,:nExecNumber,:nExecNpar ); end;

//SELECT substr(skrn.f_get_protocol_line(),1,100) FROM dual
    }
 
    [WebMethod(EnableSession = true)]
    public static String CkDate(DateTime Dat_end)
    {
        /// Якщо прийшли порожні дані - повертаємо порожню стрічку
        if (Dat_end == DateTime.MinValue)
            return String.Empty;

        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"SELECT to_char(min(c.fdat),'dd/mm/yyyy')
              FROM (select to_date(to_char(:dfDAT2)) + num - 1 fdat from conductor c ) c
              WHERE not exists (select holiday from holiday where holiday = c.fdat)
                and c.fdat >= :dfDAT2";
            cmd.Parameters.Add("dfDAT2", OracleDbType.Date, Dat_end, ParameterDirection.Input);
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
    
}
