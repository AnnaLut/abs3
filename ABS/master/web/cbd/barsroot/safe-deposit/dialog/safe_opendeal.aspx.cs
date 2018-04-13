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
using Oracle.DataAccess.Client;

public partial class safe_deposit_dialog_safe_opendeal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["safe_id"] == null)
                throw new ApplicationException("Сторінка викликана з некоректними параметрами!");

            SAFEID.Text = safe_deposit.GetNumById(Convert.ToDecimal(Convert.ToString(Request["safe_id"])));
            InitControls();
        }
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

            OracleDataAdapter adapterCustType = new OracleDataAdapter();
            OracleCommand cmdSelectCustType = connect.CreateCommand();
            cmdSelectCustType.CommandText = "select custtype, name from custtype where custtype in (2,3) order by custtype desc";
            adapterCustType.SelectCommand = cmdSelectCustType;
            DataSet dsCustType = new DataSet();
            adapterCustType.Fill(dsCustType);

            ddClientType.DataSource = dsCustType;
            ddClientType.DataTextField = "name";
            ddClientType.DataValueField = "custtype";
            ddClientType.DataBind();

            cmdSelectCustType.Dispose();
            adapterCustType.Dispose();

            OracleCommand cmdGetDealNum = connect.CreateCommand();
            cmdGetDealNum.CommandText = "SELECT s_cc_deal.NEXTVAL FROM dual";
            DEAlID.Text = Convert.ToString(cmdGetDealNum.ExecuteScalar());

            OracleCommand cmdGetSafeType = connect.CreateCommand();
            cmdGetSafeType.CommandText = "select name from skrynka s, skrynka_tip t where s.n_sk = :n_sk and s.o_sk = t.o_sk";
            cmdGetSafeType.Parameters.Add("N_SK", OracleDbType.Decimal, Convert.ToString(Request["safe_id"]), ParameterDirection.Input);
            SAFETYPE.Text = Convert.ToString(cmdGetSafeType.ExecuteScalar());

            OracleCommand cmdGetNls = connect.CreateCommand();
            cmdGetNls.CommandText = "SELECT substr(f_newnls(1,'SD_DR','3600'),1,14) FROM dual ";
            NLS.Text = Convert.ToString(cmdGetNls.ExecuteScalar());


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
    protected void btOK_Click(object sender, EventArgs e)
    {
        safe_deposit sd = new safe_deposit();
        sd.Open3600(NLS.Text, Convert.ToDecimal(DEAlID.Text));
        String func = @"function GetDealInfo(deal_id, custtype, rnk)
            {
               var res = new Array();
               res[0] = deal_id; res[1] = custtype; res[2] = rnk; 
               window.returnValue = res;
               window.close();
            }";

        if (String.IsNullOrEmpty(RNK_.Value))
            Response.Write("<script> " + func + " GetDealInfo(" + DEAlID.Text + "," +
                ddClientType.SelectedValue + ");</script>");
        else
            Response.Write("<script> " + func + " GetDealInfo(" + DEAlID.Text + "," +
                ddClientType.SelectedValue + "," + RNK_.Value + ");</script>");
        
        Response.Flush();
    }
}
