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
using Oracle.DataAccess.Types;
using Bars.Oracle;
using Bars.Logger;
using Bars.Classes;

/// <summary>
/// Summary description for DepositSearch.
/// </summary>
public partial class DepositSearch : Bars.BarsPage
{
	private int row_counter = 0;  
    /// <summary>
	/// Завантаження сторінки
	/// </summary>
	private void Page_Load(object sender, System.EventArgs e)
	{      
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositSearch;
		textDepositId.Attributes["onblur"]	= "javascript:doValueCheck(\"textDepositId\")";
		//textDepositNum.Attributes["onblur"]	= "javascript:doValueCheck(\"textDepositNum\")";
		textClientId.Attributes["onblur"]	= "javascript:doValueCheck(\"textClientId\")";
		//textAccount.Attributes["onblur"]	= "javascript:doValueCheck(\"textAccount\")";
		textClientCode.Attributes["onblur"]	= "javascript:doValueCheck(\"textClientCode\")";
		DocNumber.Attributes["onblur"]		= "javascript:doValueCheck(\"DocNumber\")";
		btSelect.Attributes["onclick"]		= "javascript:if (ckDpt_id())";
			
		RegisterClientScript();
		
		string action = Convert.ToString(this.Request.Params.Get("action"));

        String el = String.Empty;

        switch(action) 
		{
			case "edit":
                el = Resources.Deposit.GlobalResources.sh01;
				//lbSearchInfo.Text = "Поиск депозитного договора для редактирования счетов выплаты";
				break;
			case "print":
                el = Resources.Deposit.GlobalResources.sh02;
				//lbSearchInfo.Text = "Поиск депозитного договора для печати";
				break;
			case "show":
                el = Resources.Deposit.GlobalResources.sh03;
				//lbSearchInfo.Text = "Поиск депозитного договора для просмотра";
				break;

            case "earlyreturn": // Пошук депозиту для дострокового повернення (ЕБП Ощадбанк) 
            case "close":       // Поиск депозитного договора для досрочного расторжения
                el = Resources.Deposit.GlobalResources.sh04;
				break;

			case "percent":
                el = Resources.Deposit.GlobalResources.sh05;
				//lbSearchInfo.Text = "Поиск депозитного договора для выплаты процентов";
				break;

            case "payout":   // Пошук депозиту для виплати в день завершення (ЕБП Ощадбанк)
            case "deposit":  // Поиск депозитного договора для выплаты после завершения
                el = Resources.Deposit.GlobalResources.sh06;
				break;

			case "delete":
                el = Resources.Deposit.GlobalResources.sh07;
				//lbSearchInfo.Text = "Поиск депозитного договора для удаления";
				break;
			case "history":
                el = Resources.Deposit.GlobalResources.sh08;
				//lbSearchInfo.Text = "Поиск депозитного договора для просмотра истории";
				break;
			case "prolongation":
                el = Resources.Deposit.GlobalResources.sh09;
				//lbSearchInfo.Text = "Поиск депозитного договора для пролонгации";
				break;
			case "agreement":
                el = Resources.Deposit.GlobalResources.sh10;
				//lbSearchInfo.Text = "Поиск депозитного договора для оформления доп. соглашения";
				break;
			case "rateedit":
                el = Resources.Deposit.GlobalResources.sh11;
				//lbSearchInfo.Text = "Поиск депозитного договора для изменения процентной ставки";
				break;
            case "testament":
                el = Resources.Deposit.GlobalResources.sh12;
                //lbSearchInfo.Text = "Поиск депозитного договора для регистрации свидетельств о праве на наследство";
                break;
            case "cancelextention":
                el = Resources.Deposit.GlobalResources.sh0;
                //lbSearchInfo.Text = "Поиск депозитного договора для отказа от переоформления вклада";
                break;
            case "replenish":
                el = Resources.Deposit.GlobalResources.sh13;
                //lbSearchInfo.Text = "Пошук депозитного договору для поповнення";
                break;
        }

        lbSearchInfo.Text = el;

		if (!IsPostBack)
		{
			dptid.Value = "";
		}
	}
    /// <summary>
    /// 
    /// </summary>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { FillGrid(false);}
        
        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    /// <summary>
    /// Локализация DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем infra
        bDate.ToolTip = Resources.Deposit.GlobalResources.tb11;
        btSearch.Value = Resources.Deposit.GlobalResources.tb12;

        // Локализируем грид        
        //if (gvSearch != null && gvSearch.Controls.Count > 0)
        //{
        //    Table tb = gvSearch.Controls[0] as Table;
        //    tb.Rows[0].Cells[0].Text = Resources.Deposit.GlobalResources.tb1;
        //    tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb2;
        //    tb.Rows[0].Cells[2].Text = Resources.Deposit.GlobalResources.tb3;
        //    tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb4;
        //    tb.Rows[0].Cells[4].Text = Resources.Deposit.GlobalResources.tb5;
        //    tb.Rows[0].Cells[5].Text = Resources.Deposit.GlobalResources.tb6;
        //    tb.Rows[0].Cells[6].Text = Resources.Deposit.GlobalResources.tb7;
        //    tb.Rows[0].Cells[7].Text = Resources.Deposit.GlobalResources.tb8;
        //    tb.Rows[0].Cells[8].Text = Resources.Deposit.GlobalResources.tb9;
        //    tb.Rows[0].Cells[9].Text = Resources.Deposit.GlobalResources.tb10;
        //}
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
		this.btSearch.ServerClick += new System.EventHandler(this.btSearch_ServerClick);
		this.btSelect.ServerClick += new System.EventHandler(this.btSelect_ServerClick);
	}
	#endregion
	/// <summary>
	/// Клієнтський скріпт, який
	/// при виборі рядка таблиці
	/// виділяє його кольором
	/// </summary>
	private void RegisterClientScript()
	{
		string script = @"<script language='javascript'>
			var selectedRow;
			function S_A(id, val)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('dptid').value = val;
			}
			</script>";
		ClientScript.RegisterStartupScript(this.GetType(),ID+"Script_A",script );
	}
	/// <summary>
	/// Вибір договора
	/// </summary>
	private void btSelect_ServerClick(object sender, System.EventArgs e)
	{
		Decimal dpt_id = Decimal.MinValue;

		dpt_id = Convert.ToDecimal(dptid.Value);
        
        Session["DPTPRINT_DPTID"] = dpt_id;
        Session["DPTPRINT_AGRID"] = null;
        Session["DPTPRINT_TEMPLATE"] = null;
        Session["DPTPRINT_AGRNUM"] = null;

        Session["DPT_ID"] = dpt_id;
        Session["DPT_NUM"] = Deposit.GetDptNum(dpt_id);

		dptid.Value = "";

		DBLogger.Info("Пользователь выбрал депозитный договор №" + dpt_id.ToString(), "deposit");

		string action = this.Request.Params.Get("action").ToString();

		switch (action)
		{
			case "print":
			{
				Response.Write("<script>window.showModalDialog('DepositPrint.aspx?dpt_id=" + dpt_id + "',null,'dialogWidth:800px; dialogHeight:800px; center:yes; status:no');</script>");
				Response.Flush();
				break;
			}
			case "show":
			{
				Deposit dpt = new Deposit(dpt_id);
				Session["DepositInfo"] = dpt;
				Response.Redirect("DepositContractInfo.aspx?next=DepositSearch.aspx&action=show");
				break;
			}
			case "percent":
				Response.Redirect("DepositSelectTrustee.aspx?dpt_id=" + dpt_id + "&dest=percent"
                    + ((Convert.ToDecimal(Request["extended"]) == 1) ? "&other=Y" : "") );
				break;

            case "earlyreturn":  // Пошук депозиту для дострокового повернення (ЕБП)
                Response.Redirect("/barsroot/deposit/deloitte/DepositSelectTrustee.aspx?dpt_id=" + dpt_id.ToString() +
                    "&dest=close&scheme=DELOITTE");
                break;

            case "close":
				Response.Redirect("DepositSelectTrustee.aspx?dpt_id=" + dpt_id + "&dest=close");
				break;

            case "payout":   // Пошук депозиту для виплати в день завершення (ЕБП)
                Response.Redirect("/barsroot/deposit/deloitte/DepositSelectTrustee.aspx?dpt_id=" + dpt_id.ToString() +
                    "&dest=payout&scheme=DELOITTE");
				break;

			case "deposit":
				Response.Redirect("DepositSelectTrustee.aspx?dpt_id=" + dpt_id + "&dest=deposit");
				break;

			case "agreement":
				Response.Redirect("DepositSelectTrustee.aspx?dpt_id=" + dpt_id + "&dest=agreement");
				break;

            case "agreement4other":
                Response.Redirect("DepositSelectTrustee.aspx?dpt_id=" + dpt_id + "&dest=agreement" + "&other=Y");
				break;

			case "prolongation":
				Response.Redirect("DepositSelectTrustee.aspx?dpt_id=" + dpt_id + "&dest=prolongation");
				break;

			case "delete":
				Response.Redirect("DepositDelete.aspx?dpt_id=" + dpt_id);
				break;
			case "history":
				Response.Redirect("DepositHistory.aspx?dpt_id=" + dpt_id);
				break;
            //case "rateedit":
            //{
            //    if (BankType.GetCurrentBank() == BANKTYPE.UPB)
            //        Response.Redirect("DepositRateEdit.aspx?dpt_id=" + dpt_id);
            //    else
            //        Response.Redirect("/barsroot/barsweb/welcome.aspx");
            //    break;
            //}
            case "testament":
                Response.Redirect("depositpartial.aspx?dpt_id=" + dpt_id);
                break;

            case "cancelextention":
                Response.Redirect("depositextention.aspx");
                break;

            case "replenish":   // Пошук депозиту для поповнення (ЕБП)
                Response.Redirect("/barsroot/deposit/deloitte/DepositAddSum.aspx?dpt_id=" + dpt_id);
                break;

			default:
                Response.Redirect("/barsroot/barsweb/welcome.aspx");
				break;
		}		
	}
	/// <summary>
	/// Пошук депозитних договорів
	/// </summary>
	private void btSearch_ServerClick(object sender, System.EventArgs e)
	{
        FillGrid(true);

        if (gvSearch.Rows.Count == 1)
        {
            dptid.Value = gvSearch.Rows[0].Cells[1].Text;
            btSelect_ServerClick(sender, e);
        }
	}
    /// <summary>
    /// Наповнення
    /// </summary>
    private void FillGrid(bool btSearchPressed)
    {
        /// Microsoft SqlDataSource неправильно біндить
        /// параметри типу String.  Тому мусимо їх вставляти 
        /// в текст команди

        if (CheckSearchParams() == 0)
        {
            Random r = new Random();
            Response.Write("<script> window.showModalDialog('dialog.aspx?type=err&rcode=" +
                Convert.ToString(r.Next()) +
                "','','dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;'); </script>");
            Response.Flush();
            return;
        }
        
        dsSearch.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsSearch.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        string searchQuery = @"SELECT P.DPT_NUM DPT_NUM, P.DPT_ID d_id, P.VIDD_NAME type_name, P.DAT_BEGIN datz, P.DAT_END dat_end,
            P.CUST_ID rnk, P.CUST_IDCODE okpo, P.CUST_NAME nmk, P.DPT_ACCNUM nls, P.DPT_CURCODE lcv,
            to_char((P.DPT_SALDO/p.DPT_CUR_DENOM),'FM999G999G999G990D009') ostc,
            decode(P.DPT_ACCID,P.INT_ACCID,'0.00',to_char((P.INT_SALDO/DPT_CUR_DENOM),'FM999G999G999G990D009')) p_ostc, 
            to_char((P.INT_KOS/p.DPT_CUR_DENOM),'FM999G999G999G990D009') INT_KOS,
            to_char((P.INT_DOS/p.DPT_CUR_DENOM),'FM999G999G999G990D009') INT_DOS ";

        string action = Convert.ToString(Request["action"]);

        if (action == "delete")
            searchQuery += @"FROM v_dpt_portfolio_active P
            WHERE P.DPT_SALDO = 0 AND P.dat_begin = bankdate and P.VIDD_CODE > 0 ";

        else if (action == "deposit")
            searchQuery += @"FROM v_dpt_portfolio_active P
            WHERE (p.DAT_END IS NULL OR p.DAT_END <= BANKDATE AND p.DAT_END <= TRUNC(sysdate)) ";

        else if (action == "close")
            searchQuery += @"FROM v_dpt_portfolio_active P
            WHERE DAT_END > BANKDATE ";

        else if (action == "prolongation")
            searchQuery += @"FROM v_dpt_portfolio_active P, dpt_auto_extend ext
            WHERE P.DAT_END <= bankdate AND P.DPT_ID = ext.dpt_id";

        else if (action == "history")
            searchQuery += @"FROM v_dpt_portfolio P WHERE 1=1";

        else if (action == "testament")
            searchQuery = @"select p.dpt_id d_id, p.dpt_num, p.vidd_name type_name,
                p.dat_begin datz, p.dat_end dat_end, 
                p.cust_id rnk, 
                P.CUST_IDCODE okpo, P.DPT_ACCNUM nls, 
                p.cust_name nmk, p.dpt_curcode lcv, 
                to_char(p.DPT_SALDO/100,'9999999999990.99') ostc, 
                to_char(p.INT_SALDO/100,'9999999999990.99') p_ostc,
                to_char(P.INT_KOS/100,'999999999990.99') INT_KOS, to_char(P.INT_DOS/100,'999999999990.99') INT_DOS 
                from v_dpt_portfolio_active p where 1 = 1  "; //, v_dpt_no_inheritors d  
                //where p.DPT_ID = d.dpt_id";
           
        else if (action == "percent")
            if ( Convert.ToDecimal(Request["extended"]) == 1 )
                searchQuery += @"FROM v_dpt_portfolio_other  P WHERE 1=1 ";
            else
                searchQuery += @"FROM v_dpt_portfolio_active P WHERE 1=1 ";
        // Створення дод.угод по депозитах
        else if (action == "agreement")
            searchQuery += @"FROM v_dpt_portfolio_active P  WHERE (p.dat_end >= bankdate or p.dat_end is null) ";
        // Створення дод.угод по депозитах інших підрозділів
        else if (action == "agreement4other")
            searchQuery += @"FROM v_dpt_portfolio_other  P  WHERE (p.dat_end >= bankdate or p.dat_end is null) ";
        //
        else if (action == "cancelextention")
            searchQuery = @"select p.dpt_id d_id, p.dpt_num, p.vidd_name type_name,
                    p.dat_begin datz, p.dat_end, p.cust_id rnk,
                    p.cust_idcode okpo, p.dpt_accnum nls,
                    p.cust_name nmk, p.dpt_curcode lcv,
                    to_char(p.DPT_SALDO/100,'9999999999990.99') ostc,
                    to_char(p.INT_SALDO/100,'9999999999990.99') p_ostc,
                    to_char(p.INT_KOS/100,'999999999990.99') INT_KOS, 
                    to_char(p.INT_DOS/100,'999999999990.99') INT_DOS,
                    p.noextflag
               from v_dptext_pretenders p 
               where 1 = 1 ";
        
        // Поповнення вкладу
        else if (action == "replenish")
            searchQuery += @"FROM v_dpt_portfolio_all_active p
                WHERE ((DAT_END IS NULL) OR (DAT_END > BANKDATE)) ";
        
        // Пошук депозиту для виплати в день завершення (ЕБП)
        else if (action == "payout")
            searchQuery += @"FROM v_dpt_portfolio_all_active p
                WHERE p.dat_end BETWEEN (dat_next_u(BANKDATE, -1) + 1) And BANKDATE ";

        // Пошук депозиту для дострокового повернення (ЕБП)
        else if (action == "earlyreturn")
            searchQuery += @"FROM v_dpt_portfolio_all_active p
                WHERE p.DAT_END > BANKDATE
                  AND exists (select 1 from DPT_AGREEMENTS a where a.DPT_ID = p.DPT_ID 
                                 And a.AGRMNT_TYPE = 18 And a.BANKDATE = BANKDATE) ";

        else
            searchQuery += @"FROM v_dpt_portfolio_active P  WHERE 1=1";

        dsSearch.WhereParameters.Clear();
        dsSearch.SelectParameters.Clear();

        // УМОВИ ПОШУКУ
        //
        // По вкладчику (наименование)
        if (textClientName.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and upper(P.CUST_NAME) like :searchParam_clientName ";
                dsSearch.WhereParameters.Add("searchParam_clientName", TypeCode.String, textClientName.Text.ToUpper() + "%");
            }
            else
                searchQuery = searchQuery + " and upper(P.CUST_NAME) like '" + textClientName.Text.ToUpper() + "%' ";
        }
        // По иден. коду вкладчика
        if (textClientCode.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and P.CUST_IDCODE = :searchParam_clientCode ";
                dsSearch.WhereParameters.Add("searchParam_clientCode", TypeCode.String, textClientCode.Text);
            }
            else
                searchQuery = searchQuery + " and P.CUST_IDCODE = '" + textClientCode.Text + "' ";
        }
        // По дате рождения вкладчика
        if (bDate.Date != DateTime.MinValue)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and P.cust_birthdate = :searchParam_bDate";
                dsSearch.WhereParameters.Add("searchParam_bDate", TypeCode.DateTime, bDate.Date.ToString("dd/MM/yyyy"));
            }
            else
            {
                searchQuery = searchQuery + " and P.cust_birthdate = :searchParam_bDate";
                dsSearch.SelectParameters.Add("searchParam_bDate", TypeCode.DateTime, bDate.Date.ToString("dd/MM/yyyy"));
            }
        }
        // По номеру документа
        if (DocNumber.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and P.DOC_NUM = :searchParam_DocNumber";
                dsSearch.WhereParameters.Add("searchParam_DocNumber", TypeCode.String, DocNumber.Text);
            }
            else
                searchQuery = searchQuery + " and P.DOC_NUM = '" + DocNumber.Text + "' ";
        }
        // По серии документа
        if (DocSerial.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and P.DOC_SERIAL = :searchParam_DocSerial";
                dsSearch.WhereParameters.Add("searchParam_DocSerial", TypeCode.String, DocSerial.Text);
            }
            else
                searchQuery = searchQuery + " and P.DOC_SERIAL = '" + DocSerial.Text + "' ";
        }
        // По номеру счета
        if (textAccount.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and P.DPT_ACCNUM like :searchParam_textAccount ";
                dsSearch.WhereParameters.Add("searchParam_textAccount", textAccount.Text + "%");
            }
            else
                searchQuery = searchQuery + " and P.DPT_ACCNUM like '" + textAccount.Text + "%' ";
        }
        // По контрагенту
        if (textClientId.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and P.CUST_ID = :searchParam_clientID";
                dsSearch.WhereParameters.Add("searchParam_clientID", TypeCode.Decimal, Convert.ToString(Convert.ToInt64(textClientId.Text)));
            }
            else
            {
                searchQuery = searchQuery + " and P.CUST_ID = :searchParam_clientID";
                dsSearch.SelectParameters.Add("searchParam_clientID", TypeCode.Decimal, Convert.ToString(Convert.ToInt64(textClientId.Text)));
            }
        }
        // По ид.коду вклада
        if (textDepositId.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and P.DPT_ID  = :searchParam_depositID";
                dsSearch.WhereParameters.Add("searchParam_depositID", TypeCode.Decimal, Convert.ToString(Convert.ToInt64(textDepositId.Text)));
            }
            else
            {
                searchQuery = searchQuery + " and P.DPT_ID  = :searchParam_depositID";
                dsSearch.SelectParameters.Add("searchParam_depositID", TypeCode.Decimal, Convert.ToString(Convert.ToInt64(textDepositId.Text)));
            }
        }
        // По номеру вклада
        if (textDepositNum.Text != String.Empty)
        {
            if (btSearchPressed)
            {
                searchQuery = searchQuery + " and P.DPT_NUM  like :searchParam_depositND";
                dsSearch.WhereParameters.Add("searchParam_depositND", TypeCode.String, "%" + textDepositNum.Text + "%");
            }
            else
                searchQuery = searchQuery + " and P.DPT_NUM  like '%" + textDepositNum.Text + "%' ";
        }

        searchQuery += " order by P.DPT_ID";

        dsSearch.SelectCommand = searchQuery;
        gvSearch.DataBind();

        if ((action == "replenish") || (action == "payout"))
        {
            // Не показуємо суми, РНК та ОКПО при пошуку:
            // 1) для поповнення 
            // 2) для виплати в день завершення (ЕБП)
            gvSearch.Columns[5].Visible = false;
            gvSearch.Columns[6].Visible = false;
            gvSearch.Columns[10].Visible = false;
            gvSearch.Columns[11].Visible = false;
            gvSearch.Columns[12].Visible = false;
            gvSearch.Columns[13].Visible = false;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void gvSearch_RowDataBound(object sender, GridViewRowEventArgs e)
    {        
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;

            if (Convert.ToString(((DataRowView)row.DataItem).Row[14]) == "1"
                && Convert.ToString(Request["action"]) == "cancelextention")
                row.ForeColor = Color.Red;
            
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" + row.Cells[1].Text + "')");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public decimal CheckSearchParams()
    {
        OracleConnection connect = new OracleConnection();
        try
        {	
            // extended = 1 - Ускладнений пошук договору (в УПБ) для виплати %% по вкладу чужого відділення)
            string extended = Convert.ToString(this.Request.Params.Get("extended"));
            
            // extended = 2 - Ускладнений пошук договору (в Ощадбанку) для швидкого поповнення вкладу
            if (Convert.ToString(Request["action"]) == "replenish")
            { 
                extended = "2";
            }

            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdCkParams = connect.CreateCommand();
            cmdCkParams.CommandText = "select dpt_web.enough_search_params( " +
                ":p_dptid, :p_dptnum, :p_custid, :p_accnum, :p_custname, " +
                ":p_custcode, :p_birthdate, :p_docserial, :p_docnum, :p_extended ) from dual";

            if (String.IsNullOrEmpty(textDepositId.Text))
                cmdCkParams.Parameters.Add("p_dptid", OracleDbType.Decimal, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_dptid", OracleDbType.Decimal, textDepositId.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(textDepositNum.Text))
                cmdCkParams.Parameters.Add("p_dptnum", OracleDbType.Decimal, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_dptnum", OracleDbType.Decimal, textDepositNum.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(textClientId.Text))
                cmdCkParams.Parameters.Add("p_custid", OracleDbType.Decimal, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_custid", OracleDbType.Decimal, textClientId.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(textAccount.Text))
                cmdCkParams.Parameters.Add("p_accnum", OracleDbType.Varchar2, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_accnum", OracleDbType.Varchar2, textAccount.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(textClientName.Text))
                cmdCkParams.Parameters.Add("p_custname", OracleDbType.Varchar2, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_custname", OracleDbType.Varchar2, textClientName.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(textClientCode.Text))
                cmdCkParams.Parameters.Add("p_custcode", OracleDbType.Varchar2, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_custcode", OracleDbType.Varchar2, textClientCode.Text, ParameterDirection.Input);

            if (bDate.Date == DateTime.MinValue)
                cmdCkParams.Parameters.Add("p_birthdate", OracleDbType.Date, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_birthdate", OracleDbType.Date, bDate.Date, ParameterDirection.Input);

            if (String.IsNullOrEmpty(DocSerial.Text))
                cmdCkParams.Parameters.Add("p_docserial", OracleDbType.Varchar2, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_docserial", OracleDbType.Varchar2, DocSerial.Text, ParameterDirection.Input);

            if (String.IsNullOrEmpty(DocNumber.Text))
                cmdCkParams.Parameters.Add("p_docnum", OracleDbType.Varchar2, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_docnum", OracleDbType.Varchar2, DocNumber.Text, ParameterDirection.Input);

            if (extended != "1")
                cmdCkParams.Parameters.Add("p_extended", OracleDbType.Decimal, null, ParameterDirection.Input);
            else
                cmdCkParams.Parameters.Add("p_extended", OracleDbType.Decimal, 1, ParameterDirection.Input);

            return Convert.ToDecimal(Convert.ToString(cmdCkParams.ExecuteScalar()));
        }
        catch (Exception ex)
        {
            /// Перехоплюємо помилку і записуємо її
            /// щоб потім відобразити тільки у модальному діалозі
            Deposit.SaveException(ex);
            return 0;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}