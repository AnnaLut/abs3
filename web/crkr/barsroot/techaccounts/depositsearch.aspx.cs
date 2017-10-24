using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;

public partial class DepositSearch : Page
{
    private int row_counter = 0;
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterClientScript();
        FillGrid();

        if (!IsPostBack)
        {
            dptid.Value = "";
        }
    }
    /// <summary>
    /// Скріпт, для виділення рядків у гріді
    /// </summary>
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
        			var selectedRow;
        			function S_A(id,val)
        			{
        			 if(selectedRow != null) selectedRow.style.background = '';
        			 document.getElementById('r_'+id).style.background = '#d3d3d3';
        			 selectedRow = document.getElementById('r_'+id);
        			 document.getElementById('dptid').value = val;
        			}
        			</script>";
        ClientScript.RegisterStartupScript(GetType(), ID + "Script_A", script);
    }
    /// <summary>
    /// Пошук
    /// </summary>
    protected void btSearch_ServerClick(object sender, EventArgs e)
    {
        FillGrid();
    }
    /// <summary>
    /// Наповнення даних
    /// </summary>
    private void FillGrid()
    {
        dsContract.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsContract.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        string searchQuery = "select d_id, nd, type_name, datz, dat_end, " +
            "rnk, okpo, nmk, nls, lcv, ostc, p_ostc " +
            "from v_dpt_tech_pretenders where 1=1 ";

        dsContract.SelectParameters.Clear();

        if (textClientName.Text != String.Empty)
            searchQuery += " and upper(nmk) like '%" + textClientName.Text.ToUpper() + "%' ";

        if (textClientCode.Text != String.Empty)
        {
            dsContract.SelectParameters.Add("searchParam_clientCode", TypeCode.Decimal, textClientCode.Text);
            searchQuery += " and okpo = :searchParam_clientCode ";
        }

        if (!(DocDate_TextBox.Value == "01/01/0001" || DocDate_TextBox.Value == String.Empty))
        {
            dsContract.SelectParameters.Add("searchParam_bDate", TypeCode.DateTime, DocDate_TextBox.Value);
            searchQuery += " and bday = :searchParam_bDate ";
        }

        if (DocNumber.Text != String.Empty)
        {
            dsContract.SelectParameters.Add("searchParam_DocNumber", TypeCode.Decimal, DocNumber.Text);
            searchQuery += " and numdoc = :searchParam_DocNumber ";
        }

        if (DocSerial.Text != String.Empty)
            searchQuery += " and ser = '" + DocSerial.Text + "' ";

        if (textAccount.Text != String.Empty)
            searchQuery += " and nls like '%" + textAccount.Text + "%' ";

        if (textClientId.Text != String.Empty)
        {
            dsContract.SelectParameters.Add("searchParam_clientID", TypeCode.Decimal, textClientId.Text);
            searchQuery += " and rnk = :searchParam_clientID ";
        }

        if (textDepositId.Text != String.Empty)
        {
            dsContract.SelectParameters.Add("searchParam_depositID", TypeCode.Decimal, textDepositId.Text);
            searchQuery += " and d_id  = :searchParam_depositID ";
        }
        if (textDepositNum.Text != String.Empty)
        {
            dsContract.SelectParameters.Add("searchParam_depositND", TypeCode.Decimal, textDepositNum.Text);
            searchQuery += " and nd = :searchParam_depositND ";
        }

        dsContract.SelectCommand = searchQuery;
    }
    /// <summary>
    /// Подія - заповнення гріда даними 
    /// </summary>
    protected void gridDeposit_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter;
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" + row.Cells[1].Text + "')");
        }
    }
}

