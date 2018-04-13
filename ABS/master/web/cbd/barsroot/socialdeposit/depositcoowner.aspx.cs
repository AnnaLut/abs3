using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;

public partial class DepositCoowner : Bars.BarsPage
{
    private int row_counter = 0;
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["dpt_id"] == null)
            throw new SocialDepositException("Сторінка викликана з некоректними параметрами!");

        RegisterClientScript();
        FillGrid();

        if (gridCoowners.Rows.Count == 1)
        {
            rnk.Value = Convert.ToString(gridCoowners.Rows[0].Cells[1].Text);
            btSelect_ServerClick(sender, e);
        }

        if (!IsPostBack)
            rnk.Value = "";
    }
    /// <summary>
    /// Скріпт, для виділення рядків у гріді
    /// </summary>
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
        			var selectedRow;
        			function S_A(id,val,owner_type)
        			{
        			 if(selectedRow != null) selectedRow.style.background = '';
        			 document.getElementById('r_'+id).style.background = '#d3d3d3';
        			 selectedRow = document.getElementById('r_'+id);
        			 document.getElementById('rnk').value = val;
                     document.getElementById('owner_type').value = owner_type;
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
        dsCoowners.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCoowners.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        string searchQuery = "SELECT contract_num, rnk, owner_name, nmk, ser, numdoc, OWNER_TYPE " +
            "FROM v_soc_coowners where contract_id  = :dpt_id ";

        dsCoowners.SelectParameters.Clear();
        dsCoowners.SelectParameters.Add("dpt_id", TypeCode.Decimal, Convert.ToString(Request["dpt_id"]));
        dsCoowners.SelectCommand = searchQuery;
        gridCoowners.DataBind();
    }
    /// <summary>
    /// Подія - заповнення гріда даними 
    /// </summary>
    protected void gridCoowners_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter;
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", string.Format("S_A('{0}','{1}','{2}')", row_counter, row.Cells[1].Text, row.Cells[6].Text));
        }
    }
    /// <summary>
    /// Вибір особи та перехід на наступний крок
    /// </summary>
    protected void btSelect_ServerClick(object sender, EventArgs e)
    {
        String dpt_num = Deposit.GetDptNum(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));

        if (Request["action"] == "add")
            Response.Redirect("AddSum.aspx?action=add&acc=" + Convert.ToString(Request["acc"]) +
                "&rnk=" + Convert.ToString(rnk.Value) + "&cash=" + Convert.ToString(Request["cash"]) +
                "&dpt_id=" + Convert.ToString(Request["dpt_id"]));
        else if (Request["action"] == "pay")
            Response.Redirect("Transfer.aspx?action=pay" +
                "&rnk=" + Convert.ToString(rnk.Value) + 
                "&cash=" + Convert.ToString(Request["cash"]) +
                "&dpt_id=" + Convert.ToString(Request["dpt_id"]) + 
                "&owner=" + Convert.ToString(owner_type.Value));
    }
}
