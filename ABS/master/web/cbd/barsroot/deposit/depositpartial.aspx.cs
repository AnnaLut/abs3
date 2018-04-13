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
using System.Globalization;

public partial class deposit_depositpartial : System.Web.UI.Page
{
    private int row_counter = 0;
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterClientScript();

        inherit_id.Value = String.Empty;

        if (!IsPostBack)
        {
            fvInheritor.ChangeMode(FormViewMode.Insert);        

            if (Request["dpt_id"] == null)
                Response.Redirect("depositsearch.aspx?action=testament");

            dpt_id.Value = Convert.ToString(Request["dpt_id"]);
            Deposit dpt = new Deposit(Convert.ToDecimal(dpt_id.Value));
            TT_P.Value = dpt.GetTT(DPT_OP.OP_3, CASH.YES);
            TT_R.Value = dpt.GetTT(DPT_OP.OP_21, CASH.YES);
            TT_C.Value = dpt.GetTT(DPT_OP.OP_21, CASH.YES);
            
            lbTitle.Text = lbTitle.Text.Replace("%s", Convert.ToString(Request["dpt_id"]));

            if (InheritorsAllRegistered() && InheritorsAreActive())
            {
                btRegisterNew.Disabled = true;
                btFinish.Disabled = true;
                btPercent.Disabled = false;
                btReturn.Disabled = false;
                btClose.Disabled = false;
                gridInheritors.Columns[0].Visible = false;
            }
            else if (InheritorsAreActive())
            {
                btRegisterNew.Disabled = false;
                btFinish.Disabled = true;
                btPercent.Disabled = false;
                btReturn.Disabled = false;
                btClose.Disabled = false;
            }
            else
            {
                btRegisterNew.Disabled = false;
                btFinish.Disabled = false;
                btPercent.Disabled = true;
                btReturn.Disabled = true;
                btClose.Disabled = true;
            }
        }
        else
        {
            RNK.Value = hidRNK.Value;
            FIO.Value = hidFIO.Value;
        }

        if (gridInheritors.Rows.Count == 0)
        {
            btFinish.Disabled = true;
        }

    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="e"></param>
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        if (InheritorsCount() > 0)
            btRegisterNew.Attributes["onclick"] = "RegisterNewInheritorSimplify()";
        else
            btRegisterNew.Attributes["onclick"] = "RegisterNewInheritor()";

        InitGrid();

        gridInheritors.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    protected override void OnInit(EventArgs e)
    {
        dsInheritors.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsInheritors.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        dsInheritor.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsInheritor.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        
        base.OnInit(e);
    }
    /// <summary>
    /// 
    /// </summary>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" ||
            (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        {
            InitGrid();
        }
        try
        {
            base.RaisePostBackEvent(sourceControl, eventArgument);
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            Random r = new Random();
            Response.Write("<script> window.showModalDialog('dialog.aspx?type=err&rcode=" +
                Convert.ToString(r.Next()) +
                "','','dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;'); " +
                "</script>");
            Response.Flush();
        }
    }    
    /// <summary>
    /// 
    /// </summary>
    private void InitGrid() 
    {
        bool Activated = InheritorsAreActive();
        bool AllActivated = InheritorsAllRegistered();

        if (Activated && AllActivated)
            fvInheritor.Visible = false;
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btFinish_ServerClick(object sender, EventArgs e)
    {
		OracleConnection connect = new OracleConnection();

		try
		{
			// Создаем соединение
			IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

			// Открываем соединение с БД
			

			// Устанавливаем роль
			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "begin dpt_web.inherit_activation(:dpt_id, :p_inherit_custid); end;";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToString(Request["dpt_id"]), ParameterDirection.Input);
            cmd.Parameters.Add("p_inherit_custid", OracleDbType.Decimal, Convert.ToString(Request["inherit_id"]), ParameterDirection.Input);


            cmd.ExecuteNonQuery();

            InitGrid();

            //btRegisterNew.Disabled = true;
            btFinish.Disabled = true;
            btPercent.Disabled = false;
            btReturn.Disabled = false;
            btClose.Disabled = false;
		}
		finally
		{
			if ( connect.State != ConnectionState.Closed )
			{connect.Close();connect.Dispose();}
		}
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    private bool InheritorsAreActive()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select min(inherit_state) from v_dpt_inheritors where dpt_id = :dpt_id";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToString(Request["dpt_id"]), ParameterDirection.Input);

            String res = Convert.ToString(cmd.ExecuteScalar());

            return (res == "1" ? true : false);
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
    /// <returns></returns>
    private bool InheritorsAllRegistered()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД


            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select decode(nvl(sum(inherit_share),0),100,1,0) from v_dpt_inheritors where dpt_id = :dpt_id";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToString(Request["dpt_id"]), ParameterDirection.Input);

            String res = Convert.ToString(cmd.ExecuteScalar());

            return (res == "1" ? true : false);
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
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
			function S_A(id,val)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('inherit_id').value = val;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script", script);
    }
    /// <summary>
    /// 
    /// </summary>
    protected void gridInheritors_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            String inherit = (String.IsNullOrEmpty(row.Cells[0].Text) ? row.Cells[1].Text : row.Cells[0].Text);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" + inherit + "')"); 
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dpt_id"></param>
    /// <returns></returns>
    private Decimal InheritorsCount()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "select count(*) from v_dpt_inheritors where dpt_id = :dpt_id";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToString(Request["dpt_id"]), ParameterDirection.Input);

            return Convert.ToDecimal(cmd.ExecuteScalar());
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
    protected void dsAttributeIncome_DataBinding(object sender, EventArgs e)
    {
        if (sender != null)
        {
            ((Bars.DataComponents.BarsSqlDataSourceEx)sender).ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            ((Bars.DataComponents.BarsSqlDataSourceEx)sender).PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void dsAttributeIncome_Init(object sender, EventArgs e)
    {
        if (sender != null)
        {
            ((Bars.DataComponents.BarsSqlDataSourceEx)sender).ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            ((Bars.DataComponents.BarsSqlDataSourceEx)sender).PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvInheritor_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gridInheritors.SelectedIndex = -1;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvInheritor_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gridInheritors.SelectedIndex = -1;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvInheritor_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
            gridInheritors.SelectedIndex = -1;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gridInheritors_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        fvInheritor.ChangeMode(FormViewMode.Edit);
    }

}
