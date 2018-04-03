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
using Bars.Logger;
using Bars.Oracle;

/// <summary>
/// Summary description for DepositCardAcc.
/// </summary>
public partial class DepositCardAcc : Bars.BarsPage
{
	protected Oracle.DataAccess.Client.OracleDataAdapter adapterSearchCard;
	protected System.Data.DataSet dsCards;
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositCardAcc;
		if (Request["mfo"] == null)
		{
			gridCardAcc.Visible = false;
			return;
		}
		if (Request["okpo"] == null)
		{
			gridCardAcc.Visible = false;
			return;
		}
			
		ReadInfo();
	}
    /// <summary>
    /// Локализация DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем грид
        if (gridCardAcc.Controls.Count > 0)
        {
            Table tb = gridCardAcc.Controls[0] as Table;
            tb.Rows[0].Cells[0].Text = Resources.Deposit.GlobalResources.tb89;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb90;
            tb.Rows[0].Cells[2].Text = Resources.Deposit.GlobalResources.tb91;
            tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb92;
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
		this.dsCards = new System.Data.DataSet();
		((System.ComponentModel.ISupportInitialize)(this.dsCards)).BeginInit();
		// 
		// dsCards
		// 
		this.dsCards.DataSetName = "NewDataSet";
		this.dsCards.Locale = new System.Globalization.CultureInfo("uk-UA");
		;
		((System.ComponentModel.ISupportInitialize)(this.dsCards)).EndInit();

	}
	#endregion
	/// <summary>
	/// 
	/// </summary>
	private void ReadInfo()
	{
		OracleConnection connect = new OracleConnection();
		try 
		{
			// Создаем соединение
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			// Открываем соединение с БД
			

			// Установка роли
			OracleCommand cmdSetRole = new OracleCommand();
			cmdSetRole.Connection = connect;
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery(); 

			OracleCommand cmdGetCardAcc = connect.CreateCommand();
            cmdGetCardAcc.CommandText =
                " select '<A href=# onclick=\"returnAcc('''||balacc||''','''||bankcode||''','''||custcode||''','''||replace(custname,'''','`')||''')\">Вибрати</a>', " +
                " cardnum, balacc, currency, custname, custcode, bankcode " +
                " from v_cardaccounts " +
                " where (custcode = :OKPO or custid = :RNK) and currency = :cur_id ";

            cmdGetCardAcc.Parameters.Add("okpo",OracleDbType.Varchar2,Convert.ToString(Request["okpo"]),ParameterDirection.Input);
            cmdGetCardAcc.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToString(Request["rnk"]), ParameterDirection.Input);
            cmdGetCardAcc.Parameters.Add("cur_id", OracleDbType.Decimal, Convert.ToString(Request["cur_id"]), ParameterDirection.Input);
			
			adapterSearchCard = new OracleDataAdapter();
			adapterSearchCard.SelectCommand = cmdGetCardAcc;
			adapterSearchCard.Fill(dsCards);

			dsCards.Tables[0].Columns[0].ColumnName = "*";
			dsCards.Tables[0].Columns[1].ColumnName = "Картковий";
			dsCards.Tables[0].Columns[2].ColumnName = "Балансовий";
			dsCards.Tables[0].Columns[3].ColumnName = "Валюта";
            dsCards.Tables[0].Columns[4].ColumnName = "Клієнт";
            dsCards.Tables[0].Columns[5].ColumnName = "Ід. код";
            dsCards.Tables[0].Columns[6].ColumnName = "МФО";

			gridCardAcc.DataSource = dsCards;
			gridCardAcc.DataBind();

			gridCardAcc.HeaderStyle.BackColor = Color.Gray;
			gridCardAcc.HeaderStyle.Font.Bold = true;
			gridCardAcc.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;	
		}
		finally
		{
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}
	}
}
