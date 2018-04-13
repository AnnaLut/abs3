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
/// Выбор договора (03/09/2013)
/// </summary>
public partial class DepositContract : Bars.BarsPage
{   

    protected bool ContractIntCap;		// Признак капитализации процентов

    private string ContractTypeName
    {
        get
        {
            return (String)this.ViewState["ContractTypeName"];
        }
        set
        {
            this.ViewState["ContractTypeName"] = value;
        }
    }
    /// <summary>
    /// Процедура загрузка страницы
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        // Проверяем установлены ли переменные сессии.
        // Они устанавливаются первой страницей и содержат информацию о клиенте.
        // Если переменные не установлены, значит пришли напрямую - отправляем на первую страницу
        if ((Deposit)Session["DepositInfo"] == null)
        {
            DBLogger.Info("Пользователь зашел на страницу выбора типа депозитного договора без информации о клиенте и был перенаправлен на карточку клиента",
                "deposit");

            Response.Redirect("/barsroot/clientproducts/DepositClient.aspx");
        }

        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositContract;

        RegisterOnLoadScript("listTypes");

        if (!IsPostBack)
        {
            Bars.Metals.DepositMetals.ClearData();

            ///
            /// Инициализируем элементы страницы
            /// 

            Deposit dpt = (Deposit)Session["DepositInfo"];

            // ФИО клиента
            textClientName.Text = dpt.Client.Name;

            // Перелік типів депозитів
            FillTypeList();

            // Если первоначальный ввод, то устанавливаем умолчательные параметры
            if (dpt.Type == decimal.MinValue)
            {
                // Дата договора равна текущей системной
                string dt = DateTime.Now.ToString("dd/MM/yyyy");

                dpt.Date = Convert.ToDateTime(dt, Tools.Cinfo());
                dpt.BeginDate = Convert.ToDateTime(dt, Tools.Cinfo());

                Session["NewDeposit"] = dpt;
            }

            FillControlsFromClass(dpt);
        }
        else
        {
            DBLogger.Info("Пользователь получил информацию из страницы SearchResults", "deposit");
           //Deposit dpt = (Deposit)Session["DepositInfo"];
           // FillControlsFromClass(dpt);

        }

    }
    /// <summary>
    /// Локализация Infra
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        base.OnPreRender(evt);

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
        this.btnBack.ServerClick += new System.EventHandler(this.btnBack_ServerClick);
        this.btnSubmit.ServerClick += new System.EventHandler(this.btnSubmit_ServerClick);
    }
    #endregion

    /// <summary>
    /// Заполняем необходимые элементы значениями в зависимости от вида выбранного договора
    /// </summary>
    private void FillContractDependControls()
    {
        Deposit dpt = (Deposit)Session["NewDeposit"];

        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

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
                dpt.get_forecast_int (v.dpt_type, :p_dptamount * v.currency_denom)/v.currency_denom,
                getbrat(sysdate, v.dpt_brateid, v.currency_code, :p_dptamount * v.currency_denom), 
                v.dpt_term_type, v.currency_denom, v.dpt_months_max, v.dpt_days_max
                from V_DPT_TYPE v where v.dpt_type = :p_vidd";

                cmdSelectContractParams.BindByName = true;
                cmdSelectContractParams.Parameters.Add("p_custid", OracleDbType.Decimal, dpt.Client.ID, ParameterDirection.Input);
                cmdSelectContractParams.Parameters.Add("p_vidd", OracleDbType.Decimal, contractTypeCode, ParameterDirection.Input);
                cmdSelectContractParams.Parameters.Add("p_dptamount", OracleDbType.Decimal, textContractSum.Value, ParameterDirection.Input);

                DBLogger.Info("p_custid = " + dpt.Client.ID.ToString() + " p_vidd =" + contractTypeCode.ToString() + " p_dptamount=" + textContractSum.Value.ToString(),"deposit");
                
                RNK.Value = dpt.Client.ID.ToString() ;
                
                //якщо прийшли з вікна заведення депозиту за довіреністю
                if (Request["rnk_tr"]!=null)
                    RNK_TR.Value = Request["rnk_tr"];
            
                // Читаем данные запроса
                OracleDataReader rdr = cmdSelectContractParams.ExecuteReader();
                if (rdr.Read())
                {
                    // Наименование типа депозита
                    if (!rdr.IsDBNull(1))
                        ContractTypeName = rdr.GetOracleString(1).Value;
                    else
                        ContractTypeName = string.Empty;

                    //// Валюта депозита
                    //if (!rdr.IsDBNull(2))
                    //    textDepositCurrency.Text = rdr.GetOracleString(2).Value;
                    //else
                    //    textDepositCurrency.Text = string.Empty;

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
                        dtContractEnd.Date = Convert.ToDateTime(str_dt, Tools.Cinfo());
                    }
                    else
                        dtContractEnd.Text = string.Empty;

                    // Длительность договора (месяцев)
                    if (!rdr.IsDBNull(7))
                        textDurationMonths.Text = rdr.GetOracleDecimal(7).ToString();
                    else
                        textDurationMonths.Text = string.Empty;

                    // Длительность договора (дней)
                    if (!rdr.IsDBNull(8))
                        textDurationDays.Text = rdr.GetOracleDecimal(8).ToString();
                    else
                        textDurationDays.Text = string.Empty;

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

                    //if (!rdr.IsDBNull(10))
                    //    AbsBonus.Value = Convert.ToDecimal(rdr.GetValue(10));
                    //else
                    //    AbsBonus.Value = 0;

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
                        if (Convert.ToDecimal(rdr.GetValue(15)) == 1)
                        {
                            textDurationDays.Enabled = false;
                            textDurationMonths.Enabled = false;
                        }
                        else
                        {
                            textDurationDays.Enabled = true;
                            textDurationMonths.Enabled = true;
                        }
                    }
                    if (!rdr.IsDBNull(16))
                        denom.Value = Convert.ToString(rdr.GetOracleDecimal(16));

                     // Для Луганська термін депозиту
                    if (Convert.ToDecimal(rdr.GetValue(15)) == 2)
                    {
                        // Максимальний термін договору (місяців)
                        if (!rdr.IsDBNull(17))
                            textDurationMonths.Text = rdr.GetOracleDecimal(17).ToString();

                        // Максимальний термін договору (днів)
                        if (!rdr.IsDBNull(18))
                            textDurationDays.Text = rdr.GetOracleDecimal(18).ToString();

                        // Дата закінчення договору
                        dtContractEnd.Date = Convert.ToDateTime(GetDatEnd(dtContractBegin.Text, textDurationMonths.Text, textDurationDays.Text), Tools.Cinfo());
                    }

                    if (denom.Value == "1000")
                    {
                        textContractSum.Presiction = 3;
                        textMinSum.Presiction = 3;
                        ForecastPercent.Presiction = 3;
                    }

                    if (kv.Value == "959" || kv.Value == "961" || kv.Value == "962")
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
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    
    /// <summary>
    /// Метод заполняет страницу из класса
    /// </summary>
    private void FillControlsFromClass(Deposit dpt)
    {
        // Номер договора
        textContractNumber.Text = dpt.Number;
        
        // Тип догорова
        listContractType.SelectedIndex = listContractType.Items.IndexOf(listContractType.Items.FindByValue(dpt.Type.ToString()));                
        ContractTypeName = dpt.TypeName;

        // Сумма договора
        //if (dpt.Sum != decimal.MinValue)
        //    textContractSum.Value = dpt.Sum;
        //else
            textContractSum.Text = string.Empty;

        // Признак оплаты наличными
        checkboxIsCash.Checked = dpt.IsCashSum;

        // Дата договора
        if (dpt.Date == DateTime.MinValue)
            dtContract.Text = string.Empty;
        else
            dtContract.Text = dpt.Date.ToString("dd/MM/yyyy");

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
            textComment.ReadOnly = true;
        }
        else
        {
            listTypes.Enabled = true;
            listContractType.Enabled = true;
            textContractSum.ReadOnly = false;
            checkboxIsCash.Enabled = true;
            textComment.ReadOnly = false;
        }
    }

    /// <summary>
    /// Сохраняет данные формы в классе
    /// </summary>
    private void FillClassFromControls()
    {
        Deposit dpt = (Deposit)Session["NewDeposit"];
        
        //якщо депозит оформлюється на 3-тю особу - робимо підміну властника депозиту на знайдену особу
       /* if ((RNK_TR.Value != string.Empty && RNK_TR.Value != "undefined" && RNK_TR.Value != "-1") && (RNK.Value != string.Empty && RNK.Value != "undefined" && RNK.Value != "-1"))
        {
            //url += "&rnk=" + RNK.Value + "&rnk_tr=" + RNK_TR.Value;
            dpt.Client.ID = Convert.ToDecimal(RNK.Value);
        }*/
        
        dpt.Type = Convert.ToDecimal(listContractType.SelectedValue);
        // dpt.TypeName = listContractType.SelectedItem.Text;
        dpt.TypeName = ContractTypeName;
        dpt.Currency = Convert.ToDecimal(tbCurrencyCode.Text);
        dpt.Number = textContractNumber.Text;
        dpt.Date = Convert.ToDateTime(dtContract.Text, Tools.Cinfo());
        dpt.BeginDate = dtContractBegin.Date;
        dpt.EndDate = dtContractEnd.Date;
        dpt.Sum = textContractSum.Value;
        dpt.Sum_cent = textContractSum.Value * Convert.ToDecimal(Math.Pow(10, textContractSum.Presiction));
        dpt.IsCashSum = checkboxIsCash.Checked;
        dpt.IntCap = ContractIntCap;
        dpt.Comment = textComment.Text;
        dpt.GetTechAcc = false;
       
        if (String.IsNullOrEmpty(textDurationDays.Text))
            dpt.dpt_duration_days = 0;
        else
            dpt.dpt_duration_days = Convert.ToDecimal(textDurationDays.Text);

        if (String.IsNullOrEmpty(textDurationMonths.Text))
            dpt.dpt_duration_months = 0;
        else
            dpt.dpt_duration_months = Convert.ToDecimal(textDurationMonths.Text);

        Session["NewDeposit"] = dpt;
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
        if (Convert.ToString(Request["scheme"]) == "DELOITTE")
        {
            Response.Redirect("/barsroot/clientproducts/DptClientPortfolioContracts.aspx?cust_id=" +
                Convert.ToString((Session["NewDeposit"] as Deposit).Client.ID));
        }
        else
        {
            DBLogger.Info("Пользователь нажал на кнопку \"Назад\" на странице выбора типа депозита и вернулся на карточку клиента",
                "deposit");

            Response.Redirect("/barsroot/clientproducts/DepositClient.aspx");
        }
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
            " Тип выбраного договора " + ContractTypeName,
            "deposit");

        // Перевіряємо дані на формі
        if (CheckFormData())
        {
            // Сохраняем данные и переходим на следующую страницу
            FillClassFromControls();

            String url = "/barsroot/deposit/deloitte/DepositAccount.aspx";

            if (Request.QueryString["scheme"] == "DELOITTE")
            {
                url += "?scheme=DELOITTE";

                // Якщо вклад на бенефіціара
                if (cbOnBeneficiary.Checked)
                {
                    Session["OnBeneficiary"] = "YES";
                }
                else
                {
                    Session.Remove("OnBeneficiary");
                }
                // Якщо вклад на малолітню особу
                if (cbOnChildren.Checked)
                {
                    Session["OnChildren"] = "YES";
                }
                else
                {
                    Session.Remove("OnChildren");
                }
                if (cbOnOwner.Checked)
                {
                    Session["OnOwner"] = "YES";
                }
                else
                {
                    Session.Remove("OnOwner");
                }
                

            }
           /* DBLogger.Info("RNK_TR.Text =" + RNK_TR.Value,
      "deposit");
            DBLogger.Info("RNK.Text =" + RNK.Value,
                 "deposit");*/
            //якщо оформлюємо на 3-тю особу то передаємо доріену особу по депозиту
           if ((RNK_TR.Value != string.Empty && RNK_TR.Value != "undefined" && RNK_TR.Value != "-1") && (RNK.Value != string.Empty && RNK.Value != "undefined" && RNK.Value != "-1"))
                url += "&rnk=" + RNK.Value + "&rnk_tr=" + RNK_TR.Value;

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
        if (String.IsNullOrEmpty(type_id) ||
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
            cmd.Parameters.Add("OpenDate", OracleDbType.Date, Convert.ToDateTime(openDate, cinfo), ParameterDirection.Input);
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
    /// Вибір депозитного продукту
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void listTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        tbTypeCode.Text = listTypes.SelectedValue;

        FillCurrencyList();

        FillContractTypeList();
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
            Decimal cust_id = (Session["NewDeposit"] as Deposit).Client.ID;

            if (!Tools.card_account_exists(cust_id, Convert.ToDecimal(tbCurrencyCode.Text)))
            {
                tbCurrencyCode.Text = String.Empty;
                listCurrency.SelectedValue = "-1000";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "error_mesage", "alert('У клієнта відсутній картковий рахунок в обраній валюті!');", true);
            }
        }

        FillContractTypeList();
    }

    /// <summary>
    /// Вибір виду депозиту
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void listContractType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (listContractType.SelectedItem.Value == "-1000")
            tbContractType.Text = String.Empty;
        else
            tbContractType.Text = listContractType.SelectedItem.Value;

        /// Устанавливаем состояние некоторых элементов в зависимости от вида выбранного договора
        FillContractDependControls();

        //textContractSum.Focus();
    }

    /// <summary>
    /// Список типів депозитів (депозитних продуктів)
    /// </summary>
    protected void FillTypeList()
    {
        dsType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsType.SelectCommand = "select TYPE_ID, TYPE_NAME from DPT_TYPES where FL_ACTIVE = 1 " +
            " and FL_DEMAND = 0  order by SORT_ORD";

        listTypes.DataBind();

        listTypes.Items.Add(new ListItem("-", "-1000", true));

        listTypes.SelectedValue = "-1000";
        tbTypeCode.Text = String.Empty;
    }

    protected void FillCurrencyList()
    {
        // Перелік допустимих валют обраного депозитного продукту
        dsCurrency.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsCurrency.SelectCommand = @"select KV as Currency_Code, NAME as Currency_Name from TABVAL$GLOBAL c
                                      where exists (select 1 from DPT_VIDD v where v.TYPE_ID = :p_typeid
                                        and v.KV = c.KV and v.FLAG = 1 ) ";

        dsCurrency.SelectParameters.Add("p_typeid", TypeCode.Int32, tbTypeCode.Text);

        listCurrency.DataBind();

        listCurrency.Items.Add(new ListItem("-", "-1000", true));

        listCurrency.SelectedValue = "-1000";
        tbCurrencyCode.Text = String.Empty;
    }

    protected void FillContractTypeList()
    {
        
        // Список видів депозитів
        dsContractType.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        dsContractType.SelectCommand = @"select vidd, type_name from V_DPT_VIDD_USER 
                    where type_id = :p_type And kv = :p_kv order by vidd";

        dsContractType.SelectParameters.Add("p_type", TypeCode.Int32, listTypes.SelectedValue);
        dsContractType.SelectParameters.Add("p_kv", TypeCode.Int32, listCurrency.SelectedValue);

        listContractType.DataBind();

        listContractType.Items.Insert(0, "-");
        listContractType.Items[0].Value = "-1000";

        tbContractType.Text = String.Empty;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvBars_DataBound(object sender, EventArgs e)
    {
        textContractSum.Value = Bars.Metals.DepositMetals.SumOunce();
        ContractSumGrams.Value = Convert.ToString(Bars.Metals.DepositMetals.Sum());
        // загальна вага злитків в грамах

        if (fvBars.FindControl("TOTAL_NOMINAL") != null )
        {
            //(fvBars.FindControl("TOTAL_NOMINAL") as TextBox).Text = Convert.ToString(ContractSumGrams.Value);
            //((TextBox)fvBars.Row.FindControl("TOTAL_NOMINAL")).Text = Convert.ToString(ContractSumGrams.Value);
        }

    }
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

}
