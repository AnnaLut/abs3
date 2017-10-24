using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;

public partial class DepositCoowner : Page
{
    private int row_counter = 0;
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["dpt_id"] == null)
            throw new TechAccountsException("Сторінка викликана з некоректними параметрами!");

        RegisterClientScript();
        FillGrid();

        if (gridCoowners.Rows.Count == 1)
        {
            rnk.Value = Convert.ToString(gridCoowners.Rows[0].Cells[2].Text);
            kv.Value = Convert.ToString(gridCoowners.Rows[0].Cells[1].Text);
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
        			function S_A(id,val,kv,owner_type)
        			{
        			 if(selectedRow != null) selectedRow.style.background = '';
        			 document.getElementById('r_'+id).style.background = '#d3d3d3';
        			 selectedRow = document.getElementById('r_'+id);
        			 document.getElementById('rnk').value = val;
                     document.getElementById('kv').value = kv; 
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

        string searchQuery = "SELECT dpt_num, kv, rnk, owner_name, nmk, ser, numdoc,OWNER_TYPE " +
            "FROM v_dpt_coowners where dpt_id  = :dpt_id ";

        dsCoowners.SelectParameters.Clear();
        dsCoowners.SelectParameters.Add("dpt_id", TypeCode.Decimal, Convert.ToString(Request["dpt_id"]));
        dsCoowners.SelectCommand = searchQuery;
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
            row.Attributes.Add("onclick", string.Format("S_A('{0}','{1}','{2}','{3}')", row_counter, row.Cells[2].Text, row.Cells[1].Text, row.Cells[7].Text));
        }
    }
    /// <summary>
    /// Вибір особи та перехід на наступний крок
    /// </summary>
    protected void btSelect_ServerClick(object sender, EventArgs e)
    {
        OracleConnection connect = new OracleConnection();
        Decimal acc = Decimal.MinValue;
        String nls = new String(' ',10000);
        String dpt_num = Deposit.GetDptNum(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            if (Request["action"] == null)
            {
                OracleCommand cmdOpenTechAcc = connect.CreateCommand();
                cmdOpenTechAcc.CommandText = "begin dpt.p_open_tech_acc(:p_dptid,:p_dptnum,:p_rnk,:p_kv,:p_acc,:p_nls,:p_nms); end;";

                cmdOpenTechAcc.Parameters.Add("p_dptid", OracleDbType.Decimal, Convert.ToDecimal(Request["dpt_id"]), ParameterDirection.Input);
                cmdOpenTechAcc.Parameters.Add("p_dptnum", OracleDbType.Decimal, dpt_num, ParameterDirection.Input);
                cmdOpenTechAcc.Parameters.Add("p_rnk", OracleDbType.Decimal, Convert.ToDecimal(rnk.Value), ParameterDirection.Input);
                cmdOpenTechAcc.Parameters.Add("p_kv", OracleDbType.Decimal, Convert.ToDecimal(kv.Value), ParameterDirection.Input);

                cmdOpenTechAcc.Parameters.Add("p_acc", OracleDbType.Decimal, acc, ParameterDirection.Output);

                OracleParameter pnls = cmdOpenTechAcc.Parameters.Add("p_nls", OracleDbType.Varchar2, 10000);
                pnls.Direction = ParameterDirection.Output;
                OracleParameter pnms = cmdOpenTechAcc.Parameters.Add("p_nms", OracleDbType.Varchar2, 10000);
                pnms.Direction = ParameterDirection.Output;

                cmdOpenTechAcc.ExecuteNonQuery();

                acc = Convert.ToDecimal(Convert.ToString(cmdOpenTechAcc.Parameters["p_acc"].Value));
                nls = Convert.ToString(pnls.Value);
            }
            else if (Request["action"] == "close")
            {
                OracleCommand cmdCheckTechAccClose = connect.CreateCommand();
                cmdCheckTechAccClose.CommandText = "select dpt_web.f_techacc_allow2close(:acc) from dual";
                cmdCheckTechAccClose.Parameters.Add("acc",OracleDbType.Decimal,
                    Convert.ToDecimal(Convert.ToString(Request["acc"])),ParameterDirection.Input);
                String result = Convert.ToString(cmdCheckTechAccClose.ExecuteScalar());
                if (result != "1")
                    throw new TechAccountsException("Технічний рахунок acc=" + 
                        Convert.ToString(Request["acc"]) + " заборонено закривати!");
                cmdCheckTechAccClose.Dispose();
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        if (Request["action"] == null)
        {
            string script = "<script>alert('Технічний рахунок " + nls + " успішно відкрито');" +
                            "location.href='DepositTechAcc.aspx?acc=" + Convert.ToString(acc) +
                            "&rnk=" + Convert.ToString(rnk.Value) + "';</script>";
            Response.Write(script);
            Response.Flush();
        }   
        else if (Request["action"] == "close")
            Response.Redirect("DepositTechAcc.aspx?action=close&acc=" + Convert.ToString(Request["acc"]) +
                "&rnk=" + Convert.ToString(rnk.Value) + "&branch=" + Convert.ToString(Request["branch"]));
        else if (Request["action"] == "add")
            Response.Redirect("AddSum.aspx?action=add&acc=" + Convert.ToString(Request["acc"]) +
                "&rnk=" + Convert.ToString(rnk.Value) + "&cash=" + Convert.ToString(Request["cash"]) +
                "&dpt_id=" + Convert.ToString(Request["dpt_id"]));
        else if (Request["action"] == "pay")
            Response.Redirect("Transfer.aspx?action=pay&acc=" + Convert.ToString(Request["acc"]) +
                "&rnk=" + Convert.ToString(rnk.Value) + "&cash=" + Convert.ToString(Request["cash"]) +
                "&dpt_id=" + Convert.ToString(Request["dpt_id"]) + "&owner=" + Convert.ToString(owner_type.Value));
    }
}
