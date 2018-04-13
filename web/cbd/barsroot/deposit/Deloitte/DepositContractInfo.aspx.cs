using System;
using System.Data;
using System.Web.UI;
using System.Web.Services;
using Bars.Classes;
using Bars.Oracle;
using Bars.Logger;
using Bars.Requests;
using Oracle.DataAccess.Client;

/// <summary>
/// Карточка вклада
/// </summary>
public partial class DepositContractInfo : Page
{
    # region PRIVATE
    private Boolean? _AllowedFlag1;
    private Boolean? _AllowedFlag2;
    private Boolean? _AllowedFlag3;
    private Boolean? _AllowedFlag4;
    private Boolean? _AllowedFlag5;
    private Boolean? _AllowedFlag6;
    private Boolean? _AllowedFlag7;
    private Boolean? _AllowedFlag8;
    # endregion

    # region PUBLIC
    /// <summary>
    /// Отримання виписок
    /// </summary>
    public Boolean AllowedFlag1
    {
        get
        {
            if (!_AllowedFlag1.HasValue)
                GetAllowedFlags();      
            return _AllowedFlag1.Value;
        }
    }
    /// <summary>
    /// Отримання депозиту по завершенні
    /// </summary>
    public Boolean AllowedFlag2
    {
        get
        {
            if (!_AllowedFlag2.HasValue)
                GetAllowedFlags();
            return _AllowedFlag2.Value;
        }
    }
    /// <summary>
    /// Дострокове повернення
    /// </summary>
    public Boolean AllowedFlag3
    {
        get
        {
            if (!_AllowedFlag3.HasValue)
                GetAllowedFlags();
            return _AllowedFlag3.Value;
        }
    }
    /// <summary>
    /// Керування рахунками
    /// </summary>
    public Boolean AllowedFlag4
    {
        get
        {
            if (!_AllowedFlag4.HasValue)
                GetAllowedFlags();
            return _AllowedFlag4.Value;
        }
    }
    /// <summary>
    /// Повернення деопзиту
    /// </summary>
    public Boolean AllowedFlag5
    {
        get
        {
            if (!_AllowedFlag5.HasValue)
                GetAllowedFlags();
            return _AllowedFlag5.Value;
        }
    }
    /// <summary>
    /// Повернення коштів з рахунків
    /// </summary>
    public Boolean AllowedFlag6
    {
        get
        {
            if (!_AllowedFlag6.HasValue)
                GetAllowedFlags();
            return _AllowedFlag6.Value;
        }
    }
    /// <summary>
    /// Закриття вкладу
    /// </summary>
    public Boolean AllowedFlag7
    {
        get
        {
            if (!_AllowedFlag7.HasValue)
                GetAllowedFlags();
            return _AllowedFlag7.Value;
        }
    }
    /// <summary>
    /// Інше
    /// </summary>
    public Boolean AllowedFlag8
    {
        get
        {
            if (!_AllowedFlag8.HasValue)
                GetAllowedFlags();
            return _AllowedFlag8.Value;
        }
    }
    # endregion

    /// <summary>
    /// Загрузка страницы
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositContractInfo;
        
        // btFirstPayment.Attributes["onclick"] = "javascript:FirstPayment();"
        // btAddAgreement.Visible = true;
        // Дод. угоди та дії
        btAddAgreement.Text = Resources.Deposit.GlobalResources.w05;

        // Шаблони
        btReport.Text = Resources.Deposit.GlobalResources.w06;

        if (!IsPostBack)
        {
            // Читаем параметры депозита
            Deposit dpt = (Deposit)Session["DepositInfo"];
           
            if (dpt == null)
            {
                dpt = new Deposit();
                Session["DepositInfo"] = dpt;
            }

            if (Request["dpt_id"] != null)
                dpt.ID = Convert.ToDecimal(Request["dpt_id"].ToString());
            else if (dpt.ID == Decimal.MinValue)
                Response.Redirect("/barsroot/clientproducts/DepositClient.aspx");

            /// Процедура реєстрації документа за вкладом
            String bpp = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                "@" + "begin dpt_web.fill_dpt_payments(" + dpt.ID + ",:REF);end;";
            AfterPay.Value = bpp;

            FillContractInfo();
            // FillContractInfo() -> EnableButtons()

     /* if (Request["rnk_tr"] != null)
            {
                DBLogger.Info("Request[rnk_tr] = " + Request["rnk_tr"].ToString(), "deposit");
            }*/
           

            if (Request["readonly"] != null)
            {
                btFirstPayment.Enabled = false;
                btSurvey.Disabled = true;
                btAddAgreement.Enabled = false;
                btnNext.Enabled = false;
                btPercentPay.Visible = false;
                btPayout.Visible = false;
            }
        }
        else
        {
         
            Deposit dpt = (Deposit)Session["DepositInfo"];

            DBLogger.Info("Пользователь нажал на кнопку \"Подтвердить\"(первичный взнос) на странице карточки вклада #" + dpt.ID.ToString(),
                "deposit");

            FillContractInfo();

            if (!IS_FIRST_PAYMENT_DONE(dpt))
            {
                EnableButtons(dpt, 0);
                return;
            }
            
        }
    }
    /// <summary>
    /// Локализация грида
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем infrag
        dtContractBegin.ToolTip = Resources.Deposit.GlobalResources.tb75;
        dtContract.ToolTip = Resources.Deposit.GlobalResources.tb76;
        dtContractEnd.ToolTip = Resources.Deposit.GlobalResources.tb77;
        textDepositAccountRest.ToolTip = Resources.Deposit.GlobalResources.tb78;
        textInterestAccountRest.ToolTip = Resources.Deposit.GlobalResources.tb79;
    }

    # region Web Form Designer generated code
    //
    override protected void OnInit(EventArgs e)
    {
        //
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //
        InitializeComponent();
        base.OnInit(e);
    }
    //
    private void InitializeComponent()
    {
        this.btnNext.Click += new System.EventHandler(this.btnNext_Click);
    }
    # endregion

    /// <summary>
    /// Заполнение информации о депозите
    /// </summary>
    private void FillContractInfo()
    {
        // Читаем параметры депозита
        Deposit dpt = (Deposit)Session["DepositInfo"];

        if (dpt == null)
        {
            dpt = new Deposit();
            Session["DepositInfo"] = dpt;
        }

   /* if (Request["rnk_tr"] != null)
        {
            DBLogger.Info("Request[rnk_tr] = " + Request["rnk_tr"].ToString(), "deposit");
        }*/
    
        if (Request["dpt_id"] != null)
            dpt.ID = Convert.ToDecimal(Request["dpt_id"].ToString());
        else if (dpt.ID == Decimal.MinValue)
            Response.Redirect("/barsroot/clientproducts/DepositClient.aspx");

        // Якщо відкриваємо в режимі "readonly" то 
        if (Request["readonly"] != null)
            dpt.ReadFromDatabaseExt(false, false, true);
        else
            dpt.ReadFromDatabaseExt(true, false, true);

        Session["DepositInfo"] = dpt;
        Session["DPTPRINT_DPTID"] = dpt.ID;
        Session["DPTPRINT_AGRID"] = null;
        Session["DPTPRINT_TEMPLATE"] = null;
        Session["DPTPRINT_AGRNUM"] = null;

        vidd.Value = dpt.Type.ToString();
        
        //////////////////////////
        // Заполняем поля формы //
        //////////////////////////

        // Номер депозита
        DPT_NUM.Text = dpt.Number.ToString();
        dpt_id.Value = dpt.ID.ToString();

        // КЛИЕНТ
        rnk.Value = Convert.ToString(dpt.Client.ID);
        
        // Наименование клиента
        textClientName.Text = dpt.Client.Name + " ( код контрагента=" + dpt.Client.ID.ToString() + ", ідентифікаційний код=" + dpt.Client.Code + ") ";
        // Тип документа
        textDocType.Text = dpt.Client.DocTypeName;
        // Серия и номер
        textDocNumber.Text = dpt.Client.DocSerial + " " + dpt.Client.DocNumber;
        // Кем выдан
        textDocOrg.Text = dpt.Client.DocOrg + " " + dpt.Client.DocDate.ToString("dd/MM/yyyy");
        // Адрес
        textClientAddress.Text = dpt.Client.Address;

        TT.Value = dpt.GetTT(DPT_OP.OP_0, CASH.YES);

        if (TT.Value == String.Empty)
            TT.Value = dpt.GetTT(DPT_OP.OP_0, CASH.NO);

        //////////////////////////////////////////////////////////////////////////
        if (dpt.Sum != Decimal.MinValue)
            SumC_t.Value = dpt.Sum.ToString();
        else
            SumC_t.Value = null;

        // ДОГОВОР
        // Номер договора
        textContractNumber.Text = dpt.Number;
        // Дата договора
        dtContract.Date = dpt.Date;
        // Дата начала договора
        dtContractBegin.Date = dpt.BeginDate;
        // Дата завершения договора
        dtContractEnd.Date = dpt.EndDate;
        //  Вид договора
        textDepositType.Text = dpt.TypeName;
        // Действующая процентная ставка
        textInterestRate.ValueDecimal = dpt.RealIntRate;

        // Перечисление процентов: ФИО получателя
        textIntTransfName.Text = dpt.IntReceiverName;
        // Перечисление процентов: Идентификационный код получателя
        textIntTransfOKPO.Text = dpt.IntReceiverOKPO;
        // Перечисление процентов: Счет получателя
        textIntTransfAccount.Text = dpt.IntReceiverAccount;
        // Перечисление процентов: МФО счета получателя
        textIntTransfMFO.Text = dpt.IntReceiverMFO;
        // Возврат депозита: ФИО получателя
        textRestTransfName.Text = dpt.RestReceiverName;
        // Возврат депозита: Ид. код получателя
        textRestTransfOKPO.Text = dpt.RestReceiverOKPO;
        // Возврат депозита: Счет получателя
        textRestTransfAccount.Text = dpt.RestReceiverAccount;
        // Возврат депозита: МФО счета получателя
        textRestTransfMFO.Text = dpt.RestReceiverMFO;
        // Комментарий
        textContractComments.Text = dpt.Comment;
        // Первинний внесок безготівкою
        ckNonCash.Checked = (dpt.dpt_nocash == "1" ? true : false);

        denom.Value = dpt.Sum_denom.ToString();
        // Если не ноль - первичный взнос сделан
        Decimal Sum = 0;

        if (dpt.EndDate < Convert.ToDateTime(BankType.GetBankDate(), Tools.Cinfo()) && dpt.EndDate != DateTime.MinValue)
            btAddAgreement.Enabled = false;

        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            String mask = "### ### ### ### ### ##0.00";

            if (dpt.Sum_denom == 1000)
                mask = "### ### ### ### ### ##0.000";

            textDepositAccount.Text = dpt.dpt_nls;
            textDepositAccountCurrency.Text = dpt.CurrencyISO;
            textDepositAccountRest.Text = dpt.dpt_f_sum.ToString(mask);
            textInterestAccount.Text = dpt.perc_nls;
            textIntAccountCurrency.Text = dpt.CurrencyISO;
            textInterestAccountRest.Text = dpt.perc_f_sum.ToString(mask);
            Kv.Value = dpt.Currency.ToString();
            Sum = dpt.dpt_p_sum;

            if (Sum == 0)
                Sum = dpt.dpt_f_sum;

            EnableButtons(dpt, Sum);

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
            cmd.ExecuteNonQuery();

            OracleCommand cmdGetKasa = connect.CreateCommand();
            cmdGetKasa.CommandText = @"select tobopack.gettobocash, s.nms, c.OKPO
                from saldo s, customer c,cust_acc ca
                where nls = tobopack.gettobocash and s.kv = :kv and c.rnk = ca.rnk and ca.acc = s.acc";

            cmdGetKasa.Parameters.Add("kv", OracleDbType.Varchar2, Kv.Value, ParameterDirection.Input);

            OracleDataReader rdr = cmdGetKasa.ExecuteReader();
            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    Nls_B.Value = rdr.GetOracleString(0).Value;
                if (!rdr.IsDBNull(1))
                    Nam_B.Value = rdr.GetOracleString(1).Value;
                if (!rdr.IsDBNull(2))
                    Id_B.Value = rdr.GetOracleString(2).Value;
            }

            if (!rdr.IsClosed) { rdr.Close(); rdr.Dispose(); }

            if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
            {
                Decimal sur_type = 1;
                OracleCommand cmdGetSurType = connect.CreateCommand();
                cmdGetSurType.CommandText = "select cust_survey.get_survey_id('SURVDPT0') from dual";
                sur_type = Convert.ToDecimal(cmdGetSurType.ExecuteScalar());

                OracleCommand cmdCheckSurvey = connect.CreateCommand();
                cmdCheckSurvey.CommandText = "select cust_survey.fill_up_survey(:rnk,:sur_type) from dual";
                cmdCheckSurvey.Parameters.Add("rnk", OracleDbType.Decimal, dpt.Client.ID, ParameterDirection.Input);
                cmdCheckSurvey.Parameters.Add("sur_type", OracleDbType.Decimal, sur_type, ParameterDirection.Input);

                String res_sur = Convert.ToString(cmdCheckSurvey.ExecuteScalar());

                if (res_sur != "1")
                    btSurvey.Visible = false;
                else
                {
                    btSurvey.Visible = true;
                }
            }
            else
                btSurvey.Visible = false;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close();
        }
        if (Deposit.Is_Pawn(dpt.ID.ToString()))//якщо депозит в заставі по кредиту - виключити можливість додугод та дострокового повернення
        {
            btAddAgreement.Enabled = false;
            btPayout.Enabled = false;
        }

    }
    /// <summary>
    /// Нажатие на кнопку "Новый договор"
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btnNext_Click(object sender, System.EventArgs e)
    {
        Decimal id = (Session["DepositInfo"] as Deposit).Client.ID;

        DBLogger.Info("Користувач натиснув кнопку \"Портфель договорів\" на сторінці Картка Вкладу.", "deposit");

        // чистим інф.про депозит залишаючи дані про клієнта
        ((Deposit)Session["DepositInfo"]).Clear(false);

        String url = "/barsroot/clientproducts/DptClientPortfolioContracts.aspx?cust_id=";

        if (Request["rnk_tr"] != null)
            url += Request.QueryString["rnk_tr"];

        else if (Request["inherit_id"] != null)
            url += Request.QueryString["inherit_id"];

        else
            url += id.ToString();

        Response.Redirect(url);
    }
    /// <summary>
    /// Подтверждение первичного взноса
    /// на депозитный счет
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btFormDptText_ServerClick(object sender, System.EventArgs e)
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];
        String[] _templates = new String[1];

        DBLogger.Info("Пользователь нажал на кнопку \"Подтвердить\"(первичный взнос) на странице карточки вклада",
            "deposit");

        FillContractInfo();

        if (!IS_FIRST_PAYMENT_DONE(dpt))
        {
            EnableButtons(dpt, 0);

            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al20 + "')</script>");
            //Response.Write("<script>alert('Первичный взнос не сделан!')</script>");
            Response.Flush();
            return;
        }

        if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
        {
            if (!dpt.BonusRequestDone())
            {
                EnableButtons(dpt, 1);

                Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al21 + "')</script>");
                //Response.Write("<script>alert('По данному договору есть необработанные запросы!')</script>");
                Response.Flush();
                return;
            }
        }

        if (BankType.GetCurrentBank() == BANKTYPE.UPB)
        {
            dpt.AddContractText(Context, _templates);
            EnableButtons(dpt, 1);
        }
        else if (!dpt.ContractTextExists(Context))
        {
            dpt.AddContractText(Context);
            EnableButtons(dpt, 1);
        }
    }
    /// <summary>
    /// Включить нужные кнопки
    /// </summary>
    /// <param name="dpt">Депозит</param>
    /// <param name="sum">Сумма на счету</param>
    private void EnableButtons(Deposit dpt, Decimal sum)
    {
    
        if (sum > 0)
        {
            btFirstPayment.Enabled = false;
            btRreplenish.Disabled = !dpt.AddPaymentEnabled(); // кнопка поповнення доступна якщо депозит передбачає поповнення і є перший внесок
        }
        else
        {
            btFirstPayment.Enabled = true;
            btRreplenish.Disabled = true;

            eadFinmonQuestionnaire.Visible = true;
            
            // btPercentPay.Enabled = false;
        }
        
      
        // Обслуговування згідно ЕБП (Ощадбанк)
        if (Request["scheme"] == "DELOITTE")
        {
            // Перегляд документів в ЕА
            EADocsView.Enabled = true;
            EADocsView.RNK = Convert.ToInt64(rnk.Value);
            EADocsView.AgrID = Convert.ToInt64(dpt_id.Value);

            // 
            if (Request["readonly"] == null)
            {                
                // Для договорів відкритих по ЕБП
                if (Tools.get_EADocID(dpt.ID) > 0)
                {
                    // Друк
                    //eadPrintContract.Enabled = false;
                    eadPrintContract.Enabled = true;
                    eadPrintContract.RNK = Convert.ToInt64(rnk.Value);
                    eadPrintContract.AgrID = Convert.ToInt64(dpt_id.Value);
                    //якщо договір підписно - проставляємо відмітку.
                    if (dpt.IsSign())
                    {
                        eadPrintContract.Signed();
                    }

                    // Виплата %%
                    //якщо сума більше 0 і дозволена виплата у налаштуваннях відділення
                    if (Tools.DPT_PAY_CASHDESK() == 1)
                    {
                        btPercentPay.Enabled = true;
                    }
                    else
                         btPercentPay.Enabled = false;
                }
                else
                {
                    // Перегляд документів в ЕА
                    EADocsView.Enabled = false;

                    // Друк договору через FR з передачею в ЕА
                    eadPrintContract.Enabled = true;
                    eadPrintContract.RNK = Convert.ToInt64(rnk.Value);
                    eadPrintContract.AgrID = Convert.ToInt64(dpt_id.Value);

                    // для "старих" виплата %% (готівкою) дозволена не тільки в кінці 
                    btPercentPay.Enabled = true;
                }

                if (dtContractEnd.Date <= Convert.ToDateTime(BankType.GetBankDate(), Tools.Cinfo()))
                {
                    btPayout.Text = "Виплата депозиту";
                    // btPercentPay.Enabled = true;
                }
                else
                {
                    btPayout.Text = "Дострокове повернення";
                }

                // РНК власника (або довіреної особи) депозиту
                Int64 cust_id = Convert.ToInt64(((Request["rnk_tr"] == null) ? rnk.Value : Request.QueryString["rnk_tr"]));

                // якщо в користувача: НЕ повний рівень доступу + відсутній запит на доступ + вклад відкривався по ЕБП
                if ((ClientAccessRights.Get_AccessLevel(cust_id) == LevelState.Limited) && 
                    (DepositRequest.HasActive(cust_id, dpt.ID) == false) &&
                    (Tools.get_EADocID(Convert.ToDecimal(dpt_id.Value)) >= 0))
                {
                    // ховаємо поля сум, та кнопки виконання фінансових операцій
                    textDepositAccountRest.Visible = false;
                    textInterestAccountRest.Visible = false;

                    btPercentPay.Enabled = false;
                    btPayout.Enabled = false;
                    btShowHistory.Enabled = false;
                }
                else
                {
                    // для "повоного доступу" фарбуємо фон поля № депозиту в зелений
                    DPT_NUM.BackColor = System.Drawing.Color.LightGreen;                   
                }

                // Якщо довірена особа перевіряємо перелік доступних операцій та сум
                if (Request["rnk_tr"] != null)
                {
                    // Друк виписок
                    btReport.Enabled = AllowedFlag2;

                    if (dtContractEnd.Date <= Convert.ToDateTime(BankType.GetBankDate(), Tools.Cinfo()))
                    {
                        // Виплата вкладу по завершенні
                        btPayout.Enabled = AllowedFlag5;
                    }
                    else
                    {
                        // Дострокове повернення
                        btPayout.Enabled = AllowedFlag6;
                    }
                    // поповнення
                    btRreplenish.Disabled = !AllowedFlag3;
                    // Створення ДУ
                    btAddAgreement.Enabled = AllowedFlag1;
                }

                // Якщо 3-я особа спадкоємець
                if (Request["inherit_id"] != null)
                {
                    eadPrintContract.Visible = false;
                    btRreplenish.Disabled = true;
                    btAddAgreement.Enabled = false;
                    btReport.Enabled = false;
                    btShowHistory.Enabled = false;
                }
            }
            else
            {
                // Тільки ПЕРЕГЛЯД картки депозиту
                btSaveComment.Disabled = true;
                eadPrintContract.Visible = false;
                btFirstPayment.Visible = false;
                btRreplenish.Visible = false;
                btAddAgreement.Visible = false;
                btReport.Visible = false;
                btSurvey.Visible = false;
                btShowHistory.Visible = false;
                btnNext.Visible = false;
            }
        }
        else
        {
            if (dpt.IsSign())
            {
                btnNext.Enabled = true;
            }
            else
            {
                btnNext.Enabled = false;
            }
        }

        if (dpt.IsCashSum == false)
            btFirstPayment.Enabled = false;
    }

    /// <summary>
    /// Проверка наличия первичного взноса на депозитном счету
    /// </summary>
    /// <param name="dpt">Депозит</param>
    /// <returns>сделан\не сделан</returns>
    private bool IS_FIRST_PAYMENT_DONE(Deposit dpt)
    {
        /// Якщо внесок безготівковий
        /// то не чекаємо коли його зроблять
        if (!dpt.IsCashSum) return true;

        OracleConnection connect = new OracleConnection();
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

            OracleCommand cmdDepositInfo = new OracleCommand();
            cmdDepositInfo.Connection = connect;
            cmdDepositInfo.CommandText = "select a.ostb from dpt_deposit d, saldo a where d.deposit_id=:dpt_id and d.acc=a.acc";
            cmdDepositInfo.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);

            Decimal sum = Convert.ToDecimal(cmdDepositInfo.ExecuteScalar());

            if (Math.Abs(sum) >= dpt.Sum)
                return true;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        return false;
    }

    /// <summary>
    /// Збереження коментаря
    /// </summary>
    [WebMethod(EnableSession = true)]
    public static void SaveComment(String comm, String dpt_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"update dpt_deposit
                set comments = :comm 
                where deposit_id = :dpt_id ";
            cmd.Parameters.Add("comm", OracleDbType.Varchar2, comm, ParameterDirection.Input);
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btRreplenish_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач натиснув кнопку \"Поповнити вклад\" на картці депозитного договору №" + dpt_id.Value, "deposit");

        String url = "DepositAddSum.aspx?dpt_id=" + dpt_id.Value + "&agr_id=2&fast=Y&portfolio=Y";

        if (Request["rnk_tr"] != null)
			url += "&rnk_tr=" + Request.QueryString["rnk_tr"];

        Response.Redirect(url);
    }

    /// <summary>
    /// Шаблони (друковані форми)
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btReport_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач натиснув кнопку \"Шаблони\" на картці депозитного договору №" + dpt_id.Value, "deposit");

        String url = "DptTemplates.aspx?dpt_id=" + dpt_id.Value;

        if (Request["rnk_tr"] != null)
            url += ("&rnk_tr=" + Request.QueryString["rnk_tr"]);

        Response.Redirect(url);
    }

    /// <summary>
    /// Виплата вкладу / Дострокове розірвання
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btPayout_Click(object sender, EventArgs e)
    {
        String url = "/barsroot/deposit/deloitte/DepositSelectTT.aspx?dpt_id=" + dpt_id.Value + "&scheme=DELOITTE";

        if (dtContractEnd.Date <= Convert.ToDateTime(BankType.GetBankDate(), Tools.Cinfo()))
        {
            // Виплата вкладу по завершенні
            url += "&dest=return";                
        }
        else
        {
            // Дострокове повернення
            url += "&dest=close";
        }

        if (Request["rnk_tr"] != null)
			url += "&rnk_tr=" + Request.QueryString["rnk_tr"];

        if (Request["inherit_id"] != null)
            url += "&inherit_id=" + Request.QueryString["inherit_id"];

        Response.Redirect(url);
    }

    /// <summary>
    /// Виплата відсотків по договору
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btPercentPay_Click(object sender, EventArgs e)
    {
        Response.Redirect("DepositSelectTT.aspx?dpt_id=" + dpt_id.Value + "&dest=percent&scheme=DELOITTE" +
            ((Request["rnk_tr"] != null) ? ("&rnk_tr=" + Request.QueryString["rnk_tr"]) : ""));
    }

    /// <summary>
    /// Додаткові угоди 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btAddAgreement_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач натиснув \"Додаткові угоди\" на картці договору #" + dpt_id.Value, "deposit");

        String url = "DepositAgreement.aspx?dpt_id=" + dpt_id.Value;

        if (Request["rnk_tr"] != null)
            url += ("&rnk_tr=" + Request.QueryString["rnk_tr"]);

        if (Request["scheme"] != null)
            url += ("&scheme=" + Request.QueryString["scheme"]);

        Response.Redirect(url);
    }
    
    /// <summary>
    /// ЕАД (Пошук шаблону для друку депозитного договору)
    /// </summary>
    protected void PrintContract_BeforePrint(object sender, EventArgs e)
    {
        eadPrintContract.TemplateID = Tools.Get_TemplateID((Session["DepositInfo"] as Deposit).ID, 1);
    }
    
    /// <summary>
    /// ЕАД (Збереження відмітки про наявність підписаного клієнтом депозитного договору)
    /// </summary>
    protected void PrintContract_DocSigned(object sender, System.EventArgs e)
    {
        Decimal docid = eadPrintContract.DocID.Value;

        DBLogger.Info("Користувач встновив відмітку про отримання договору підписаного клієнтом (dpt_id=" +
             dpt_id.Value + ", EA_doc_id=" + Convert.ToString(docid), "deposit");

        // Зберегти в БД ІД договору в ЕАД
        Tools.set_EADocID(Convert.ToDecimal(dpt_id.Value), docid);

        Deposit dpt = (Deposit)Session["DepositInfo"];

        // Відправка SMS повідомлення про відкриття депозиту

	//ID-3257 - запрет на отправку
        //Tools.Send_SMS(dpt.Client.ID, String.Format("Vidkryto depozyt N {0} na sumu {1} {2}.", dpt.ID, dpt.Sum.ToString("### ### ##0.00"), dpt.CurrencyISO)); 
    }

    /// <summary>
    /// ЕАД ()
    /// </summary>
    protected void eadFinmonQuestionnaire_BeforePrint(object sender, EventArgs e)
    {
        // Опитувальний лист фінмоніторингу
        eadFinmonQuestionnaire.TemplateID = "DPT_FINMON_QUESTIONNAIRE";
        eadFinmonQuestionnaire.RNK = Convert.ToInt64(rnk.Value);
        eadFinmonQuestionnaire.AgrID = Convert.ToInt64(dpt_id.Value);
    }

    /// <summary>
    /// ЕАД ()
    /// </summary>
    protected void eadFinmonQuestionnaire_DocSigned(object sender, EventArgs e)
    {
        eadFinmonQuestionnaire.Visible = false;
        btFirstPayment.Enabled = false;

        Deposit dpt = (Deposit)Session["DepositInfo"];

        // Якщо ще не зроблений первинний внесок
        if (!IS_FIRST_PAYMENT_DONE(dpt))
        {
            FirstPayment();
        }
    }

    /// <summary>
    /// Первинний внесок при відкритті вкладу
    /// </summary>
    protected void btFirstPayment_Click(object sender, EventArgs e)
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];
        
        // Друк анкети для фін.моніторингу
        if ((dpt.Sum != Decimal.MinValue) && (Tools.PrintQuestionnaire(Convert.ToInt32(dpt.Currency), (dpt.Sum * dpt.Sum_denom))))
        {
            DBLogger.Info("Сума депозиту #" + dpt.ID.ToString() + " підпадає під контроль фінмоніторингу.", "deposit");

            btFirstPayment.Enabled = false;

            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "Mesage",
                "alert('Сума депозиту підпадає під контроль фінмоніторингу! " +
                "Розміщення можливе лише після друку опитувального листа!');", true);
        }
        else
        {
            FirstPayment();
            btFirstPayment.Enabled = false;

        }
    }

    /// <summary>
    /// Вікно документу розміщення депозиту
    /// </summary>
    private void FirstPayment()
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];

        String sum = "";

        if (dpt.Sum != Decimal.MinValue)
        {
            sum = "&SumC_t=" + (dpt.Sum * dpt.Sum_denom).ToString();
        }

        Random r = new Random();

        String AfterPayProc = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
            "@begin dpt_web.fill_dpt_payments(" + dpt_id.Value + ", :REF); end;";

        String url = "/barsroot/DocInput/DocInput.aspx?tt=" + TT.Value +
            "&nd=" + dpt_id.Value +
             sum +
            "&Kv_A=" + Kv.Value +
            "&Kv_B=" + Kv.Value +
            "&Nls_A=" + textDepositAccount.Text +
            "&RNK=" + rnk.Value +
            "&APROC=" + AfterPayProc +
            "&code=" + r.Next();

        url = "window.showModalDialog('" + url + "',null,'dialogWidth:650px; dialogHeight:800px; center:yes; status:no');" +
            "location.replace('DepositAddSumComplete.aspx?action=replenish" +
            "&rnk=" + dpt.Client.ID.ToString()  + "');";//додано перехід на візування згідно заявки про результати тестування.

        ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "DocInput", url, true);
    }

    /// <summary>
    ///  Перегляд історії
    /// </summary>
    protected void btShowHistory_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач натиснув кнопку \"Історія\" на картці депозитного договору #" + dpt_id.Value, "deposit");

        String url = "DepositHistory.aspx?dpt_id=" + dpt_id.Value;

        if (Request["rnk_tr"] != null)
            url += "&rnk_tr=" + Request.QueryString["rnk_tr"];

        Response.Redirect(url);
    }

    /// <summary>
    /// 
    /// </summary>
    private void GetAllowedFlags()
    {
        _AllowedFlag1 = false;
        _AllowedFlag2 = false;
        _AllowedFlag3 = false;
        _AllowedFlag4 = false;
        _AllowedFlag5 = false;
        _AllowedFlag6 = false;
        _AllowedFlag7 = false;
        _AllowedFlag8 = false;
        if (Request["rnk_tr"] != null)
        {
            DepositAgreement.GetAllowedFlags(
                Convert.ToDecimal(dpt_id.Value), 
                Convert.ToDecimal(Request.QueryString["rnk_tr"]),
                out _AllowedFlag1, 
                out _AllowedFlag2, 
                out _AllowedFlag3, 
                out _AllowedFlag4, 
                out _AllowedFlag5, 
                out _AllowedFlag6, 
                out _AllowedFlag7, 
                out _AllowedFlag8);
        }
    }
}
