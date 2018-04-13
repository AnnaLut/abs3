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
using Bars.Oracle;
using Bars.Logger;
using Bars.Web.Report;
using System.Web.Services;
using Bars.Classes;
using System.Globalization;
using System.Security.Cryptography.X509Certificates;
using System.Net;

/// <summary>
/// Карточка вклада
/// </summary>
public partial class DepositContractInfo : Page
{
    /// <summary>
    /// Загрузка страницы
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositContractInfo;
        EnablePrint();
        btFirstPayment.Attributes["onclick"] = "javascript:FirstPayment();";

        btAddAgreement.Value = Resources.Deposit.GlobalResources.w00;

        if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
        {
            btAddAgreement.Visible = true;
            btAddAgreement.Attributes["onclick"] = "javascript:AddAgreement();";
        }
        else if (BankType.GetCurrentBank() == BANKTYPE.UPB)
        {
            btAddAgreement.Visible = true;

            btAddAgreement.Value = Resources.Deposit.GlobalResources.w01;

            //btAddAgreement.Value = "Доп. реквизиты вклада";
            btAddAgreement.Attributes["onclick"] = "javascript:DptAttr()";
            btFormDptText.Attributes["onclick"] = "javascript:GetTemplates();";
            btnSgnContract.Attributes["onclick"] = "javascript:if(openSign())";
        }

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
                Response.Redirect("DepositClient.aspx");

            /// Процедура реєстрації документа за вкладом
            String bpp = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                "@" + "begin dpt_web.fill_dpt_payments(" + dpt.ID + ",:REF);end;";
            AfterPay.Value = bpp;

            FillContractInfo();

            if (Request["readonly"] != null)
            {
                btFirstPayment.Disabled = true;
                btBonusRates.Disabled = true;
                btFormRate.Disabled = true;
                btSurvey.Disabled = true;
                btFormDptText.Disabled = true;
                btPrintContract.Disabled = true;
                btAddAgreement.Disabled = true;
                btnSgnContract.Disabled = true;
                btnNext.Enabled = false;
                btRollback.Disabled = true;
            }
        }
        else
        {
            Deposit dpt = (Deposit)Session["DepositInfo"];

            DBLogger.Info("Пользователь нажал на кнопку \"Подтвердить\"(первичный взнос) на странице карточки вклада",
                "deposit");

            FillContractInfo();
            if (!IS_FIRST_PAYMENT_DONE(dpt))
            {
                EnableButtons(dpt, 0);
                return;
            }
            else
            {
                if (BankType.GetCurrentBank() == BANKTYPE.UPB)
                    btFormDptText.Attributes["onclick"] = "javascript:GetTemplates();";
            }
        }

        ShowAccCard();
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
        this.btnNext.Click += new System.EventHandler(this.btnNext_Click);
        this.btFormDptText.ServerClick += new System.EventHandler(this.btFormDptText_ServerClick);
        this.btnSgnContract.ServerClick += new System.EventHandler(this.btnSgnContract_ServerClick);
        ;

    }
    #endregion
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

        if (Request["dpt_id"] != null)
            dpt.ID = Convert.ToDecimal(Request["dpt_id"].ToString());
        else if (dpt.ID == Decimal.MinValue)
            Response.Redirect("DepositClient.aspx");

        dpt.ReadFromDatabase();

        Session["DepositInfo"] = dpt;
        Session["DPTPRINT_DPTID"] = dpt.ID;
        Session["DPTPRINT_AGRID"] = null;
        Session["DPTPRINT_TEMPLATE"] = null;
        Session["DPTPRINT_AGRNUM"] = null;

        vidd.Value = dpt.Type.ToString();
        //
        // Заполняем поля формы
        //
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

        /// Для вкладів СРСР перекриваємо "особливою" операцією
        //  TT.Value = "DPB";
        
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

        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        if (dpt.EndDate < Convert.ToDateTime(BankType.GetBankDate(), cinfo) &&
            dpt.EndDate != DateTime.MinValue)
            btAddAgreement.Disabled = true;

        btRollback.Visible = false;
        //if (dpt.IsSign() || dpt.BeginDate.ToString("dd/MM/yyyy") != BankType.GetBankDate())
        //{
        //    btRollback.Visible = false;
        //}
        //else
        //    btRollback.Visible = true;

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

            if (!rdr.IsClosed) { rdr.Close(); rdr.Dispose();}

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
//                    rnk.Value = dpt.Client.ID.ToString();
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
    }
    /// <summary>
    /// Нажатие на кнопку "Новый договор"
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btnNext_Click(object sender, System.EventArgs e)
    {
        Decimal id = Decimal.MinValue;

        DBLogger.Info("Пользователь нажал на кнопку \"Новый договор\" на странице карточки вклада",
            "deposit");

        // Читаем параметры депозита
        Deposit dpt = (Deposit)Session["DepositInfo"];
        id = dpt.Client.ID;
        Session.Remove("DepositInfo");

        Response.Redirect("DepositClient.aspx?rnk=" + id.ToString());
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

        if (BankType.GetCurrentBank() == BANKTYPE.UPB)
        {
            if (Templates.Value == String.Empty)
            {
                Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al19 + "');</script>");
                //Response.Write("<script>alert('Не выбран ни один шаблон!');</script>");
                return;
            }
            else
            {
                String val = Templates.Value;
                _templates = val.Split(';');
            }
        }

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
        if (Deposit.BonusFixed(dpt.ID))
            btFormRate.Disabled = true;
        else
            btFormRate.Disabled = false;

        if (dpt.ContractTextExists(Context))
        {
            btFirstPayment.Disabled = true;
            if (BankType.GetCurrentBank() != BANKTYPE.UPB)
                btFormDptText.Disabled = true;
            btPrintContract.Disabled = false;
        }
        else if (sum > 0)
        {
            btFirstPayment.Disabled = true;
            btPrintContract.Disabled = true;
        }
        else
        {
            btFirstPayment.Disabled = false;
            btPrintContract.Disabled = true;
        }

        if (dpt.IsSign())
        {
            if (BankType.GetCurrentBank() != BANKTYPE.UPB)
                btnSgnContract.Disabled = true;
            btnNext.Enabled = true;
        }
        else if (!btPrintContract.Disabled)
        {
            if (BankType.GetCurrentBank() != BANKTYPE.UPB)
                btnSgnContract.Disabled = false;
            btnNext.Enabled = false;
        }
        else
        {
            if (BankType.GetCurrentBank() != BANKTYPE.UPB)
                btnSgnContract.Disabled = true;
            btnNext.Enabled = false;
        }

        if (dpt.IsCashSum == false)
            btFirstPayment.Disabled = true;
    }
    /// <summary>
    /// Проверка наличия первичного взноса
    /// на депозитном счету
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
    /// 
    /// </summary>
    private void EnablePrint()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "SELECT VAL FROM PARAMS WHERE PAR='C_FORMAT'";
            string result = Convert.ToString(cmd.ExecuteScalar());

            if (result == "HTML")
                btPrintContract.Attributes["onclick"] = "javascript:Print();";
            else if (result == "RTF")
                btPrintContract.Attributes["onclick"] = "javascript:ShowPrintDialog();";
            else
            {
                btPrintContract.Attributes["onclick"] = "javascript:alert('" + Resources.Deposit.GlobalResources.al22 + "');";
                //btPrintContract.Attributes["onclick"] = "javascript:alert('Формат документов не поддерживается');";
            }
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
    private void btnSgnContract_ServerClick(object sender, System.EventArgs e)
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];

        DBLogger.Info("Пользователь нажал на кнопку \"Подписать договор\" на странице карточки вклада",
            "deposit");

        if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
        {
            dpt.SignContract(Context);
        }

        FillContractInfo();
    }
    /// <summary>
    /// 
    /// </summary>
    [WebMethod(EnableSession = true)]
    public static void SaveComment(String comm,String dpt_id)
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
    protected void btFormRate_ServerClick(object sender, EventArgs e)
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            Decimal dummy = Decimal.MinValue;
            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = "begin dpt_bonus.set_bonus_rate_web(:p_dptid,trunc(sysdate),:newRate); end;";
            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);
            cmd.Parameters.Add("newRate", OracleDbType.Decimal, dummy, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }

        FillContractInfo();

        EnableButtons(dpt, dpt.dpt_p_sum);
    }
    protected void btReport_Click(object sender, EventArgs e)
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];
        if (dpt.Currency == 980)
            Response.Redirect("/barsroot/cbirep/rep_query.aspx?repid=701&codeapp=WDPT&Param0=" + Request["dpt_id"]);
        else
            Response.Redirect("/barsroot/cbirep/rep_query.aspx?repid=702&codeapp=WDPT&Param0=" + Request["dpt_id"]);
    }

    /// <summary>
    /// Перегляд картки клієнта
    /// </summary>
    protected void btShowClientCard_Click(object sender, EventArgs e)
    {
        Random r = new Random();

        String url = string.Format("window.showModalDialog('/barsroot/deposit/DepositClient.aspx?rnk={0}&info=1&code={1}',null,'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');", rnk.Value, r.Next());

        ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "ShowClientCard", url, true);
    }

    /// <summary>
    /// Перегляд картки рахунку
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btShowAccountCard_Click(object sender, EventArgs e)
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];

        Random r = new Random();

        String url = string.Format("window.showModalDialog('/barsroot/viewaccounts/accountform.aspx?type=0&acc={0}&rnk={1}&accessmode=1&dpt=rw&code={2}'),null,'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');__doPostBack('','');", dpt.dpt_acc, dpt.Client.ID, r.Next());

        ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "ShowAccountCard", url, true);            
    }

    /// <summary>
    /// 
    /// </summary>
    private void ShowAccCard()
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];
        
        if (!(dpt.Type == 786 || dpt.Type == 787   || 
            (dpt.Type >= 806 && dpt.Type <= 819) ||
            (dpt.Type >= 826 && dpt.Type <= 841)
           ))
        {
            btShowAccountCard.Visible = false;
            return;
        }

        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = @"select nvl(max(case when nvl(g1.count_req,0) >= g2.count_rod
                                                    then 0
                                            when g2.kv = 980 
                                                        then 1 
                                                when g2.kv in (840,978,643) 
                                                        then 0.5 
                                            else 0
                                        end),0)
                            from
                            ( select c.kv, count(*) count_req
                                from dpt_deposit_clos c
                                where C.RNK =  :rnk 
                                    and c.action_id = 0
                                    and (C.VIDD in (786,787) or c.vidd between 806 and 819 or c.vidd between 826 and 841)
                                    and C.DEPOSIT_ID != :dpt_id
                                    and C.when <= (select when from dpt_deposit_clos where deposit_id = :dpt_id and action_id = 0)
                                group by c.kv) g1, 
                            ( select d.kv, count(*) count_rod 
                                from dpt_deposit d , dpt_vidd v 
                                where d.rnk = :rnk
                                    and d.DEPOSIT_ID != :dpt_id
                                    and d.vidd in (846,847,848,849)
                                    and v.vidd =  :vidd
                                    and d.kv = v.kv
                                group by d.kv  ) g2
                            where g1.kv (+)= g2.kv";
            cmd.BindByName = true;
            cmd.Parameters.Add("rnk", OracleDbType.Decimal, dpt.Client.ID, ParameterDirection.Input);
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);
            cmd.Parameters.Add("vidd", OracleDbType.Decimal, dpt.Type, ParameterDirection.Input);

            if (Convert.ToDecimal(cmd.ExecuteScalar()) > 0)
                btShowAccountCard.Visible = true;

        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }        
    }
}
