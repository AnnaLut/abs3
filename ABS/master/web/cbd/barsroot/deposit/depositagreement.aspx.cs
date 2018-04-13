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
using Bars.Exception;

/// <summary>
/// Summary description for DepositAgreement.
/// </summary>
public partial class DepositAgreementPage : Bars.BarsPage
{
    protected System.Data.DataSet dsAddAgreement;
    private OracleDataAdapter adapterSearchAgreement;
    protected System.Data.DataSet dsCurAgreement;
    private int row_counter = 0;
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
        
        DBLogger.Info("Пользователь зашел на страницу оформления доп. соглашений по договору №" +
            Convert.ToString(Request["dpt_id"]), "deposit");

        if (Deposit.InheritedDeal(Convert.ToString(Request["dpt_id"])))
            throw new DepositException("По депозитному договору є зареєстровані спадкоємці. Дана функція заблокована.");

        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositAgreement;        
        
        dpt_num.Value = Convert.ToString(Session["DPT_NUM"]);
        dpt_id.Value = Convert.ToString(Request["dpt_id"]);

        btForm.Attributes["onclick"] = "javascript:if (agr_ck())";

        if (!IsPostBack)
        {
            FillGrids();
        }

        /// Для банку УПБ допустимим є лише поповненя депозиту
        /// Часткове зняття не передбачається поки
        if (BankType.GetCurrentBank() == BANKTYPE.UPB)
        {
            agr_id.Value = "2";
            name.Value = Resources.Deposit.GlobalResources.al12;
            btForm_ServerClick(sender, e);
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillGrids()
    {
        Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);

        RegisterClientScript_Add();
        RegisterClientScript_Cur();

        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = new OracleCommand();
            cmdSearch.Connection = connect;

            /// Завантажуємо всі допустимі додаткові угоди
            string searchQuery = @"SELECT type_id id, type_name name, type_description description
                  FROM v_dpt_agreements_types
                 WHERE dpt_id = :dpt_id
                 ORDER BY type_id";

            cmdSearch.CommandText = searchQuery;
            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            adapterSearchAgreement = new OracleDataAdapter();
            adapterSearchAgreement.SelectCommand = cmdSearch;
            adapterSearchAgreement.Fill(dsAddAgreement);

            gridAddAgreement.DataSource = dsAddAgreement;
            gridAddAgreement.DataBind();

            gridAddAgreement.HeaderStyle.BackColor = Color.Gray;
            gridAddAgreement.HeaderStyle.Font.Bold = true;
            gridAddAgreement.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

            /// Завантажуємо укладені додаткові угоди
            /// по даному депозитному договору
            cmdSearch.CommandText = @"select v.AGRMNT_NUM as adds, v.AGRMNT_DATE as version, v.AGRMNT_TYPE as agr_id,
                v.AGRMNT_TYPENAME as agr_name, v.TEMPLATE_ID as template, v.TRUSTEE_ID as rnk_tr, 
                v.TRUSTEE_NAME as nmk, v.COMMENTS as comm,decode(to_char(substr(c.text,1,1)),to_char(null),0,1) as txt, 
                v.agrmnt_id as agr_uid,v.fl_activity as status 
                from v_dpt_agreements v, cc_docs c
                where v.DPT_ID = :dpt_id and 
                c.ID(+) = v.TEMPLATE_ID and c.ND(+) = v.DPT_ID 
                and c.ADDS(+) = v.AGRMNT_NUM 
                order by adds";
            adapterSearchAgreement.Fill(dsCurAgreement);

            gridCurAgreement.DataSource = dsCurAgreement;
            gridCurAgreement.DataBind();

            gridCurAgreement.HeaderStyle.BackColor = Color.Gray;
            gridCurAgreement.HeaderStyle.Font.Bold = true;
            gridCurAgreement.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Локализация DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем грид
        if (gridCurAgreement.Controls.Count > 0)
        {
            Table tb = gridCurAgreement.Controls[0] as Table;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb27;
            tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb28;
            tb.Rows[0].Cells[5].Text = Resources.Deposit.GlobalResources.tb29;
            tb.Rows[0].Cells[6].Text = Resources.Deposit.GlobalResources.tb30;

        }
        if (gridAddAgreement.Controls.Count > 0)
        {
            Table tb = gridAddAgreement.Controls[0] as Table;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb31;
            tb.Rows[0].Cells[2].Text = Resources.Deposit.GlobalResources.tb32;

        }
    }
    /// <summary>
    /// Клієнтський скріпт, який
    /// при виборі рядка таблиці
    /// виділяє його кольором
    /// </summary>
    private void RegisterClientScript_Add()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
			function S_A(id,val,name)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('agr_id').value = val;
			 document.getElementById('name').value = name;
			 document.getElementById('ccdoc_id').value = null;
			 document.getElementById('ccdoc_ads').value = null;
			 document.getElementById('ccdoc_agr_id').value = null;
             document.getElementById('btFormText').disabled = 'disabled';
             document.getElementById('btShow').disabled = 'disabled';
            document.getElementById('btStorno').disabled = 'disabled';
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
    }
    /// <summary>
    /// Клієнтський скріпт, який
    /// при виборі рядка таблиці
    /// виділяє його кольором
    /// </summary>
    private void RegisterClientScript_Cur()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
			function S_C(id,c_id,agr_id,adds,txt,agr_uid,status)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('ccdoc_id').value = c_id;
			 document.getElementById('ccdoc_ads').value = adds;
			 document.getElementById('ccdoc_agr_id').value = agr_id;
			 document.getElementById('agr_id').value = null;
			 document.getElementById('name').value = null;
             document.getElementById('agr_uid').value = agr_uid;
             if (status == -1)
                document.getElementById('btStorno').disabled = 'disabled';
             else 
                document.getElementById('btStorno').disabled = '';
             if (txt == 1)
             {
                document.getElementById('btFormText').disabled = 'disabled';
                document.getElementById('btShow').disabled = '';
             }
             else
             {
                document.getElementById('btFormText').disabled = '';
                document.getElementById('btShow').disabled = 'disabled';
             }
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_C", script);
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
        this.dsAddAgreement = new System.Data.DataSet();
        this.dsCurAgreement = new System.Data.DataSet();
        ((System.ComponentModel.ISupportInitialize)(this.dsAddAgreement)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.dsCurAgreement)).BeginInit();
        this.gridAddAgreement.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridAddAgreement_ItemDataBound);
        this.gridCurAgreement.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridCurAgreement_ItemDataBound);
        this.btForm.ServerClick += new System.EventHandler(this.btForm_ServerClick);
        // 
        // dsAddAgreement
        // 
        this.dsAddAgreement.DataSetName = "NewDataSet";
        this.dsAddAgreement.Locale = new System.Globalization.CultureInfo("uk-UA");
        // 
        // dsCurAgreement
        // 
        this.dsCurAgreement.DataSetName = "NewDataSet";
        this.dsCurAgreement.Locale = new System.Globalization.CultureInfo("uk-UA");
        ;
        ((System.ComponentModel.ISupportInitialize)(this.dsAddAgreement)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.dsCurAgreement)).EndInit();

    }
    #endregion
    /// <summary>
    /// Перевірка дод.угоди на унікальність
    /// та можливість формувати
    /// </summary>
    /// <returns>Можна формувати, чи ні</returns>
    private bool CkUnique()
    {
        OracleConnection connect = new OracleConnection();
        OracleDataReader rdr = null;
        try
        {
            if (Request["dpt_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

            Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
            Decimal f_id = Convert.ToDecimal(Convert.ToString(agr_id.Value));

            DBLogger.Debug("Проверка взможности заключения доп. соглашения тип=" + f_id +
                " по договору №" + dpt_id,"deposit");

            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = @"select f.only_one
                from v_dpt_agreements v,dpt_vidd_flags f
                where v.dpt_id = :dpt_id and v.agrmnt_type = :f_id and v.FL_ACTIVITY = 1
                and v.agrmnt_type = f.ID and f.ONLY_ONE = 1";

            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmdSearch.Parameters.Add("f_id", OracleDbType.Decimal, f_id, ParameterDirection.Input);

            rdr = cmdSearch.ExecuteReader();

            if (!rdr.Read())
            {
                DBLogger.Debug("Выбраное доп. соглашение№" + f_id.ToString() + " по договору №" + dpt_id.ToString() + " формировать можно",
                    "deposit");

                return true;
            }
            else
            {
                Decimal only_one = Decimal.MinValue;
                if (!rdr.IsDBNull(0))
                    only_one = rdr.GetOracleDecimal(0).Value;
                if (only_one != 1)
                {
                    DBLogger.Debug("Выбраное доп. соглашение тип=" + f_id.ToString() + " по договору №" + dpt_id.ToString() + " формировать можно",
                        "deposit");

                    return true;
                }
                DBLogger.Debug("Выбраное доп. соглашение по договору №" + dpt_id.ToString() + " формировать нельзя: оно уникально и уже сформировано",
                    "deposit");

                return false;
            }
        }
        finally
        {
            rdr.Close();
            rdr.Dispose();
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// Перевірка:
    /// 1) угода має заключатися мінімум за 5 банківсих днів до дати закінчення договору
    /// 2) вклад має належати продуктам «Депозитний ОБ» та «Строковий Пенсійний»
    /// </summary>
    private bool CkCondition()
    {
        OracleConnection connect = new OracleConnection();
        OracleDataReader rdr = null;
        try
        {
            if (Request["dpt_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

            Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);

            DBLogger.Debug("Проверка взможности заключения доп. соглашения тип=" + Convert.ToString(agr_id.Value) +
                " по договору №" + dpt_id, "deposit");

            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            /*
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();
            */
            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = @"
                select dat_next_u(dat_end, -5)
                  from dpt_deposit
                 where deposit_id = :dpt_id
                   and vidd in (select vidd from dpt_vidd where type_id in (2,10,34)) ";

            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            rdr = cmdSearch.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                {
                    DateTime min_dat = rdr.GetOracleDate(0).Value;

                    if (DateTime.Now.Date <= min_dat)
                    {
                        DBLogger.Debug("Вибрану додп.угоду по договору №" + dpt_id.ToString() + " можна формувати", "deposit");
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                return false;
            }
            else
            {
                DBLogger.Debug("Вибрану додп.угоду по договору №" + dpt_id.ToString() + " формувати не можна!", "deposit");
                return false;
            }
        }
        finally
        {
            rdr.Close();
            rdr.Dispose();
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// 
    /// </summary>
    private void btForm_ServerClick(object sender, System.EventArgs e)
    {
        if (CkUnique())
        {
            string dpt_id = Convert.ToString(Request["dpt_id"]);
            string agrm_id = agr_id.Value.ToString();
            string txt_name = name.Value.ToString();
            String url = "";

            agr_id.Value = "";

          

            DBLogger.Info("Пользователь выбрал для формирования доп. соглашение тип=" + agrm_id +
                          " для депозитного договора №" + dpt_id, "deposit");

            if ((agrm_id == "4") && (!CkCondition()))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_check_condition", 
                    "alert('Заборонено формувати дану додаткову угоду для договору №" + dpt_id +"')", true);
                return;
            }
            if (agrm_id == "25")
            {

                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                OracleConnection connect = new OracleConnection();
                connect = conn.GetUserConnection();
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");

                OracleCommand cmdRnk = connect.CreateCommand();
                cmdRnk.CommandText = @"select rnk from dpt_deposit where deposit_id = :deposit_id";
                cmdRnk.Parameters.Add("deposit_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                String rnk_tr = Convert.ToString(cmdRnk.ExecuteScalar()); 

                url = "/barsroot/deposit/depositaddregular.aspx?dpt_id=" + dpt_id + "&agr_id=" + agrm_id + "&rnk_tr=" + rnk_tr;
            }
        
            else
            {

                //String url = "DepositAgreementTemplate.aspx?dpt_id=" + dpt_id + "&agr_id=" + agrm_id + "&name=" + txt_name;
                url = "depositcommissionquest.aspx?dpt_id=" + dpt_id + "&agr_id=" + agrm_id + "&name=" + txt_name;

                if (Request["rnk_tr"] != null)
                    url += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

                /// Обнуляємо дані про змінні сесії
                Session["NO_COMISSION"] = String.Empty;
                Session["REF"] = String.Empty;
            }
            Response.Redirect(url);
        }
        else
        {
            Response.Write(@"<script>alert('Данное доп.соглашение уникально и уже было сформировано!\nОтмените сначала существующие доп.соглашение.');
				location.replace('..//barsweb/Welcome.aspx');</script>");

            Response.Flush();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void gridAddAgreement_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            DataGridItem row = e.Item;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" + 
                row.Cells[0].Text + "','" + row.Cells[1].Text + "')");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void gridCurAgreement_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            DataGridItem row = e.Item;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_C('" + row_counter + "','" + 
                row.Cells[4].Text + "','" +
                row.Cells[2].Text + "','" + row.Cells[0].Text + "','" +
                row.Cells[7].Text + "','" + row.Cells[8].Text + "','" +
                row.Cells[9].Text + "')");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btFormText_ServerClick(object sender, EventArgs e)
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Request["dpt_id"]));
        dpt.WriteAddAgreement(agr_uid.Value, ccdoc_id.Value);

        FillGrids();
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btStorno_ServerClick(object sender, EventArgs e)
    {
        Deposit dpt = new Deposit();
        dpt.ReverseAgreement(Convert.ToDecimal(agr_uid.Value));

        //видалення ДУ на регулярного платежу 
        OracleConnection connect = new OracleConnection();
        IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
        connect = conn.GetUserConnection();
        OracleCommand cmd = connect.CreateCommand();

        try
        {
            cmd.Parameters.Add("p_agr_id", OracleDbType.Decimal, Convert.ToDecimal(agr_uid.Value), ParameterDirection.Input);
            cmd.CommandText = "begin sto_all.del_regulartreaty(:p_agr_id);end;";
            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        FillGrids();
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btShow_ServerClick(object sender, EventArgs e)
    {
        Session["DPTPRINT_DPTID"] = dpt_id.Value;
        Session["DPTPRINT_AGRID"] = ccdoc_agr_id.Value;
        Session["DPTPRINT_AGRNUM"] = ccdoc_ads.Value;
        Session["DPTPRINT_TEMPLATE"] = ccdoc_id.Value;

        FillGrids();

        Response.Write(@"<script>
            var url = 'DepositPrint.aspx?code=' + Math.random();	        
			window.open(encodeURI(url),'_blank',
			'height=800,width=800,menubar=no,toolbar=no,location=no,titlebar=no');
        </script>");
    }
}
