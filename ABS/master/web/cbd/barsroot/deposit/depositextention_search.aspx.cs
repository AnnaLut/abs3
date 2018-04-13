using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Bars.Oracle;
using Oracle.DataAccess.Client;

public partial class deposit_depositextention_search : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    private String P_VISA_URL = "visa";
    /// <summary>
    /// 
    /// </summary>
    private Boolean IsVisa
    {
        get
        {
            if (Request[P_VISA_URL] != null)
                return true;
            else
                return false;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        enableJavascriptValidators();

        if (IsVisa)
        {
            lbSearchInfo.Text = "Візування відмови від переоформлення";
            btSelectAll.Value = "Візувати всі вибрані";
            btStornoAll.Visible = true;
            rReason.Visible = true;
        }
        else
        {
            lbSearchInfo.Text = "Відмова від переоформлення";
            btSelectAll.Value = "Відмова для всіх вибраних";
            btStornoAll.Visible = false;
            rReason.Visible = false;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="e"></param>
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        if (IsVisa)
            FillGrid();
        else if (IsPostBack)
            FillGrid();
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillGrid()
    {
        if (CheckSearchParams() == 0)
        {
            Random r = new Random();
            Response.Write("<script> window.showModalDialog('dialog.aspx?type=err&rcode=" +
                Convert.ToString(r.Next()) +
                "','','dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;'); " +
                "</script>");
            Response.Flush();
            return;
        }

        dsDeposits.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsDeposits.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");


        string searchQuery = @"select DPT_ID, DPT_NUM, VIDD_NAME, DAT_BEGIN, DAT_END,
                  CUST_ID, CUST_IDCODE, CUST_NAME, DPT_ACCNUM, DPT_CURCODE, 
                  to_char(dpt_saldo/100,'999999999990.99') DPT_SALDO,   
                  decode(dpt_accnum,int_accnum,'0.00',to_char(int_saldo/100,'999999999990.99')) INT_SALDO ";

        if (IsVisa)
            searchQuery += " from v_dptext_refusreqs where 1=1 ";
        else
            searchQuery += " from v_dptext_pretenders where 1=1 ";

        dsDeposits.SelectParameters.Clear();

        if (textClientName.Text != String.Empty)
        {
            searchQuery = searchQuery + " and upper(CUST_NAME) like :searchParam_clientName ";
            dsDeposits.SelectParameters.Add("searchParam_clientName", TypeCode.String, textClientName.Text.ToUpper() + "%");
        }
        if (textClientCode.Text != String.Empty)
        {
            searchQuery = searchQuery + " and CUST_IDCODE = :searchParam_clientCode ";
            dsDeposits.SelectParameters.Add("searchParam_clientCode", TypeCode.String, textClientCode.Text);
        }
        if (DocNumber.Text != String.Empty)
        {
            searchQuery = searchQuery + " and DOC_NUM = :searchParam_DocNumber";
            dsDeposits.SelectParameters.Add("searchParam_DocNumber", TypeCode.String, DocNumber.Text);
        }
        if (DocSerial.Text != String.Empty)
        {
            searchQuery = searchQuery + " and DOC_SERIAL = :searchParam_DocSerial";
            dsDeposits.SelectParameters.Add("searchParam_DocSerial", TypeCode.String, DocSerial.Text);
        }
        if (textAccount.Text != String.Empty)
        {
            searchQuery = searchQuery + " and DPT_ACCNUM like :searchParam_textAccount ";
            dsDeposits.SelectParameters.Add("searchParam_textAccount", textAccount.Text + "%");
        }
        if (textClientId.Text != String.Empty)
        {
            searchQuery = searchQuery + " and CUST_ID = :searchParam_clientID";
            dsDeposits.SelectParameters.Add("searchParam_clientID", TypeCode.Decimal, Convert.ToString(Convert.ToInt64(textClientId.Text)));
        }
        if (textDepositId.Text != String.Empty)
        {
            searchQuery = searchQuery + " and DPT_ID  = :searchParam_depositID";
            dsDeposits.SelectParameters.Add("searchParam_depositID", TypeCode.Decimal, Convert.ToString(Convert.ToInt64(textDepositId.Text)));
        }
        if (textDepositNum.Text != String.Empty)
        {
            searchQuery = searchQuery + " and DPT_NUM  like :searchParam_depositND";
            dsDeposits.SelectParameters.Add("searchParam_depositND", TypeCode.String, textDepositNum.Text + "%");
        }

        searchQuery += " order by DPT_ID";

        dsDeposits.SelectCommand = searchQuery;
        gvDeposits.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    private void enableJavascriptValidators()
    {
        textDepositId.Attributes["onblur"] = "javascript:doValueCheck(\"textDepositId\")";
        textClientId.Attributes["onblur"] = "javascript:doValueCheck(\"textClientId\")";
        textClientCode.Attributes["onblur"] = "javascript:doValueCheck(\"textClientCode\")";
        DocNumber.Attributes["onblur"] = "javascript:doValueCheck(\"DocNumber\")";
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public decimal CheckSearchParams()
    {
        if (IsVisa)
            return 1;

        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdCkParams = connect.CreateCommand();
            cmdCkParams.CommandText = "select " +
                "dpt_web.enough_search_params " +
                "(:p_dptid,:p_dptnum,:p_custid,:p_accnum,:p_custname, " +
                ":p_custcode,null,:p_docserial,:p_docnum) " +
                "from dual";

            if (String.IsNullOrEmpty(textDepositId.Text))
                cmdCkParams.Parameters.Add("p_dptid", OracleDbType.Decimal, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_dptid", OracleDbType.Decimal, textDepositId.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(textDepositNum.Text))
                cmdCkParams.Parameters.Add("p_dptnum", OracleDbType.Decimal, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_dptnum", OracleDbType.Decimal, textDepositNum.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(textClientId.Text))
                cmdCkParams.Parameters.Add("p_custid", OracleDbType.Decimal, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_custid", OracleDbType.Decimal, textClientId.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(textAccount.Text))
                cmdCkParams.Parameters.Add("p_accnum", OracleDbType.Varchar2, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_accnum", OracleDbType.Varchar2, textAccount.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(textClientName.Text))
                cmdCkParams.Parameters.Add("p_custname", OracleDbType.Varchar2, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_custname", OracleDbType.Varchar2, textClientName.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(textClientCode.Text))
                cmdCkParams.Parameters.Add("p_custcode", OracleDbType.Varchar2, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_custcode", OracleDbType.Varchar2, textClientCode.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(DocSerial.Text))
                cmdCkParams.Parameters.Add("p_docserial", OracleDbType.Varchar2, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_docserial", OracleDbType.Varchar2, DocSerial.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(DocNumber.Text))
                cmdCkParams.Parameters.Add("p_docnum", OracleDbType.Varchar2, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_docnum", OracleDbType.Varchar2, DocNumber.Text, ParameterDirection.Input);


            return Convert.ToDecimal(Convert.ToString(cmdCkParams.ExecuteScalar()));
        }
        catch (Exception ex)
        {
            /// Перехоплюємо помилку і записуємо її
            /// щоб потім відобразити тільки у модальному діалозі
            Deposit.SaveException(ex);
            return 0;
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
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSearch_ServerClick(object sender, System.EventArgs e)
    {
        ;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSelect_ServerClick(object sender, System.EventArgs e)
    {
        if (gvDeposits.SelectedRows.Count < 1)
        {
            Response.Write("<script>alert('Не вибрано жодного депозиту!');</script>");
            return;
        }
        else if (gvDeposits.SelectedRows.Count > 1)
        {
            Response.Write("<script>alert('Вибрано більше одного депозиту!');</script>");
            return;
        }

        String url = "depositextention.aspx?dpt_id=" + gvDeposits.Rows[gvDeposits.SelectedRows[0]].Cells[1].Text;

        if (IsVisa)
            url += "&visa=true";

        Response.Redirect(url);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSelectAll_ServerClick(object sender, System.EventArgs e)
    {
        if (gvDeposits.SelectedRows.Count < 1)
        {
            Response.Write("<script>alert('Не вибрано жодного депозиту!');</script>");
            return;
        }

        for (int i = 0; i < gvDeposits.SelectedRows.Count; i++)
        {
            if (IsVisa)
                Deposit.VerifyExtention(Convert.ToDecimal(gvDeposits.Rows[gvDeposits.SelectedRows[i]].Cells[1].Text),
                    VERIFY_STATUS.VISA,String.Empty);
            else
                Deposit.RefuseExtention(Convert.ToDecimal(gvDeposits.Rows[gvDeposits.SelectedRows[i]].Cells[1].Text));
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btStornoAll_ServerClick(object sender, System.EventArgs e)
    {
        if (gvDeposits.SelectedRows.Count < 1)
        {
            Response.Write("<script>alert('Не вибрано жодного депозиту!');</script>");
            return;
        }

        for (int i = 0; i < gvDeposits.SelectedRows.Count; i++)
        {
            Deposit.VerifyExtention(Convert.ToDecimal(gvDeposits.Rows[gvDeposits.SelectedRows[i]].Cells[1].Text),
                VERIFY_STATUS.STORNO, String.Empty);
        }
    }    
}
