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
using System.Web.Services;
using Bars.Logger;
using Bars.Oracle;
using Bars.Requests;
using Bars.Exception;
using Oracle.DataAccess.Client;

/// <summary>
/// Summary description for DepositHistory.
/// </summary>
public partial class DepositHistory : Bars.BarsPage
{
    protected System.Data.DataSet dataSet;
    /// <summary>
    /// Загрузка страницы
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("/barsroot/clientproducts/dptclientsearch.aspx");
        else
        {
            Page.Header.Title = Resources.Deposit.GlobalResources.hDepositHistory;

            FillInForm(Convert.ToDecimal(Request["dpt_id"]));
        }
    }
    /// <summary>
    /// Инициализация информации на странице
    /// </summary>
    private void FillInForm(Decimal DepositID)
    {
        Deposit dpt = new Deposit();

        dpt.ID = DepositID;

        dpt.ReadFromDatabaseExt(false, true, true);

        // Доступ до власного / довіреного депозиту
        Int64 cust_id;
        
        if (Request["rnk_tr"] != null)
            cust_id = Convert.ToInt64(Request["rnk_tr"]);
        else
            cust_id = Convert.ToInt64(dpt.Client.ID);

        // якщо в користувача не повний рівень доступу і вклад відкривався по ЕБП
        if ((ClientAccessRights.Get_AccessLevel(cust_id) == LevelState.Limited) &&
            (DepositRequest.HasActive(cust_id, dpt.ID) == false) &&
            (Tools.get_EADocID(dpt.ID) >= 0))
        {
            String script = "alert('В користувача недостатній рівень доступу для перегляду даної сторінки!'); ";
            script += "location.replace('/barsroot/clientproducts/dptclientsearch.aspx');";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "AccessDenied", script, true);
        }
        else
        {
            textClientName.Text = dpt.Client.Name;
            textClientPasp.Text = dpt.Client.DocTypeName + " " + dpt.Client.DocSerial +
                " " + dpt.Client.DocNumber;
            birthDate.Date = dpt.Client.BirthDate;

            textDepositNumber.Text = dpt.Number;
            textDptType.Text = dpt.TypeName;
            textDptCur.Text = dpt.CurrencyName;
            dtStartDate.Date = dpt.BeginDate;
            dtEndDate.Date = dpt.EndDate;
            curPercentRate.ValueDecimal = dpt.RealIntRate;

            textDptCurISO.Text = dpt.CurrencyISO;
            dptSum.ValueDecimal = dpt.dpt_f_sum;
            textPercentCurISO.Text = dpt.CurrencyISO;
            percentSum.ValueDecimal = dpt.perc_f_sum;
        }
    }
    /// <summary>
    /// Локализация Infra
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем грид
        if (dataGrid.Controls.Count > 0)
        {
            Table tb = dataGrid.Controls[0] as Table;
            if (tb.Rows[0].Cells.Count == 5)
            {
                tb.Rows[0].Cells[0].Text = Resources.Deposit.GlobalResources.tb57;
                tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb58;
                tb.Rows[0].Cells[2].Text = Resources.Deposit.GlobalResources.tb59;
                tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb60;
                tb.Rows[0].Cells[4].Text = Resources.Deposit.GlobalResources.tb61;
            }
            else if (tb.Rows[0].Cells.Count == 3)
            {
                tb.Rows[0].Cells[0].Text = Resources.Deposit.GlobalResources.tb62;
                tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb63;
                tb.Rows[0].Cells[2].Text = Resources.Deposit.GlobalResources.tb64;
            }
            else if (tb.Rows[0].Cells.Count == 10)
            {
                tb.Rows[0].Cells[0].Text = Resources.Deposit.GlobalResources.tb114;
                tb.Rows[0].Cells[2].Text = Resources.Deposit.GlobalResources.tb115;
                tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb116;
                tb.Rows[0].Cells[4].Text = Resources.Deposit.GlobalResources.tb117;
                tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb118;
                tb.Rows[0].Cells[5].Text = Resources.Deposit.GlobalResources.tb119;
                tb.Rows[0].Cells[6].Text = Resources.Deposit.GlobalResources.tb120;
                tb.Rows[0].Cells[7].Text = Resources.Deposit.GlobalResources.tb121;
                tb.Rows[0].Cells[8].Text = Resources.Deposit.GlobalResources.tb122;
            }
        }
        // INFRAG
        birthDate.ToolTip = Resources.Deposit.GlobalResources.tb33;
        curPercentRate.ToolTip = Resources.Deposit.GlobalResources.tb34;
        dptSum.ToolTip = Resources.Deposit.GlobalResources.tb37;
        percentSum.ToolTip = Resources.Deposit.GlobalResources.tb38;
        dtStartDate.ToolTip = Resources.Deposit.GlobalResources.tb55;
        dtEndDate.ToolTip = Resources.Deposit.GlobalResources.tb56;

        dataGrid.HeaderStyle.BackColor = Color.Gray;
        dataGrid.HeaderStyle.Font.Bold = true;
        dataGrid.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
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
        this.dataSet = new System.Data.DataSet();
        ((System.ComponentModel.ISupportInitialize)(this.dataSet)).BeginInit();
        this.btShowFinancialHistory.Click += new System.EventHandler(this.btShowFinancialHistory_Click);
        this.btAddAgreementHistory.Click += new System.EventHandler(this.btAddAgreementHistory_Click);
        // 
        // dataSet
        // 
        this.dataSet.DataSetName = "NewDataSet";
        this.dataSet.Locale = new System.Globalization.CultureInfo("en-US");
        ;
        ((System.ComponentModel.ISupportInitialize)(this.dataSet)).EndInit();

    }
    #endregion
    /// <summary>
    /// Поиск доп. соглашений
    /// по договору
    /// </summary>
    private void btAddAgreementHistory_Click(object sender, System.EventArgs e)
    {
        decimal dpt_id = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));

        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь запросил историю доп.соглашений к договору №" + Request["dpt_id"].ToString() + " на странице просмотра истории договоров",
                "deposit");

            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            string str1 = "закрыто";
            string str2 = "анулировано доп. соглашением №";
            string str3 = "активно";
            string str4 = "Просмотр";

            str1 = Resources.Deposit.GlobalResources.al09;
            str2 = Resources.Deposit.GlobalResources.al10;
            str3 = Resources.Deposit.GlobalResources.al11;
            str4 = Resources.Deposit.GlobalResources.w02;

            OracleCommand cmdGetInfo = connect.CreateCommand();
            cmdGetInfo.CommandText = "select decode(c.nd,null,'" + Resources.Deposit.GlobalResources.w04 +
                "','<A href=# onclick=\"Go('||c.nd||','||c.adds||','||v.AGRMNT_TYPE||','''||c.id||''')\">" + str4 + "</a>'), " +
                "v.AGRMNT_NUM as adds,v.AGRMNT_TYPENAME as agr_name, v.AGRMNT_DATE as version,v.COMMENTS as comm " +
                "from v_dpt_agreements v, cc_docs c " +
                "where v.DPT_ID = :dpt_id and " +
                "c.ID(+) = v.TEMPLATE_ID and c.ND(+) = v.DPT_ID " +
                "and c.ADDS(+) = v.AGRMNT_NUM " +
                "order by adds";
            cmdGetInfo.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            OracleDataAdapter adapterFillDataSet = new OracleDataAdapter();
            adapterFillDataSet.SelectCommand = cmdGetInfo;
            adapterFillDataSet.Fill(dataSet);

            dataGrid.DataBind();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Поиск счетов договора
    /// </summary>
    private void btShowFinancialHistory_Click(object sender, System.EventArgs e)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь запросил финансовую историю к договору №" + Request["dpt_id"].ToString() + 
                " на странице просмотра истории договоров", "deposit");

            Deposit dpt = new Deposit();
            dpt.ID = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));

            if (Request["noext"] != null)
                dpt.ReadFromDatabase();
            else
                dpt.ReadFromDatabase_EX(false, false);

            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetInfo = connect.CreateCommand();
            cmdGetInfo.CommandText = "select '<A href=# onclick=\"Acc('||DPT_ACCID||')\">'||DPT_ACCNUM||'</a>',DPT_CURCODE,DPT_ACCNAME " +
                "from v_dpt_portfolio_ALL_active " +
                "where dpt_id = :dpt_id " +
                "UNION ALL " +
                "select '<A href=# onclick=\"Acc('||INT_ACCID||')\">'||INT_ACCNUM||'</a>',INT_CURCODE,INT_ACCNAME " +
                "from v_dpt_portfolio_ALL_active " +
                "where dpt_id = :dpt_id";

            cmdGetInfo.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);

            OracleDataAdapter adapterFillDataSet = new OracleDataAdapter();
            adapterFillDataSet.SelectCommand = cmdGetInfo;
            adapterFillDataSet.Fill(dataSet);

            dataGrid.DataBind();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btShowDocs_Click(object sender, EventArgs e)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь запросил финансовую историю к договору №" + Request["dpt_id"].ToString() + " на странице просмотра истории договоров",
                "deposit");

            Decimal dpt_id = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));

            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetInfo = connect.CreateCommand();
            cmdGetInfo.CommandText = "select '<A href=# onclick=''ShowDocCard('||REF||')''>'||REF||'</a>' AS REF, " +
                "to_char(datd,'dd/mm/yyyy'),nls_a,kv_a,to_char(s_a/100,'999999999990.99') s_a,nls_b,kv_b,to_char(s_b/100,'999999999990.99') s_b,nazn, sos " +
                "from v_dpt_documents " +
                "where dpt_id = :dpt_id order by ref";
            cmdGetInfo.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            OracleDataAdapter adapterFillDataSet = new OracleDataAdapter();
            adapterFillDataSet.SelectCommand = cmdGetInfo;
            adapterFillDataSet.Fill(dataSet);

            dataGrid.DataBind();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void  dataGrid_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Header)
            if (e.Item.Cells.Count == 10)
                e.Item.Cells[9].Visible = false;
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataGridItem row = e.Item;
            if (row.Cells.Count == 10)
            {
                switch (row.Cells[9].Text)
                {
                    case "1": row.Style.Add(HtmlTextWriterStyle.Color, "#008000"); break;
                    case "5": row.Style.Add(HtmlTextWriterStyle.Color, "#000000"); break;
                    case "-1": row.Style.Add(HtmlTextWriterStyle.Color, "#FF0000"); break;
                    case "-2": row.Style.Add(HtmlTextWriterStyle.Color, "#FF0000"); break;
                    case "0": row.Style.Add(HtmlTextWriterStyle.Color, "#008080"); break;
                    case "3": row.Style.Add(HtmlTextWriterStyle.Color, "#0000FF"); break;
                }
                row.Cells[9].Visible = false;
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    [WebMethod(EnableSession = true)]
    public static void FillInSession(String dpt_id, String agr_num, 
			String template, String agr_id)
    {
        HttpContext.Current.Session["DPTPRINT_DPTID"] = dpt_id;
        HttpContext.Current.Session["DPTPRINT_AGRID"] = agr_id;
        HttpContext.Current.Session["DPTPRINT_AGRNUM"] = agr_num;
        HttpContext.Current.Session["DPTPRINT_TEMPLATE"] = template;
    }

}
