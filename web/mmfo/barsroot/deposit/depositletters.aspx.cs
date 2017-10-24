using System;
using System.Data;
using System.Drawing;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using Bars.Oracle;
using BarsWeb.Core.Logger;

/// <summary>
/// Summary description for DepositLetters.
/// </summary>
public partial class DepositLetters : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public DepositLetters()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

	protected System.Data.DataSet dsLetters;
	protected Oracle.DataAccess.Client.OracleDataAdapter adapterLettersSearch;
	private int row_counter = 0;

    private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositLetters;
		btForm.Attributes["onclick"] = "javascript:ckLetter();";

		RegisterClientScript();

		OracleConnection connect = new OracleConnection();
		try
		{
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			// ������������� ����
			OracleCommand cmdSetRole = new OracleCommand();
			cmdSetRole.Connection = connect;
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");

			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdGetLetters = connect.CreateCommand();
			cmdGetLetters.CommandText = "select doc_scheme_id, comments from dpt_letters where status=1 ";

			adapterLettersSearch = new OracleDataAdapter();
			adapterLettersSearch.SelectCommand = cmdGetLetters;
			adapterLettersSearch.Fill(dsLetters);

			gridLetters.DataSource = dsLetters;
			gridLetters.DataBind();

			gridLetters.HeaderStyle.BackColor = Color.Gray;
			gridLetters.HeaderStyle.Font.Bold = true;
			gridLetters.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;	
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}
	}

    /// <summary>
    /// ����������� DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        if (gridLetters.Controls.Count > 0)
        {
            Table tb = gridLetters.Controls[0] as Table;
            tb.Rows[0].Cells[0].Text = Resources.Deposit.GlobalResources.tb13;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb14;
        }
    }

	#region Web Form Designer generated code
	override protected void OnInit(EventArgs e)
	{
		//
		// CODEGEN: This call is required by the ASP.NET Web Form Designer.
		//
		InitializeComponent();
		base.OnInit(e);
	}
	
	/// <summary>
	/// Required method for Designer support - do not modify
	/// the contents of this method with the code editor.
	/// </summary>
	private void InitializeComponent()
	{    
		this.dsLetters = new System.Data.DataSet();
		((System.ComponentModel.ISupportInitialize)(this.dsLetters)).BeginInit();
		this.gridLetters.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridLetters_ItemDataBound);
		this.btForm.ServerClick += new System.EventHandler(this.btForm_ServerClick);
		// 
		// dsLetters
		// 
		this.dsLetters.DataSetName = "NewDataSet";
		this.dsLetters.Locale = new System.Globalization.CultureInfo("uk-UA");
		;
		((System.ComponentModel.ISupportInitialize)(this.dsLetters)).EndInit();

	}
	#endregion
	/// <summary>
	/// �볺������� �����, ����
	/// ��� ����� ����� �������
	/// ������ ���� ��������
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
			 document.getElementById('letter_id').value = val;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script", script);
	}
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void gridLetters_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
		{
			row_counter++;
			string row_id = "r_" + row_counter.ToString();
			DataGridItem row = e.Item;
			row.Attributes.Add("id", row_id);
			row.Attributes.Add("onclick", "S_A('"+row_counter.ToString()+"','"+row.Cells[0].Text + "')");
		}
	}
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btForm_ServerClick(object sender, System.EventArgs e)
	{
		String letterid = Convert.ToString(letter_id.Value);
		if (letterid != String.Empty)
		{
			_dbLogger.Info("������������ ������ ������ ����� " + letterid
				 + " ��� ������������."
				,"deposit");
			
			Response.Redirect("DepositLettersPrint.aspx?template=" + letterid);
		}
		else
		{
            Response.Write(Resources.Deposit.GlobalResources.al30);
			Response.Flush();
		}
	}
}
