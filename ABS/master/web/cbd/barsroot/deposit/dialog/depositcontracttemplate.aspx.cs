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

/// <summary>
/// Депозитний модуль: Вибір шаблонів договорів
/// </summary>
public partial class DepositContractTemplate : Bars.BarsPage
{
    protected System.Data.DataSet dsTemplates;
	protected Oracle.DataAccess.Client.OracleDataAdapter adapterSearchTemplate;

    private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositContractTemplate;
		if (Request["vidd"]==null)
			return;

		OracleConnection connect = new OracleConnection();
		Decimal vidd = Convert.ToDecimal(Convert.ToString(Request["vidd"]));

		try
		{
			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = new OracleCommand();
			cmdSetRole.Connection = connect;
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = connect.CreateCommand();
			cmdSearch.CommandText = "select null,vs.id,ds.name from dpt_vidd_scheme vs, doc_scheme ds where vs.vidd = :vidd and vs.flags = 1 and ds.id=vs.id order by id";
			cmdSearch.Parameters.Add("vidd",OracleDbType.Decimal,vidd,ParameterDirection.Input);
			
			adapterSearchTemplate = new OracleDataAdapter();
			adapterSearchTemplate.SelectCommand = cmdSearch;
			adapterSearchTemplate.Fill(dsTemplates);

			dsTemplates.Tables[0].Columns[0].ColumnName = "*";
			dsTemplates.Tables[0].Columns[1].ColumnName = "Шаблон";
            dsTemplates.Tables[0].Columns[2].ColumnName = "Назва";
		
			gridTemplates.DataSource = dsTemplates;
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
		this.dsTemplates = new System.Data.DataSet();
		((System.ComponentModel.ISupportInitialize)(this.dsTemplates)).BeginInit();
		this.gridTemplates.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridTemplates_ItemDataBound);
		// 
		// dsTemplates
		// 
		this.dsTemplates.DataSetName = "NewDataSet";
		this.dsTemplates.Locale = new System.Globalization.CultureInfo("uk-UA");
		((System.ComponentModel.ISupportInitialize)(this.dsTemplates)).EndInit();
	}
	#endregion

	private void gridTemplates_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
		{
			CheckBox ck = new CheckBox();
			DataGridItem row = e.Item;
			ck.Attributes.Add("onclick","Sel('"+row.Cells[1].Text+"')");
			row.Cells[0].Controls.Add(ck);
		}
	}
}
