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
using Bars.Oracle;
using Bars.Logger;
using Oracle.DataAccess.Client;

/// <summary>
/// Депозитний модуль: Вибір документів для підпису
/// </summary>
public partial class DepositDialog : Bars.BarsPage
{
	protected System.Data.DataSet dsDocs;
	protected Oracle.DataAccess.Client.OracleDataAdapter adapterSearchDoc;

	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositSignDialog;
		if (Request["dpt_id"]==null)
			return;

		OracleConnection connect = new OracleConnection();
		Decimal dpt_id = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));

		btSelect.Attributes["onclick"] = "javascript:if (getTemplatesToSign())";

		try
		{
			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = connect.CreateCommand();
			cmdSearch.CommandText = "select null,id,nd,to_char(version,'dd/mm/yyyy'),state-1 from cc_docs " +
				"where nd=:dpt_id and adds=0";
			cmdSearch.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id,ParameterDirection.Input);
			
			adapterSearchDoc = new OracleDataAdapter();
			adapterSearchDoc.SelectCommand = cmdSearch;
			dsDocs.Dispose();
			dsDocs = new DataSet();
			adapterSearchDoc.Fill(dsDocs);

			dsDocs.Tables[0].Columns[0].ColumnName = "*";
			dsDocs.Tables[0].Columns[1].ColumnName = "Шаблон";
			dsDocs.Tables[0].Columns[2].ColumnName = "№";
			dsDocs.Tables[0].Columns[3].ColumnName = "Версия";
			dsDocs.Tables[0].Columns[4].ColumnName = "Подписан";
		
			gridTemplates.DataSource = dsDocs;
			gridTemplates.DataBind();
			gridTemplates.HeaderStyle.BackColor = Color.Gray;
			gridTemplates.HeaderStyle.Font.Bold = true;
			gridTemplates.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;				 
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}
	}

    /// <summary>
    /// Локализация DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем грид
        if (gridTemplates.Controls.Count > 0)
        {
            Table tb = gridTemplates.Controls[0] as Table;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb98;
            tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb99;
            tb.Rows[0].Cells[4].Text = Resources.Deposit.GlobalResources.tb100;
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
		this.dsDocs = new System.Data.DataSet();
		((System.ComponentModel.ISupportInitialize)(this.dsDocs)).BeginInit();
		// 
		// dsDocs
		// 
		this.dsDocs.DataSetName = "NewDataSet";
		this.dsDocs.Locale = new System.Globalization.CultureInfo("uk-UA");
		this.gridTemplates.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridTemplates_ItemDataBound);
		this.btSelect.ServerClick += new System.EventHandler(this.btSelect_ServerClick);
		((System.ComponentModel.ISupportInitialize)(this.dsDocs)).EndInit();

	}
	#endregion
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void gridTemplates_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
		{
			CheckBox ck = new CheckBox();				
			DataGridItem row = e.Item;
			
			if (row.Cells[4].Text=="1")
			{
				ck.Checked = true;
				ck.Enabled = false;
			}
			else
				ck.Checked = false;
			ck.Attributes["onclick"] = "javascript:getDocsToSign('" + row.Cells[1].Text + "');";
			row.Cells[0].Controls.Add(ck);
		}
	}

	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btSelect_ServerClick(object sender, System.EventArgs e)
	{
		String val = Convert.ToString(templ.Value);
		String[] templates = val.Split(',');

		Deposit dpt = new Deposit(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));

		foreach (String dat in templates)
		{
			dpt.SignContract(dat);
		}

		Page_Load(sender,e);

        Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al39 + "');</script>");
        //Response.Write("<script>alert('Выбраные документы были успешно подписаны!');</script>");
		Response.Flush();
	}
}

