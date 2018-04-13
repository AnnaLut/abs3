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
            /*
            tb.Rows[0].Cells[0].Text = Resources.Deposit.GlobalResources.tb89;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb90;
            tb.Rows[0].Cells[2].Text = Resources.Deposit.GlobalResources.tb91;
            tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb92;
            */
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

			// Установка роли
			OracleCommand cmdSetRole = new OracleCommand();
			cmdSetRole.Connection = connect;
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetCardAcc = connect.CreateCommand();
            
            switch (Request["mode"])
            {
                case "cardn":
                                DBLogger.Info("Користувач зайшов на сторінку вибору рахунків клієнта для виплати депозиту та відсотків на карткові рахунки",
                        "deposit");
                        cmdGetCardAcc.CommandText =
                            "select '<A href=# onclick=\"returnAcc('''||bankcode||''','''||balacc||''','''||replace(custname,'''','`')||''','''||custcode||''')\">Вибрати</a>', " +
                            "       cardnum, balacc, currency, custname, bankcode, custcode " +
                            " from ( "+
                            " select distinct a.acc as cardnum, a.nls as balacc, A.KV as currency, A.NMS as custname, A.KF as bankcode, b.OKPO as custcode" +
                            " from ACCOUNTS a, customer b, saldo s " +
                            " where a.nbs in ('2620','2625') and a.dazs Is Null and a.RNK = b.RNK and s.acc = a.acc" +
                            " and a.rnk = :rnk and a.kv = 980 and A.BRANCH = sys_context('bars_context','user_branch') )";

                        cmdGetCardAcc.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToString(Request["rnk"]), ParameterDirection.Input);
                      //  cmdGetCardAcc.Parameters.Add("cur_id", OracleDbType.Decimal, Convert.ToString(Request["cur_id"]), ParameterDirection.Input);
                    break;

                case "pawn":
                        DBLogger.Info("Користувач зайшов на сторінку вибору рахунків клієнта для виплати депозиту та відсотків на кредитні рахунки",
                        "deposit");
                        cmdGetCardAcc.CommandText =
                            "select '<A href=# onclick=\"returnAcc('''||bankcode||''','''||balacc||''','''||replace(custname,'''','`')||''','''||custcode||''')\">Вибрати</a>', " +
                            "       cardnum, balacc, currency, custname, bankcode, custcode " +
                            " from (select distinct a.acc as cardnum, a.nls as balacc, A.KV as currency, A.NMS as custname, A.KF as bankcode, C.OKPO as custcode" +
                            "       from accounts a, customer c, cc_deal cc, nd_acc nd where a.rnk = c.rnk and cc.sos < 14 and A.NBS = 2620 and A.DAZS is null and cc.nd = nd.nd and nd.acc = a.acc" + 
                            " and a.rnk = :rnk and a.kv = 980)";

                        cmdGetCardAcc.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToString(Request["rnk"]), ParameterDirection.Input);                        
			        break;

                
                default:
                DBLogger.Info("Користувач зайшов на сторінку вибору рахунків клієнта для виплати депозиту та відсотків на депозитні/поточні рахунки",
                "deposit");
                    if  (Convert.ToString(Request["type"]) == "BPK190")
                    {
                        cmdGetCardAcc.CommandText =
                        "select '<A href=# onclick=\"returnAcc('''||bankcode||''','''||balacc||''','''||replace(custname,'''','`')||''','''||custcode||''')\">Вибрати</a>', " +
                        "       cardnum, balacc, currency, custname, bankcode, custcode " +
                        "  from V_CARDACCOUNTS_190 " +
                        " where custid = :RNK and currency = :cur_id ";
                        cmdGetCardAcc.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToString(Request["rnk"]), ParameterDirection.Input);
                        cmdGetCardAcc.Parameters.Add("cur_id", OracleDbType.Decimal, Convert.ToString(Request["cur_id"]), ParameterDirection.Input);
                    }
                    else 
                    {
                        cmdGetCardAcc.CommandText =
                            "select '<A href=# onclick=\"returnAcc('''||bankcode||''','''||balacc||''','''||replace(custname,'''','`')||''','''||custcode||''')\">Вибрати</a>', " +
                            "       cardnum, balacc, currency, custname, bankcode, custcode " +
                            " from (select cardnum, balacc, currency, custname, bankcode, custcode from V_CARDACCOUNTS " +
                            " where custid = :RNK and currency = :cur_id " +
                            " union all " +
                            " select a.acc, a.nls, a.kv, a.nms, a.kf, b.okpo " +
                            " from ACCOUNTS a, customer b" +
                            " where a.nbs in ('2630','2635','2620') and a.dazs Is Null and a.RNK = b.RNK" +
                            " and a.rnk = :rnk and a.kv =  :cur_id)";

                        cmdGetCardAcc.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToString(Request["rnk"]), ParameterDirection.Input);
                        cmdGetCardAcc.Parameters.Add("cur_id", OracleDbType.Decimal, Convert.ToString(Request["cur_id"]), ParameterDirection.Input);
                    }			                    
            break;
			}
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
