using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using Bars.Oracle;
using Bars.Logger;
using Bars.Classes;

/// <summary>
/// 
/// </summary>
public partial class DepositFileShow : Bars.BarsPage
{
	private int row_counter = 0;
	/// <summary>
	/// 
	/// </summary>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositFileShow;
		RegisterClientScript();

        if (Request["delete"] == null)
            btDelete.Visible = false;
	}
    /// <summary>
    /// 
    /// </summary>
	override protected void OnInit(EventArgs e)
	{
        dsFiles.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsFiles.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

		InitializeComponent();
		base.OnInit(e);
	}
	
	/// <summary>
	/// Required method for Designer support - do not modify
	/// the contents of this method with the code editor.
	/// </summary>
	private void InitializeComponent()
	{    
	}
	/// <summary>
	/// Клієнтський скріпт, який
	/// при виборі рядка таблиці
	/// виділяє його кольором
	/// </summary>
	private void RegisterClientScript()
	{
		string script = @"<script language='javascript'>
			var selectedRow;
			function S_A(id, header_id, can_copy, filename, dat, can_delete)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
             
             document.getElementById('header_id').value = header_id;
             
             if (can_copy == '0') 
             {
                document.getElementById('btCopy').disabled = 'disabled';
             }
             else 
             {
                document.getElementById('btCopy').disabled = '';
                document.getElementById('filename').value = filename;
                document.getElementById('dat').value = dat;
             }

             if (document.getElementById('btDelete'))
             {
                 if (can_delete == '1')
                 {
                    document.getElementById('btDelete').disabled = '';
                 }
                 else
                 {
                    document.getElementById('btDelete').disabled = 'disabled';
                 }
             }
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
	}
	/// <summary>
	/// 
	/// </summary>
    protected void gridFiles_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;
            
            
            
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" +
                ((DataRowView)row.DataItem).Row[5].ToString() + "','" +
                (row.Cells[2].Text[0] == '.' ? 1 : 0) + "','" +
                ((DataRowView)row.DataItem).Row[0].ToString() + "','" +
                ((DataRowView)row.DataItem).Row[6].ToString() + "','" +
                ((DataRowView)row.DataItem).Row[7].ToString() +
                "')");

            row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[2].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[3].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
        }
    }
    protected void btCopy_ServerClick(object sender, EventArgs e)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            Decimal new_header_id = Decimal.MinValue;
            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "begin dpt_social.file_copy(:p_header_id,:p_header_id_new); end;";
            cmd.Parameters.Add("p_header_id", OracleDbType.Decimal, header_id.Value, ParameterDirection.Input);
            cmd.Parameters.Add("p_header_id_new", OracleDbType.Decimal, new_header_id, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            new_header_id = Convert.ToDecimal(Convert.ToString(cmd.Parameters["p_header_id_new"].Value));

            if (new_header_id != decimal.MinValue)
            {
                BankFile.CopyAdjustDptFileHeader(new_header_id);

                Session["BF_HEADER_ID"] = new_header_id;
                Session["BF_FILENAME"] = filename.Value;
                Session["BF_DAT"] = dat.Value;

                Response.Write("<script>alert('Файл був успішно скопійований. Id нового файла = " +
                    Convert.ToString(new_header_id) + " '); location.replace('depositfile.aspx?mode=copy');</script>");
            }
            else
                Response.Write("<script>alert('Файл не можна копіювати!')</script>");

        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    protected void btDelete_ServerClick(object sender, EventArgs e)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            Decimal new_header_id = Decimal.MinValue;
            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "begin dpt_social.file_delete(:p_header_id); end;";
            cmd.Parameters.Add("p_header_id", OracleDbType.Decimal, header_id.Value, ParameterDirection.Input);

            cmd.ExecuteNonQuery();

            gridFiles.DataBind();

            Response.Write("<script>alert('Файл був успішно видалений.');</script>");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
}
