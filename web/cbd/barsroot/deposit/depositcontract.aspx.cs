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
using Oracle.DataAccess.Types;
using System.Globalization;
using System.Web.Services;
using System.Resources;
using Bars.Classes;

/// <summary>
/// Выбор договора
/// </summary>
public partial class DepositContract : Bars.BarsPage
{
    protected Oracle.DataAccess.Client.OracleDataAdapter adapterContractType;
    protected System.Data.DataSet dsContractType;
    protected Oracle.DataAccess.Client.OracleDataAdapter adapterType;
    protected System.Data.DataSet dsType;

    protected string ContractTypeName;
    protected bool ContractIntCap;		// Признак капитализации процентов
    /// <summary>
    /// Процедура загрузка страницы
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        // Проверяем установлены ли переменные сессии.
        // Они устанавливаются первой страницей и содержат информацию о клиенте. 
        // Если переменные не установлены, значит пришли напрямую -- отправляем на первую страницу
        if ((Deposit)Session["DepositInfo"] == null)
        {
            DBLogger.Info("Пользователь зашел на страницу выбора типа депозитного договора без информации о клиенте и был перенаправлен на карточку клиента",
                "deposit");

            Response.Redirect("DepositClient.aspx");
        }

        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositContract;

        if (BankType.GetCurrentBank() == BANKTYPE.UPB || Convert.ToString(Request["action"]) == "rollback")
        {
            btnBack.Disabled = true;
        }

        RegisterOnLoadScript("listTypes");

        if (!IsPostBack)
        {
            Bars.Metals.DepositMetals.ClearData();
            /// Инициализируем элементы страницы
            InitControls(true);
        }
    }
    /// <summary>
    /// Локализация Infra
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        textBasePercent.ToolTip = Resources.Deposit.GlobalResources.tb51;
        textMinSum.ToolTip = Resources.Deposit.GlobalResources.tb52;
        textContractSum.ToolTip = Resources.Deposit.GlobalResources.tb53;
        dtContract.ToolTip = Resources.Deposit.GlobalResources.tb54;
        dtContractBegin.ToolTip = Resources.Deposit.GlobalResources.tb55;
        dtContractEnd.ToolTip = Resources.Deposit.GlobalResources.tb56;
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
        this.adapterContractType = new Oracle.DataAccess.Client.OracleDataAdapter();
        this.dsContractType = new System.Data.DataSet();

        this.dsType = new System.Data.DataSet();

        ((System.ComponentModel.ISupportInitialize)(this.dsContractType)).BeginInit();
        this.btnBack.ServerClick += new System.EventHandler(this.btnBack_ServerClick);
        this.btnSubmit.ServerClick += new System.EventHandler(this.btnSubmit_ServerClick);
        // 
        // dsContractType
        // 
        this.dsContractType.DataSetName = "NewDataSet";
        this.dsContractType.Locale = new System.Globalization.CultureInfo("ru-RU");
        ;
        ((System.ComponentModel.ISupportInitialize)(this.dsContractType)).EndInit();

    }
    #endregion
    /// <summary>
    /// Инициализиция элементов страницы
    /// </summary>
    private void InitControls( bool reinit_types )
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];
        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            // ФИО клиента
            textClientName.Text = dpt.Client.Name;

            OracleCommand cmdGetDptTermFlag = connect.CreateCommand();
            cmdGetDptTermFlag.CommandText = "select val from params where par = 'DPT_TERM'";
            term_ext.Value = Convert.ToString(cmdGetDptTermFlag.ExecuteScalar());

            ///// Дозволено змінювати термін депозитного договору
            //if (term_ext.Value == "1")
            //{
            //    textDurationDays.Enabled = false;
            //    textDurationMonths.Enabled = false;
            //}

            if (reinit_types)
            {
                adapterType = new OracleDataAdapter();
                
                OracleCommand cmdTypes = connect.CreateCommand();

                cmdTypes.CommandText = "select type_id, type_name from DPT_TYPES where FL_ACTIVE = 1 " +
                    ((Tools.DPT_WORK_SCHEME() == "EBP") ? " and FL_DEMAND = 1 " : "") + " order by SORT_ORD ";

                adapterType.SelectCommand = cmdTypes;
                adapterType.Fill(dsType);

                listTypes.DataBind();
                listTypes.Items.Insert(0, "-");
                listTypes.Items[0].Value = "-1000";
            }

            // Заполняем список видов договоров
            adapterContractType = new OracleDataAdapter();
            OracleCommand cmdContractType = connect.CreateCommand();
            if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
            {
                if (Convert.ToString(Request["action"]) == "rollback")
                {
                    cmdContractType.CommandText = @"select vidd, type_name from v_dpt_vidd_user 
                        where kv = :kv and TYPE_ID = :TYPEID order by 1";

                    cmdContractType.Parameters.Add("kv", OracleDbType.Decimal, dpt.Currency, ParameterDirection.Input);                    
                }
                else
                {
                    cmdContractType.CommandText = @"select vidd, type_name from v_dpt_vidd_user 
                        where type_id = :TYPEID order by 1";
                }
                cmdContractType.Parameters.Add("TYPEID", OracleDbType.Decimal, listTypes.SelectedValue, ParameterDirection.Input);                    
                
                listContractType.DataTextField = "type_name";
                listContractType.DataValueField = "vidd";
            }
            else
            {
                cmdContractType.CommandText = "select dpt_type, dpt_name from v_dpt_type order by 1";
                listContractType.DataTextField = "dpt_name";
                listContractType.DataValueField = "dpt_type";
            }

            adapterContractType.SelectCommand = cmdContractType;
            adapterContractType.Fill(dsContractType);

            listContractType.DataBind();

            listContractType.Items.Insert(0, "-");
            listContractType.Items[0].Value = "-1000";

            if (reinit_types)
            {
                // Если первоначальный ввод, то устанавливаем 
                // умолчательные параметры
                if (dpt.Type == decimal.MinValue)
                {
                    CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                    cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                    cinfo.DateTimeFormat.DateSeparator = "/";

                    // Дата договора равна текущей системной
                    string dt = DateTime.Now.ToString("dd/MM/yyyy");

                    dpt.Date = Convert.ToDateTime(dt, cinfo);
                    dpt.BeginDate = Convert.ToDateTime(dt, cinfo);
                    Session["DepositInfo"] = dpt;
                }
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
        
        if (reinit_types)
            FillControlsFromClass();
    }

    /// <summary>
    /// Заполняем необходимые элементы значениями в зависимости от вида
    /// выбранного договора
    /// </summary>
    private void FillContractDependControls()
    {
        OracleConnection connect = new OracleConnection();
        Deposit dpt = (Deposit)Session["DepositInfo"];

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            // Устанавливаем роль
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            // Получаем выбранный вид договора
            if (listContractType.SelectedValue != String.Empty)
            {
                decimal contractTypeCode = Convert.ToDecimal(listContractType.SelectedValue);

                // Формируем запрос для определения параметров этого вида договора
                OracleCommand cmdSelectContractParams = new OracleCommand();
                cmdSelectContractParams.Connection = connect;
                cmdSelectContractParams.CommandText = @"select v.dpt_type, v.dpt_name, v.currency_name, 
                v.currency_iso, v.dpt_minsum, v.dpt_int, 
                decode(v.dpt_enddate,sysdate,null,to_char(v.dpt_enddate,'dd/mm/yyyy')),  
                v.dpt_months, v.dpt_days, v.dpt_cap, 
                dpt_bonus.estimate_bonus(:p_custid, v.dpt_type), 
                v.currency_code, v.dpt_brateid, 
                dpt.get_forecast_int(v.dpt_type, :p_dptamount * v.currency_denom)/v.currency_denom, 
                getbrat(sysdate, v.dpt_brateid, v.currency_code, :p_dptamount * v.currency_denom), 
                v.dpt_term_type, v.currency_denom, v.IS_CASH
                from V_DPT_TYPE v where v.dpt_type = :p_vidd";
                
                cmdSelectContractParams.BindByName = true;
                cmdSelectContractParams.Parameters.Add("p_custid", OracleDbType.Decimal, dpt.Client.ID, ParameterDirection.Input);
                cmdSelectContractParams.Parameters.Add("p_vidd", OracleDbType.Decimal, contractTypeCode, ParameterDirection.Input);
                cmdSelectContractParams.Parameters.Add("p_dptamount", OracleDbType.Decimal, textContractSum.Value, ParameterDirection.Input);

                // Читаем данные запроса
                OracleDataReader rdr = cmdSelectContractParams.ExecuteReader();
                if (rdr.Read())
                {
                    // Наименование типа депозита
                    if (!rdr.IsDBNull(1))
                        ContractTypeName = rdr.GetOracleString(1).Value;
                    else
                        ContractTypeName = string.Empty;

                    // Валюта депозита
                    if (!rdr.IsDBNull(2))
                        textDepositCurrency.Text = rdr.GetOracleString(2).Value;
                    else
                        textDepositCurrency.Text = string.Empty;

                    // ISO-код валюты
                    if (!rdr.IsDBNull(3))
                        textMinSumCurrency.Text = rdr.GetOracleString(3).Value;
                    else
                        textMinSumCurrency.Text = string.Empty;

                    // Базовая процентная ставка
                    if (!rdr.IsDBNull(5))
                        textBasePercent.Value = rdr.GetOracleDecimal(5).Value;
                    else
                        textBasePercent.Value = Decimal.Zero;

                    // ISO-код валюты для первоначального вноса
                    textContractCurrency.Text = textMinSumCurrency.Text;

                    // Минимальная сумма депозита
                    if (!rdr.IsDBNull(4))
                        textMinSum.Value = rdr.GetOracleDecimal(4).Value;
                    else
                        textMinSum.Value = Decimal.Zero;

                    //  Дата завершения договора
                    if (!rdr.IsDBNull(6))
                    {
                        String str_dt = rdr.GetOracleString(6).Value;
                        //CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                        //cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                        //cinfo.DateTimeFormat.DateSeparator = "/";
                        //dtContractEnd.Date = Convert.ToDateTime(str_dt, cinfo);
                        dtContractEnd.Date = Convert.ToDateTime(str_dt, Tools.Cinfo());
                         textDurationMonths.Text  = string.Empty;
                         textDurationDays.Text = string.Empty;

                    }
                    else
                    {
                        dtContractEnd.Text = dpt.GetDateEnd(contractTypeCode).ToString() ?? string.Empty;
                        dtContractEnd.Date = dpt.GetDateEnd(contractTypeCode) ?? DateTime.Today;
                        textDurationMonths.Text = (Math.Truncate(dtContractEnd.Date.Subtract(DateTime.Today).Days / (365.25 / 12))).ToString();
                        textDurationDays.Text = (Math.Truncate(dtContractEnd.Date.Subtract(DateTime.Today).Days / 365.25)).ToString();
                    }
                       
                    // Длительность договора (месяцев)
                    if (!rdr.IsDBNull(7) && String.IsNullOrEmpty(textDurationMonths.Text))
                       textDurationMonths.Text = rdr.GetOracleDecimal(7).ToString();
                    else
                        textDurationMonths.Text = textDurationMonths.Text ?? string.Empty;
                    
                    // Длительность договора (дней)
                    if (!rdr.IsDBNull(8) && String.IsNullOrEmpty(textDurationDays.Text))
                        textDurationDays.Text = rdr.GetOracleDecimal(8).ToString();
                    else
                        textDurationDays.Text = textDurationDays.Text ?? string.Empty;

                    // Признак капитализации процентов
                    if (!rdr.IsDBNull(9))
                    {
                        if (rdr.GetOracleDecimal(9).Value == 1)
                            ContractIntCap = true;
                        else
                            ContractIntCap = false;
                    }
                    else
                        ContractIntCap = false;

                    if (!rdr.IsDBNull(10))
                        AbsBonus.Value = Convert.ToDecimal(rdr.GetValue(10));
                    else
                        AbsBonus.Value = 0;

                    if (!rdr.IsDBNull(11))
                        kv.Value = Convert.ToString(rdr.GetValue(11));

                    if (!rdr.IsDBNull(12))
                        nb.Value = Convert.ToString(rdr.GetValue(12));                  

                    if (!rdr.IsDBNull(13))
                        ForecastPercent.Value = Convert.ToDecimal(rdr.GetValue(13));
                    
                    if (!rdr.IsDBNull(14))
                        textBasePercent.Value = Convert.ToDecimal(rdr.GetValue(14));

                    // Тип терміну депозиту (0 - плаваючий / 1 - фіксований/ 2 - діапазон)
                    if (!rdr.IsDBNull(15))
                    {
                        if (term_ext.Value == "1" && Convert.ToDecimal(rdr.GetValue(15)) != 1)
                        {
                            textDurationDays.Enabled = true;
                            textDurationMonths.Enabled = true;
                        }
                        else
                        {
                            textDurationDays.Enabled = false;
                            textDurationMonths.Enabled = false;
                        }
                    }
                    
                    //
                    if (!rdr.IsDBNull(16))
                        denom.Value = Convert.ToString(rdr.GetOracleDecimal(16));

                    // Ознака готівкового розміщення депозиту
                    if (!rdr.IsDBNull(17))
                    {
                        if (rdr.GetOracleDecimal(17) == 1)
                        {
                            checkboxIsCash.Checked = true;
                        }
                        else
                        {
                            checkboxIsCash.Checked = false;
                            checkboxIsCash.Enabled = false;
                        }
                    }

                    if (denom.Value == "1000")
                    {
                        textContractSum.Presiction = 3;
                        textMinSum.Presiction = 3;
                        ForecastPercent.Presiction = 3;
                    }

                    // для депозитів у МЕТАЛАХ при готівковому розміщенні
                    if ((kv.Value == "959" || kv.Value == "961" || kv.Value == "962") && checkboxIsCash.Checked)
                    {
                        metalParameters.Visible = true;
                        textContractSum.Value = 0;
                        textContractSum.ReadOnly = true;
                        lbMinSum.Text = Resources.Deposit.GlobalResources.Mes47;
                    }
                    else
                    {
                        textContractSum.ReadOnly = false;
                        lbMinSum.Text = Convert.ToString(GetLocalResourceObject("lbMinSum.Text"));
                    }
                }
                else
                {
                    ContractTypeName = string.Empty;
                    textDepositCurrency.Text = string.Empty;
                    textMinSumCurrency.Text = string.Empty;
                    textBasePercent.Value = Decimal.Zero;
                    textContractCurrency.Text = textMinSumCurrency.Text;
                    textMinSum.Value = Decimal.Zero;
                    dtContractEnd.Text = string.Empty;
                    textDurationMonths.Text = string.Empty;
                    textDurationDays.Text = string.Empty;
                    ContractIntCap = false;
                }

                rdr.Close();
            }

            OracleCommand getFL = connect.CreateCommand();
            getFL.CommandText = "select nvl(fl_2620,'0') from dpt_vidd where vidd = :vidd";
            getFL.Parameters.Add("vidd", OracleDbType.Decimal, listContractType.SelectedValue, ParameterDirection.Input);

            String result = Convert.ToString(getFL.ExecuteScalar());
            ckTechAcc.Enabled = (result == "1" ? true : false);
            
            /// Для переоформлення відключаємо технічний рахунок
            if (Convert.ToString(Request["action"]) == "rollback")
            { ckTechAcc.Enabled = false; ckTechAcc.Checked = false; }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Возвращает на предыдущую страницу
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btnBack_Click(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь нажал на кнопку \"Назад\" на странице выбора типа депозита и вернулся на карточку клиента",
            "deposit");
        Response.Redirect("DepositClient.aspx");
    }
    /// <summary>
    /// Метод заполняет страницу из класса
    /// </summary>
    private void FillControlsFromClass()
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];

        // Номер договора
        textContractNumber.Text = dpt.Number;
        // Тип догорова
        listContractType.SelectedIndex = listContractType.Items.IndexOf(listContractType.Items.FindByValue(dpt.Type.ToString()));
        ContractTypeName = dpt.TypeName;
        // Сумма договора
        if (dpt.Sum != decimal.MinValue)
            textContractSum.Value = dpt.Sum;
        else
            textContractSum.Text = string.Empty;
        
        // Признак оплаты наличными
        checkboxIsCash.Checked = dpt.IsCashSum;
        
        // Дата договора
        if (dpt.Date == DateTime.MinValue)
            dtContract.Value = string.Empty;
        else
            dtContract.Date = dpt.Date;
        
        // Дата начала договора
        if (dpt.BeginDate == DateTime.MinValue)
            dtContractBegin.Value = string.Empty;
        else
            dtContractBegin.Date = dpt.BeginDate;
        
        // Признак капитализации процентов
        ContractIntCap = dpt.IntCap;

        // Комментарий
        textComment.Text = dpt.Comment;

        if ((dpt.State == 9) && (Convert.ToString(Request["action"]) != "rollback"))
        {
            listTypes.Enabled = false;
            listContractType.Enabled = false;
            textContractSum.ReadOnly = true;
            checkboxIsCash.Enabled = false;
            dtContract.ReadOnly = true;
            textComment.ReadOnly = true;
        }
        else 
        {
            listTypes.Enabled = true;
            listContractType.Enabled = true;
            textContractSum.ReadOnly = false;
            checkboxIsCash.Enabled = true;
            dtContract.ReadOnly = false;
            textComment.ReadOnly = false;
        }
    }

    /// <summary>
    /// Сохраняет данные формы в классе
    /// </summary>
    private void FillClassFromControls()
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];
        //
        dpt.Type = Convert.ToDecimal(listContractType.SelectedValue);
        dpt.TypeName = ContractTypeName;
        dpt.Currency = Convert.ToDecimal(kv.Value);
        dpt.Number = textContractNumber.Text;
        dpt.Date = dtContract.Date;
        dpt.BeginDate = dtContractBegin.Date;
        dpt.EndDate = dtContractEnd.Date;
        dpt.Sum = textContractSum.Value;
        dpt.Sum_cent = textContractSum.Value * Convert.ToDecimal(Math.Pow(10,textContractSum.Presiction));
        dpt.IsCashSum = checkboxIsCash.Checked;
        dpt.IntCap = ContractIntCap;
        dpt.Comment = textComment.Text;
        dpt.GetTechAcc = ckTechAcc.Checked;
        
        if (String.IsNullOrEmpty(textDurationDays.Text))
            dpt.dpt_duration_days = 0;
        else
            dpt.dpt_duration_days = Convert.ToDecimal(textDurationDays.Text);
        
        if (String.IsNullOrEmpty(textDurationMonths.Text))
            dpt.dpt_duration_months = 0;
        else
            dpt.dpt_duration_months = Convert.ToDecimal(textDurationMonths.Text);

        Session["DepositInfo"] = dpt;
    }

    /// <summary>
    /// Проверяем данные из формы
    /// </summary>
    /// <returns></returns>
    private bool CheckFormData()
    {
        Decimal ContractSum;

        // якщо вклад в металах розміщується готівкою (min.сума вкладу вказана в грамах)
        if ((kv.Value == "959" || kv.Value == "961" || kv.Value == "962") && checkboxIsCash.Checked)
        {
            ContractSum = Convert.ToDecimal(ContractSumGrams.Value);
        }
        else
        {
            ContractSum = textContractSum.Value;
        }

        if (textMinSum.Value > ContractSum)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    /// <summary>
    /// Перехід на попередню сторінку
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btnBack_ServerClick(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь нажал на кнопку \"Назад\" на странице выбора типа депозита и вернулся на карточку клиента",
            "deposit");

        Response.Redirect("DepositClient.aspx");
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="control_id"></param>
    private void RegisterOnLoadScript(String control_id)
    {
        String script = "<script>focusControl('" + control_id + "');</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script", script);
    }

    /// <summary>
    /// Переход на следующую страницу
    /// </summary>
    private void btnSubmit_ServerClick(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь нажал на кнопку \"Далее\" на странице выбора типа депозита и продолжил заведение депозитного договора." +
            " Тип выбраного договора " + ContractTypeName, "deposit");

        // Перевіряємо дані на формі
        if (CheckFormData())
        {
            // Сохраняем данные и переходим на следующую страницу
            FillClassFromControls();

            // Deposit dpt = (Deposit)Session["DepositInfo"];

            String url = "DepositAccount.aspx";

            if (Convert.ToString(Request["action"]) == "rollback")
                url += "?action=rollback";

            Response.Redirect(url);
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dur_days"></param>
    /// <param name="dur_months"></param>
    /// <param name="sum"></param>
    /// <param name="type_id"></param>
    /// <param name="nb"></param>
    /// <param name="kv"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public static String[] GetRate(String dur_days, String dur_months, String sum, String type_id, String nb, String kv, String denom)
    {
        String[] res = new string[2];

        /// Якщо прийшли порожні дані - повертаємо порожню стрічку по ставці
        if (String.IsNullOrEmpty(dur_days) ||
            String.IsNullOrEmpty(dur_months) ||
            String.IsNullOrEmpty(sum))
        {
            res[0] = String.Empty;
        }
        else
        {
            sum = sum.Replace(" ", String.Empty);
            OracleConnection connect = new OracleConnection();
            try
            {
                connect = OraConnector.Handler.IOraConnection.GetUserConnection();
                

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = @"select dpt.f_calc_rate(:p_vidd,:p_term_m,:p_term_d,:p_sum, sysdate) from dual";
                cmd.Parameters.Add("p_vidd", OracleDbType.Decimal, type_id, ParameterDirection.Input);
                cmd.Parameters.Add("p_term_m", OracleDbType.Decimal, dur_months, ParameterDirection.Input);
                cmd.Parameters.Add("p_term_d", OracleDbType.Decimal, dur_days, ParameterDirection.Input);
                cmd.Parameters.Add("p_sum", OracleDbType.Decimal, Convert.ToDecimal(sum) * Convert.ToDecimal(denom), ParameterDirection.Input);

                String result = Convert.ToString(cmd.ExecuteScalar());
                if (Convert.ToDecimal(result) <= 0)
                {
                    if (String.IsNullOrEmpty(nb) || String.IsNullOrEmpty(kv))
                    {
                        cmd.Parameters.Clear();
                        cmd.CommandText = @"select getbrat(sysdate, :nb, :kv, :s) from dual";
                        cmd.Parameters.Add("nb", OracleDbType.Decimal, nb, ParameterDirection.Input);
                        cmd.Parameters.Add("kv", OracleDbType.Decimal, kv, ParameterDirection.Input);
                        cmd.Parameters.Add("s", OracleDbType.Decimal, Convert.ToDecimal(sum) * Convert.ToDecimal(denom), ParameterDirection.Input);

                        result = Convert.ToString(cmd.ExecuteScalar());
                    }
                }

                res[0] = result.ToUpper();
            }
            catch (Exception ex)
            {
                Deposit.SaveException(ex);
                throw ex;
            }
            finally
            {

                if (connect.State != ConnectionState.Closed)
                    connect.Close(); connect.Dispose();
            }
        }
        /// Якщо прийшли порожні дані - повертаємо порожню стрічку по ставці
        if (String.IsNullOrEmpty(type_id) || type_id == "-1000" ||
            String.IsNullOrEmpty(sum))
        {
            res[1] = String.Empty;
        }
        else
        {
            sum = sum.Replace(" ", String.Empty);

            OracleConnection connect = new OracleConnection();
            try
            {
                connect = OraConnector.Handler.IOraConnection.GetUserConnection();
                

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = @"select dpt.get_forecast_int
                      (:p_dpttype,
                       :p_dptamount,
                       bankdate,
                       :p_term_months,
                       :p_term_days)
                    from dual";
                cmd.Parameters.Add("p_dpttype", OracleDbType.Decimal, type_id, ParameterDirection.Input);
                cmd.Parameters.Add("p_dptamount", OracleDbType.Decimal, Convert.ToDecimal(sum) * Convert.ToDecimal(denom), ParameterDirection.Input);
                cmd.Parameters.Add("p_term_months", OracleDbType.Decimal, (String.IsNullOrEmpty(dur_months) ? null : dur_months), 
                    ParameterDirection.Input);
                cmd.Parameters.Add("p_term_days", OracleDbType.Decimal, (String.IsNullOrEmpty(dur_days) ? null : dur_days), 
                    ParameterDirection.Input);

                Decimal result = Convert.ToDecimal(Convert.ToString(cmd.ExecuteScalar()));
                res[1] = Convert.ToString(result / Convert.ToDecimal(denom));
            }
            catch (Exception ex)
            {
                Deposit.SaveException(ex);
                throw ex;
            }
            finally
            {

                if (connect.State != ConnectionState.Closed)
                    connect.Close(); connect.Dispose();
            }
        }
        
        return res;

    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="openDate"></param>
    /// <param name="duration_months"></param>
    /// <param name="duration_days"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public static String GetDatEnd(String openDate, String duration_months, String duration_days)
    {
        OracleConnection connect = new OracleConnection();

        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";
        
        if (String.IsNullOrEmpty(openDate) ||
            String.IsNullOrEmpty(duration_days) ||
            String.IsNullOrEmpty(duration_months))
            
            return String.Empty;

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"SELECT to_char(bars.dpt.f_duration(:OpenDate,:mDuration,:dDuration),'dd/mm/yyyy') FROM dual"; ;
            cmd.Parameters.Add("OpenDate", OracleDbType.Date, Convert.ToDateTime(openDate,cinfo), ParameterDirection.Input);
            cmd.Parameters.Add("mDuration", OracleDbType.Decimal, duration_months, ParameterDirection.Input);
            cmd.Parameters.Add("dDuration", OracleDbType.Decimal, duration_days, ParameterDirection.Input);

            return Convert.ToString(cmd.ExecuteScalar());
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            throw ex;
        }
        finally
        {

            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }        
    }

    /// <summary>
    /// Вибір валюти депозиту
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void listCurrency_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (listCurrency.SelectedItem.Value == "-1000")
            tbCurrencyCode.Text = String.Empty;
        else
        {
            tbCurrencyCode.Text = listCurrency.SelectedItem.Value;

            // Перевірка на наявність у клієнта БПК у вибраній валюті депозиту
            Decimal cust_id = (Session["DepositInfo"] as Deposit).Client.ID;

            if (!Tools.card_account_exists(cust_id, Convert.ToDecimal(tbCurrencyCode.Text)))
            {
                tbCurrencyCode.Text = String.Empty;
                listCurrency.SelectedValue = "-1000";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "error_mesage", "alert('У клієнта відсутній картковий рахунок в обраній валюті!');", true);
            }
        }

        // FillContractTypeList();
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void listContractType_SelectedIndexChanged(object sender, EventArgs e)
    {
        /// Устанавливаем состояние некоторых элементов в зависимости от
        /// вида выбранного договора
        FillContractDependControls();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void listTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        InitControls(false);
    }

    protected void FillCurrencyList()
    {
        // Перелік допустимих валют обраного депозитного продукту
        dsCurrency.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsCurrency.SelectCommand = @"select KV as Currency_Code, NAME as Currency_Name from TABVAL$GLOBAL c
                                      where exists (select 1 from DPT_VIDD v where v.KV = c.KV and v.FLAG = 1 ) ";

        dsCurrency.SelectParameters.Add("p_typeid", TypeCode.Int32, tbTypeCode.Text);

        listCurrency.DataBind();

        listCurrency.Items.Add(new ListItem("-", "-1000", true));

        listCurrency.SelectedValue = "-1000";
        tbCurrencyCode.Text = String.Empty;
    }

    /// <summary>
    /// Формування сум (в унціях та грамах) поповнення депозиту на основі інфр. про злитки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvBars_DataBound(object sender, EventArgs e)
    {
        textContractSum.Value = Bars.Metals.DepositMetals.SumOunce();
        ContractSumGrams.Value = Convert.ToString(Bars.Metals.DepositMetals.Sum());
        
        // загальна вага злитків в грамах
        if (fvBars.FindControl("TOTAL_NOMINAL") != null)
        {
            //(fvBars.FindControl("TOTAL_NOMINAL") as TextBox).Text = Convert.ToString(ContractSumGrams.Value);
            //((TextBox)fvBars.Row.FindControl("TOTAL_NOMINAL")).Text = Convert.ToString(ContractSumGrams.Value);
        }
    }

    //*************************
    //*** Робота з FormView ***
    //*************************

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvBars_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvBars.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvBars_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvBars.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvBars_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvBars.DataBind();
    }

    /// <summary>
    /// Заповнення значення поля проба металу "по замовчуванню"
    /// </summary>
    /// <param name="sender">об'єст</param>
    /// <param name="e">подія</param>
    protected void PROBA_I_PreRender(object sender, EventArgs e)
    {
        if (((Bars.Web.Controls.NumericEdit)sender).Value == 0)
            ((Bars.Web.Controls.NumericEdit)sender).Text = "999.9";
    }
    protected void checkboxIsCash_CheckedChanged(object sender, EventArgs e)
    {
        // для депозитів у МЕТАЛАХ при готівковому розміщенні
        if (kv.Value == "959" || kv.Value == "961" || kv.Value == "962")
        {
            if (checkboxIsCash.Checked)
            {
                metalParameters.Visible = true;                
                textContractSum.ReadOnly = true;
                lbMinSum.Text = Resources.Deposit.GlobalResources.Mes47;
            }
            else
            {
                metalParameters.Visible = false;
                textContractSum.ReadOnly = false;
                lbMinSum.Text = Convert.ToString(GetLocalResourceObject("lbMinSum.Text"));
            }

            textContractSum.Value = 0;
            textContractSum.Focus();
        }

        // Перерахунок %% ставки (інакше після PostBack встановлюється базове значення)
        ScriptManager.RegisterStartupScript(this, this.GetType(), "GetRate", "GetRate();", true);
    }
} 
