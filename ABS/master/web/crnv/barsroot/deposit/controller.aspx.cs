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
using System.IO;
using System.Globalization;

/// <summary>
/// Депозитний модуль: Контролер - Операціоніст
/// </summary>
public partial class Controller : Bars.BarsPage
{
	private int row_counter = 0;
	/// <summary>
	/// Загрузка формы
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hController;
		CheckIfEnabled();
	
		RegisterClientScript();

		textClientCode.Attributes["onblur"]		= "javascript:doValueCheck(\"textClientCode\")";
		RNK.Attributes["onblur"]				= "javascript:doValueCheck(\"RNK\")";
		textDepositId.Attributes["onblur"]		= "javascript:doValueCheck(\"textDepositId\")";
		DocNumber.Attributes["onblur"]			= "javascript:doValueCheck(\"DocNumber\")";

		if (BankType.GetCurrentBank() != BANKTYPE.PRVX)
			textAccount.Attributes["onblur"]		= "javascript:doValueCheck(\"textAccount\")";
        if (!IsPostBack)
        {
            //FillGrid(true);
            GetBankDate();
        }
	}
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sourceControl"></param>
    /// <param name="eventArgument"></param>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { FillGrid(false); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    /// <summary>
    /// Локализация грида
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        //// Локализируем грид
        //if (gridDeposit.Controls.Count > 0)
        //{
        //    Table tb = gridDeposit.Controls[0] as Table;
        //    tb.Rows[0].Cells[0].Text = Resources.Deposit.GlobalResources.tb101;
        //    tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb102;
        //    tb.Rows[0].Cells[2].Text = Resources.Deposit.GlobalResources.tb103;
        //    if ("Дата закрытия клиента" == tb.Rows[0].Cells[3].Text)
        //    tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb104;
        //    else
        //    tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb105;
        //    tb.Rows[0].Cells[4].Text = Resources.Deposit.GlobalResources.tb106;
        //    tb.Rows[0].Cells[5].Text = Resources.Deposit.GlobalResources.tb107;
        //    tb.Rows[0].Cells[6].Text = Resources.Deposit.GlobalResources.tb108;
        //    tb.Rows[0].Cells[7].Text = Resources.Deposit.GlobalResources.tb109;
        //    tb.Rows[0].Cells[8].Text = Resources.Deposit.GlobalResources.tb110;
        //    tb.Rows[0].Cells[9].Text = Resources.Deposit.GlobalResources.tb111;
        //    tb.Rows[0].Cells[10].Text = Resources.Deposit.GlobalResources.tb112;
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
		this.btReRegister.ServerClick += new System.EventHandler(this.btReRegister_ServerClick);
	}
	#endregion
	/// <summary>
	/// Проверка на права
	/// открытия этой страницы
	/// </summary>
	private void CheckIfEnabled()
	{
		OracleConnection connect = new OracleConnection();

		try
		{
			DBLogger.Debug("Начало проверки: можно ли просматривать эту страницу.",
				"deposit");

			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = new OracleCommand();
			cmdSetRole.Connection = connect;
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = new OracleCommand();
			cmdSearch.Connection = connect;
			cmdSearch.CommandText = "select val from params where par='W_CTRL_F'";
			string result = Convert.ToString(cmdSearch.ExecuteScalar());

			if (result != "1") 
			{
				DBLogger.Debug("Пользователю просматривать эту страницу нельзя!",
					"deposit");
				Response.Redirect("DepositClient.aspx");
			}

			DBLogger.Debug("Пользователю можно просматривать эту страницу.",
				"deposit");
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}
	}
	/// <summary>
	/// Поиск депозитных договоров
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btSearch_ServerClick(object sender, System.EventArgs e)
	{
        FillGrid(true);
	}
	/// <summary>
	/// 
	/// </summary>
    private void RegisterClientScript ()
	{
		string script = @"<script language='javascript'>
			var selectedRowId;
			var selectedRow;
			var row_id;
			function S(val,id,rnk,dpt_id,clClosed)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 row_id = id; 
			 selectedRowId = val;
			 document.getElementById('SEL_ROW').value = rnk + '?' + dpt_id + '?' + clClosed;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script", script);
	}
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
	private void btReRegister_ServerClick(object sender, System.EventArgs e)
	{
		String val = SEL_ROW.Value;
		String[] _arr = val.Split('?');

		if (_arr[0]== null || _arr[0] == "")
		{
			Response.Write("<script>alert('Не выбран клиент!')</script>");
			return;
		}
		Decimal rnk = Convert.ToDecimal(_arr[0]);

		if (_arr[2] != "1")
		{
			Response.Write("<script>alert('Данный клиент открыт!')</script>");				
			return;
		}

		OracleConnection connect = new OracleConnection();

		try {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();		

			OracleCommand cmdUpdateCustomer = connect.CreateCommand();
			cmdUpdateCustomer.CommandText = "update customer set date_off = null where rnk=:rnk";
			cmdUpdateCustomer.Parameters.Add("rnk",OracleDbType.Decimal,rnk,ParameterDirection.Input);
			cmdUpdateCustomer.ExecuteScalar();
			cmdUpdateCustomer.Dispose();

		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}

		btSearch_ServerClick(sender,e);
	}
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gridDeposit_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (row.Cells[8].Text.IndexOf('/') > 0)
            {
                DateTime bankd = Convert.ToDateTime(bd.Value, cinfo);
                DateTime d_end = Convert.ToDateTime(row.Cells[7].Text, cinfo);
                if (d_end < bankd)
                    row.Cells[8].ForeColor = Color.Red;
            }

            String isClientClosed = String.Empty;
            if (row.Cells[7].Text.IndexOf("/") <= 0 && row.Cells[3].Text.IndexOf("/") > 0)
            {
                isClientClosed = "1";
                row.Cells[3].ForeColor = Color.Red;
            }

            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S('" + row.Cells[0].Text + "','" +
                row_counter.ToString() + "','" + row.Cells[0].Text + "','" +
                row.Cells[4].Text + "','" + isClientClosed + "')");

            row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
            row.Cells[3].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[5].HorizontalAlign = HorizontalAlign.Left;
            row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
            row.Cells[7].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[8].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[9].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[10].HorizontalAlign = HorizontalAlign.Right;
            row.Cells[11].HorizontalAlign = HorizontalAlign.Right;
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
        dsDeposit.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsDeposit.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");        

        DBLogger.Info("Пользователь выполнил поиск депозитного договора","deposit");

        string searchQuery = string.Empty;

        dsDeposit.WhereParameters.Clear();
        dsDeposit.SelectParameters.Clear();

        /// Шукаємо тільки депозити
        if (ddSearchType.Value == "0")
        {
            searchQuery = "select d.rnk RNK, c.okpo OKPO,c.nmk NMK, null CLOS, to_char(d.deposit_id) DPT_ID, " +
            "v.type_name TYPE_NAME, a.nls NLS, d.dat_begin DATZ,d.dat_end DAT_END,t.lcv LCV, " +
            "to_char(a.ostc/100,'999999999990.99') OSTC, " +
            "decode(a.acc,a2.acc,'0',to_char(a2.ostc/100,'999999999990.99')) PERC " +
            "from dpt_deposit d, saldo a, customer c, person p, tabval t, saldo a2,int_accn i,dpt_vidd v " +
            "where c.custtype = 3 and d.vidd=v.vidd and d.acc = a.acc and d.rnk = c.rnk and c.rnk=p.rnk(+) and t.kv=d.kv and i.acc=d.acc and i.acra=a2.acc and a.tobo = tobopack.gettobo and a2.tobo=tobopack.gettobo ";

            // По вкладчику (наименование)
            if (textClientName.Text != String.Empty)
            {
                if (btSearchPressed)
                {
                    searchQuery = searchQuery + " and upper(c.nmk) like :searchParam_clientName ";
                    dsDeposit.WhereParameters.Add("searchParam_clientName", TypeCode.String, textClientName.Text.ToUpper() + "%");
                }
                else
                    searchQuery = searchQuery + " and upper(c.nmk) like '" + textClientName.Text.ToUpper() + "%' ";
            }
            // По иден. коду вкладчика
            if (textClientCode.Text != String.Empty)
            {
                if (btSearchPressed)
                {
                    searchQuery = searchQuery + " and c.okpo = :searchParam_clientCode ";
                    dsDeposit.WhereParameters.Add("searchParam_clientCode", TypeCode.String, textClientCode.Text);
                }
                else
                    searchQuery = searchQuery + " and c.okpo = '" + textClientCode.Text + "' ";
            }
            // По рнк вкладчика
            if (RNK.Text != String.Empty)
            {
                if (btSearchPressed)
                {
                    searchQuery = searchQuery + " and c.rnk = :searchParam_clientID ";
                    dsDeposit.WhereParameters.Add("searchParam_clientID", TypeCode.Decimal, RNK.Text);
                }
                else
                {
                    searchQuery = searchQuery + " and c.rnk = :searchParam_clientID ";
                    dsDeposit.SelectParameters.Add("searchParam_clientID", TypeCode.Decimal, RNK.Text);
                }
            }
            // По номеру счета
            if (textAccount.Text != String.Empty)
            {
                if (btSearchPressed)
                {
                    searchQuery = searchQuery + " and a.nls like :searchParam_textAccount ";
                    dsDeposit.WhereParameters.Add("searchParam_textAccount", TypeCode.String, "%" + textAccount.Text.ToString() + "%");
                }
                else
                    searchQuery = searchQuery + " and a.nls like '%" + textAccount.Text + "%' ";
            }
            // По номеру документа
            if (DocNumber.Text != String.Empty)
            {
                if (btSearchPressed)
                {
                    searchQuery = searchQuery + " and p.numdoc = :searchParam_DocNumber ";
                    dsDeposit.WhereParameters.Add("searchParam_DocNumber", TypeCode.String, DocNumber.Text);
                }
                else
                    searchQuery = searchQuery + " and p.numdoc = '" + DocNumber.Text + "' ";
            }
            // По номеру вклада
            if (textDepositId.Text != String.Empty)
            {
                if (btSearchPressed)
                {
                    searchQuery = searchQuery + " and d.deposit_id  = :searchParam_depositID ";
                    dsDeposit.WhereParameters.Add("searchParam_depositID", TypeCode.Decimal, textDepositId.Text);
                }
                else
                {
                    searchQuery = searchQuery + " and d.deposit_id  = :searchParam_depositID ";
                    dsDeposit.SelectParameters.Add("searchParam_depositID", TypeCode.Decimal, textDepositId.Text);
                }
            }
        }
        /// Шукаємо тільки клієнтів
        else
        {
            //searchQuery += " union all ";

            searchQuery = " select c.rnk RNK,c.okpo OKPO,c.nmk NMK,nvl(to_char(date_off,'dd/mm/yyyy'),to_char(null)) CLOS ," +
                " null DPT_ID, null TYPE_NAME,null NLS, null DATZ,null DAT_END,null LCV,null OSTC,null PERC " +
                " from customer c, person p " +
                " where c.custtype = 3 and c.rnk = p.rnk (+) ";
            // По вкладчику (наименование)
            if (textClientName.Text != String.Empty)
            {
                if (btSearchPressed)
                {
                    searchQuery = searchQuery + " and upper(c.nmk) like :searchParam_clientName ";
                    dsDeposit.WhereParameters.Add("searchParam_clientName", TypeCode.String, textClientName.Text.ToUpper() + "%");
                }
                else
                    searchQuery = searchQuery + " and upper(c.nmk) like '" + textClientName.Text.ToUpper() + "%' ";
            }
            // По иден. коду вкладчика
            if (textClientCode.Text != String.Empty)
            {
                if (btSearchPressed)
                {
                    searchQuery = searchQuery + " and c.okpo = :searchParam_clientCode ";
                    dsDeposit.WhereParameters.Add("searchParam_clientCode", TypeCode.String, textClientCode.Text);
                }
                else
                    searchQuery = searchQuery + " and c.okpo = '" + textClientCode.Text + "' ";
            }
            // По рнк вкладчика
            if (RNK.Text != String.Empty)
            {
                searchQuery = searchQuery + " and c.rnk = :searchParam_clientID ";
                dsDeposit.WhereParameters.Add("searchParam_clientID", TypeCode.Decimal, RNK.Text);
            }
            // По номеру документа
            if (DocNumber.Text != String.Empty)
            {
                if (btSearchPressed)
                {
                    searchQuery = searchQuery + " and p.numdoc = :searchParam_DocNumber ";
                    dsDeposit.WhereParameters.Add("searchParam_DocNumber", TypeCode.String, DocNumber.Text);
                }
                else
                    searchQuery = searchQuery + " and p.numdoc = '" + DocNumber.Text + "' ";
            }
        }

        dsDeposit.SelectCommand = searchQuery;
    }
    /// <summary>
    /// 
    /// </summary>
    private void GetBankDate()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetBankDate = connect.CreateCommand();
            cmdGetBankDate.CommandText = "select to_char(bankdate,'dd/mm/yyyy') from dual";
            String bankDate = Convert.ToString(cmdGetBankDate.ExecuteScalar());
            bd.Value = bankDate;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
