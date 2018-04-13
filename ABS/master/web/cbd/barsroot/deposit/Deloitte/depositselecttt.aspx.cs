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
using Bars.Logger;
using Bars.Oracle;
using Oracle.DataAccess.Client;

/// <summary>
/// Summary description for DepositSelectTT.
/// </summary>
public partial class DepositSelectTT : Bars.BarsPage
{
	protected System.Data.DataSet dsTT;
	private   OracleDataAdapter adapterSearchAgreement;
	private int row_counter = 0;
    /// <summary>
    /// 
    /// </summary>
    private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositSelectTT;
        OracleConnection connect = new OracleConnection();

		try
		{
            if (Request["dest"] == null)
			{
                //Response.Write(@"<script>alert('Тип опериции не определен!');
                Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al36 + @"');
					location.replace('..//barsweb/welcome.aspx');</script>");
				Response.Flush();
			}
			string action = Convert.ToString(Request["dest"]);

			if (Request["dpt_id"] == null)
				Response.Redirect("DepositSearch.aspx?&extended=0&action=" + action);
			
			Decimal dptid = Convert.ToDecimal(Request["dpt_id"]);
			dpt_id.Value = dptid.ToString();

			if (action == "percent")
			{
                lbInfo.Text = Resources.Deposit.GlobalResources.h01;
                //lbInfo.Text = "Допустимые операции для выплаты процентов";
				DBLogger.Info("Выбор операции для выплаты процентов по депозитному договору №" + dpt_id.ToString(),
					"deposit");
			}		
			else if (action == "close")
			{
                lbInfo.Text = Resources.Deposit.GlobalResources.h02;
                //lbInfo.Text = "Допустимые операции для возврата депозита";
				DBLogger.Info("Выбор операции для досрочного расторжения депозитного договора №" + dpt_id.ToString(),
					"deposit");
			}
            else if (action == "closep")
            {
                lbInfo.Text = Resources.Deposit.GlobalResources.h02;
                //lbInfo.Text = "Допустимые операции для возврата депозита";
                DBLogger.Info("Выбор операции для досрочного расторжения депозитного договора №" + dpt_id.ToString(),
                    "deposit");
            }
            else if (action == "payout")
            {
                // виплата вкладу готівкою в день завершення (ЕБП)
                lbInfo.Text = Resources.Deposit.GlobalResources.h02;
                DBLogger.Info("Вибір операції для виплати готівкою в день завершення депозиту №" + dpt_id.ToString(),
                    "deposit");
            }
            else if (action == "return")
			{
                lbInfo.Text = Resources.Deposit.GlobalResources.h02;
                //lbInfo.Text = "Допустимые операции для возврата депозита";
				DBLogger.Info("Выбор операции для выплаты по завершению депозитного договора №" + dpt_id.ToString(),
					"deposit");
			}
			else if (action == "returnp")
			{
                lbInfo.Text = Resources.Deposit.GlobalResources.h01;
                //lbInfo.Text = "Допустимые операции для выплаты процентов";
				DBLogger.Info("Выбор операции для выплаты по завершению депозитного договора №" + dpt_id.ToString(),
					"deposit");
			}
			else
			{
                //Response.Write(@"<script>alert('Тип опериции не определен!');
                Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al36 + @"');
					location.replace('..//barsweb/welcome.aspx');</script>");
				Response.Flush();
			}

			RegisterClientScript ();

			btSelect.Attributes["onclick"] = "javascript:if (tt_ck())";

            //if (Convert.ToString(Request["other"]) == "Y")
            //{
            //    Deposit dpt = new Deposit(dptid, true);
            //}
            //else
            //{
            //    Deposit dpt = new Deposit(dptid);
            //}

            //if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
            //{
            //    if (action == "percent" || action == "returnp")
            //    {
            //        /// Якщо у нас пролонгація - то дозволяємо вибрати касу
            //        /// знову ж таки по ексклюзивній просьбі Правексу
            //        if (dpt.EndDate.ToString("dd/MM/yyyy") != BankType.GetBankDate() || action != "percent")
            //        {
            //            if (dpt.IntReceiverAccount != String.Empty)
            //            {
            //                tt.Value = dpt.GetIntTT();
            //                btSelect_ServerClick(sender, e);
            //                return;
            //            }
            //        }
            //    }
            //    else if (action == "close" || action == "return")
            //    {
            //        if (dpt.RestReceiverAccount != String.Empty)
            //        {
            //            tt.Value = dpt.GetRestTT(); 
            //            btSelect_ServerClick(sender, e);
            //            return;
            //        }
            //    }
            //}

			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = new OracleCommand();
			cmdSetRole.Connection = connect;
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = new OracleCommand();
			cmdSearch.Connection = connect;

			string searchQuery = @"select op_type as tt, op_name as name, tt_cash
                from v_dpt_vidd_tts t, dpt_deposit d 
                where d.deposit_id = :dpt_id and d.vidd = t.dpttype_id
                and tt_id in ";

            if (action == "percent")
            {
                searchQuery += " (" + 
                    ((int)DPT_OP.OP_3).ToString()  + "," +
                    ((int)DPT_OP.OP_33).ToString() + "," +
                    ((int)DPT_OP.OP_43).ToString() + "," +
                    ((int)DPT_OP.OP_45).ToString() + "," +
                    ((int)DPT_OP.OP_46).ToString() + 
               " ) ";
            }
	    else if (action == "close")		
            {
                searchQuery += " (" +
                    ((int)DPT_OP.OP_21).ToString() + ", " +
                 // ((int)DPT_OP.OP_23).ToString() + ", " +
                    ((int)DPT_OP.OP_25).ToString() + ", " +
                    ((int)DPT_OP.OP_23).ToString() + ", " +//додані операцiї inga 24/10/2014 (Гуренко)
                    ((int)DPT_OP.OP_26).ToString() + ", " +//додані операцiї inga 24/10/2014 (Гуренко)
                    ((int)DPT_OP.OP_35).ToString() + ", " + //додана операція вибору каса/2625
                    ((int)DPT_OP.OP_33).ToString() + ") ";// inga 27/05/2014 BRSMAIN-2689  -включить "33" 28/10/2014 (Гуренко)
            }
            else if (action == "closep")
            {
                searchQuery += " (" +
                    ((int)DPT_OP.OP_3).ToString() + "," +
                    ((int)DPT_OP.OP_33).ToString() + "," +// PKR - исключить inga 29/07/2014 BRSMAIN-2689 -включить 28/10/2014 (Гуренко)
                    ((int)DPT_OP.OP_34).ToString() + "," +// DKR - добавить inga 27/05/2014 BRSMAIN-2689
                 // ((int)DPT_OP.OP_43).ToString() + "," +
                    ((int)DPT_OP.OP_23).ToString() + ", " +//додані операцiї inga 24/10/2014 (Гуренко)
                    ((int)DPT_OP.OP_26).ToString() + ", " +//додані операцiї inga 24/10/2014 (Гуренко)
                    ((int)DPT_OP.OP_45).ToString() + ") ";
            }

            else if (action == "payout")
            {
                 searchQuery += " (" + ((int)DPT_OP.OP_21).ToString() + ") ";
            }

            else if (action == "return")	
            {
                searchQuery += " (" +
                    ((int)DPT_OP.OP_21).ToString() + "," +
                    ((int)DPT_OP.OP_23).ToString() + "," +
                    ((int)DPT_OP.OP_25).ToString() + "," +
                    ((int)DPT_OP.OP_26).ToString() + "," +
                    ((int)DPT_OP.OP_33).ToString() + 
               " ) ";
            }
			else if (action == "returnp")	
            {
                searchQuery += " (" +
                    ((int)DPT_OP.OP_3).ToString()  + "," +
                    ((int)DPT_OP.OP_33).ToString() + "," +
                    ((int)DPT_OP.OP_43).ToString() + "," +
                    ((int)DPT_OP.OP_45).ToString() + "," +
                    ((int)DPT_OP.OP_46).ToString() +
               " ) ";
            }

            cmdSearch.CommandText = searchQuery;
			
			cmdSearch.Parameters.Add("dpt_id",OracleDbType.Decimal,dptid,ParameterDirection.Input);
			
			adapterSearchAgreement = new OracleDataAdapter();
			adapterSearchAgreement.SelectCommand = cmdSearch;
			adapterSearchAgreement.Fill(dsTT);

			gridTT.DataSource = dsTT;
			gridTT.DataBind();

			if (dsTT.Tables[0].Rows.Count == 1)
			{
				tt.Value = dsTT.Tables[0].Rows[0].ItemArray[0].ToString();
				btSelect_ServerClick(sender,e);
			}

			gridTT.HeaderStyle.BackColor = Color.Gray;
			gridTT.HeaderStyle.Font.Bold = true;
			gridTT.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;				 
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
        if (gridTT.Controls.Count > 0)
        {
            Table tb = gridTT.Controls[0] as Table;
            tb.Rows[0].Cells[0].Text = Resources.Deposit.GlobalResources.tb20;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb21;
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
		this.dsTT = new System.Data.DataSet();
		((System.ComponentModel.ISupportInitialize)(this.dsTT)).BeginInit();
		this.gridTT.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridTT_ItemDataBound);
		this.btSelect.ServerClick += new System.EventHandler(this.btSelect_ServerClick);
		// 
		// dsTT
		// 
		this.dsTT.DataSetName = "NewDataSet";
		this.dsTT.Locale = new System.Globalization.CultureInfo("uk-UA");
		;
		((System.ComponentModel.ISupportInitialize)(this.dsTT)).EndInit();

	}
	#endregion
    /// <summary>
    /// 
    /// </summary>
    private void btSelect_ServerClick(object sender, System.EventArgs e)
	{
		string dptid = Convert.ToString(dpt_id.Value);
		string _tt	 = Convert.ToString(tt.Value);
        string _tt_cash = Convert.ToString(tt_cash.Value);

		String rnk_tr = ((Request["rnk_tr"] != null) ? Request.QueryString["rnk_tr"] : String.Empty);

		string action = Convert.ToString(Request["dest"]);

		if ( dptid == String.Empty )
		{
			dptid = Convert.ToString(Request["dpt_id"]);
            if (dptid == String.Empty)
            {
                Response.Redirect("DepositSearch.aspx?&extended=0&action=" + action);
                return;
            }
		}

		if (_tt == String.Empty)
		{
            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al37 + "!');</script>");
            //Response.Write("<script>alert('Не выбрана операция!');</script>");
			return;
		}

        String url = String.Empty;

		if (action == "percent")
		{
			DBLogger.Info("Пользователь выбрал для выплаты процентов по депозиту №" + dptid +
				" операцию " + _tt,"deposit");

            if (Deposit.IsDemandDpt(Convert.ToDecimal(dptid)))
                url = "transfer.aspx?dpt_id=" + dptid + "&cash=" + _tt_cash + "&action=percent" + "&tt=" + _tt;
            else
			    url = "DepositPercentPay.aspx?dpt_id=" + dptid + "&tt=" + _tt;
			
			if (rnk_tr != String.Empty)
				url += "&rnk_tr=" + rnk_tr;

			if (Request["fp"]!=null)
				url += "&fp=rtf";

            url += ( "&other="+ Convert.ToString(Request["other"]) );
		}
		else if (action == "close")
		{
			DBLogger.Info("Пользователь выбрал для досрочной выплаты по депозиту №" + dptid +
				" операцию " + _tt,"deposit");

			url = "DepositClosePayIt.aspx?dpt_id=" + dptid + "&tt=" + _tt;

			if (Request["agr_id"] != null )
				url += "&agr_id=" + Convert.ToString(Request["agr_id"]);

			if (Request["next"]!= null)
				url += "&next=" + Convert.ToString(Request["next"]);

			if (Request["template"]!= null)
				url += "&template=" + Convert.ToString(Request["template"]);

			if (rnk_tr != String.Empty)
				url += "&rnk_tr=" + rnk_tr;

            if (Request["inherit_id"] != null)
                url += "&inherit_id=" + Convert.ToString(Request["inherit_id"]);

            if (Request["other"] != null)
                url += "&other=" + Request.QueryString["other"];
		}
        else if (action == "closep")
        {
            DBLogger.Info("Пользователь выбрал для досрочной выплаты(выплата процентов) по депозиту №" + dptid +
                " операцию " + _tt, "deposit");

            url = "DepositClosePayIt.aspx?dpt_id=" + dptid + "&tt=" + _tt;

            if (Request["agr_id"] != null)
                url += "&agr_id=" + Convert.ToString(Request["agr_id"]);
            if (Request["next"] != null)
                url += "&next=" + Convert.ToString(Request["next"]);
            if (Request["template"] != null)
                url += "&template=" + Convert.ToString(Request["template"]);
            if (rnk_tr != String.Empty)
                url += "&rnk_tr=" + rnk_tr;
            if (Request["inherit_id"] != null)
                url += "&inherit_id=" + Convert.ToString(Request["inherit_id"]);

            url += "&dest=closep";
        }
        else if (action == "payout")
        {
            // виплата вкладу готівкою в день завершення (ЕБП)
            DBLogger.Info("Користувач вибрав для виплати в день завершення по депозиту №" + dptid +
				" операцію " + _tt, "deposit");
            
            url = "DepositReturn.aspx?dpt_id=" + dptid + "&tt=" + _tt;

            if (rnk_tr != String.Empty)
                url += "&rnk_tr=" + rnk_tr;

            if (Request["inherit_id"] != null)
                url += "&inherit_id=" + Convert.ToString(Request["inherit_id"]);
        }

        else if (action == "return")
		{
			DBLogger.Info("Пользователь выбрал для выплаты по завершения по депозиту №" + dptid +
				" операцию " + _tt,"deposit");

            if (Request["inherit_id"] != null)
                url = "DepositReturn.aspx?dpt_id=" + dptid + "&tt=" + _tt;
            else if (Deposit.IsDemandDpt(Convert.ToDecimal(dptid)))
                url = "transfer.aspx?dpt_id=" + dptid + "&cash=" + _tt_cash + "&action=return" + "&tt=" + _tt;
            else
			    url = "DepositReturn.aspx?dpt_id=" + dptid + "&tt=" + _tt;

			if (rnk_tr != String.Empty)
				url += "&rnk_tr=" + rnk_tr;

            if (Request["inherit_id"] != null)
                url += "&inherit_id=" + Convert.ToString(Request["inherit_id"]);
		}
		else if (action == "returnp")
		{
			DBLogger.Info("Пользователь выбрал для выплаты по завершения по депозиту №" + dptid +
				" операцию " + _tt,"deposit");

			url = "DepositReturn.aspx?dpt_id=" + dptid + "&tt=" + _tt + "&per=cent";

			if (rnk_tr != String.Empty)
				url += "&rnk_tr=" + rnk_tr;

            if (Request["inherit_id"] != null)
                url += "&inherit_id=" + Convert.ToString(Request["inherit_id"]);
		}
		else
		{
            //Response.Write(@"<script>alert('Тип опериции не определен!');
            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al36 + @"');
					location.replace('..//barsweb/welcome.aspx');</script>");
            return;
		}

        // &scheme=DELOITTE
        if (Request["scheme"] != null)
            url += "&scheme=" + Request.QueryString["scheme"];

        Response.Redirect(url);
	}
	/// <summary>
	/// 
	/// </summary>
    private void RegisterClientScript ()
	{
		string script = @"<script language='javascript'>
			var selectedRow;
			function S(id,val,cash_val)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('tt').value = val;
             document.getElementById('tt_cash').value = cash_val;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script", script);
	}
    /// <summary>
    /// 
    /// </summary>
	private void gridTT_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
		{
			row_counter++;
			string row_id = "r_" + row_counter.ToString();
			DataGridItem row = e.Item;
			row.Attributes.Add("id", row_id);
			row.Attributes.Add("onclick", "S('"+row_counter.ToString()+"','"+row.Cells[0].Text+"','"+row.Cells[2].Text+"')");
		}
	}
}
