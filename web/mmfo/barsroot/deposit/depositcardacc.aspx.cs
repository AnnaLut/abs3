﻿using System;
using System.Data;
using System.Drawing;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
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

        if (Request["rnk"] == null)
        {
            gridCardAcc.Visible = false;
            return;
        }

        if (Request["cur_id"] == null)
        {
            gridCardAcc.Visible = false;
            return;
        }
		
        ReadInfo(Request.QueryString["type"]);
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
	private void ReadInfo(String AccType)
	{
		OracleConnection connect = new OracleConnection();
		try 
		{
			// Создаем соединение
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
		
			OracleCommand cmdGetCardAcc = connect.CreateCommand();

            if (AccType == "BPK")
            {
                cmdGetCardAcc.CommandText =
                    "select '<A href=# onclick=\"returnAcc('''||bankcode||''','''||balacc||''','''||replace(custname,'''','`')||''','''||custcode||''')\">Вибрати</a>', " +
                    "       cardnum, balacc, currency, custname, bankcode, custcode " +
                    "  from V_CARDACCOUNTS " +
                    " where custid = :RNK and currency = :cur_id ";
            }
            else
            {
           if (Request["mode"] == "cardn")
                {
                    cmdGetCardAcc.CommandText =
                    "select '<A href=# onclick=\"returnAcc('''||bankcode||''','''||balacc||''','''||replace(custname,'''','`')||''','''||custcode||''')\">Вибрати</a>', " +
                    "       cardnum, balacc, currency, custname, bankcode, custcode " +
                    "  from ( " +
                    "        select a.acc as cardnum, a.nls as balacc, a.kv as currency, a.nms as custname, a.kf as bankcode, b.okpo as custcode " +
                    "          from ACCOUNTS a, customer b" +
                 "         where a.nbs in ('2620','2625') and a.dazs Is Null and a.RNK = b.RNK" +
                    "           and a.rnk = :rnk and a.kv =  :cur_id )"; 
                }
                else
                { 
                cmdGetCardAcc.CommandText =
                    "select '<A href=# onclick=\"returnAcc('''||bankcode||''','''||balacc||''','''||replace(custname,'''','`')||''','''||custcode||''')\">Вибрати</a>', " +
                    "       cardnum, balacc, currency, custname, bankcode, custcode " +
                    "  from ( select cardnum, balacc, currency, custname, bankcode, custcode " +
                    "          from V_CARDACCOUNTS " +
                    "         where custid = :rnk and currency = :cur_id " +
                    "         union all " +
                    "        select a.acc, a.nls, a.kv, a.nms, a.kf, b.okpo " +
                    "          from ACCOUNTS a, customer b" +
                 "         where a.nbs in ('2620','2630','2635') and a.dazs Is Null and a.RNK = b.RNK" +
                    "           and a.rnk = :rnk and a.kv =  :cur_id )";
                }
            }

            cmdGetCardAcc.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToString(Request["rnk"]), ParameterDirection.Input);
            cmdGetCardAcc.Parameters.Add("cur_id", OracleDbType.Decimal, Convert.ToString(Request["cur_id"]), ParameterDirection.Input);
			
			adapterSearchCard = new OracleDataAdapter();
			adapterSearchCard.SelectCommand = cmdGetCardAcc;
			adapterSearchCard.Fill(dsCards);

			dsCards.Tables[0].Columns[0].ColumnName = "*";
			dsCards.Tables[0].Columns[1].ColumnName = "№ договору";
			dsCards.Tables[0].Columns[2].ColumnName = "№ рахунку";
			dsCards.Tables[0].Columns[3].ColumnName = "Валюта";
            dsCards.Tables[0].Columns[4].ColumnName = "Клієнт";
            dsCards.Tables[0].Columns[5].ColumnName = "МФО";
            dsCards.Tables[0].Columns[6].ColumnName = "ОКПО";

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
