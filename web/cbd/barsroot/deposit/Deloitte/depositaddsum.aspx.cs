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
using Oracle.DataAccess.Client;
using Bars.Logger;
using Bars.Exception;
using System.Web.Services;
using Bars.Classes;

/// <summary>
/// Summary description for DepositAddSum.
/// </summary>
public partial class DepositAddSum : Bars.BarsPage
{
    /// <summary>
    /// Загрузка страницы
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (!IsPostBack)
        {
            Page.Header.Title = Resources.Deposit.GlobalResources.hDepositAddSum;

            if (Request["dpt_id"] == null)
                Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=replenish");

            if (Tools.DPT_WORK_SCHEME() == "OLD")
            {
                // для користувачів не ЕБП схеми друк опитувальника недоступний
                eadFinmonQuestionnaire.Visible = false;
            }

            Deposit dpt = new Deposit(Convert.ToDecimal(Request["dpt_id"]), false);

            dpt_id.Value = dpt.ID.ToString();

            if ((dpt.BeginDate == DateTime.Now.Date) && (dpt.dpt_p_sum == 0))
            {
                // якщо договір відкритий сьогодні та ще не було зроблено розміщення
            }

            FillControlsFromClass(dpt);
            CheckStopFunction(textMinAddSum.ValueDecimal * 100, Convert.ToDecimal(Kv_B.Value), Nls_A.Value, dpt_id.Value);
            btFirstPayment.Enabled = !dpt.IS_FIRST_PAYMENT_DONE();
            btnAdd.Enabled = dpt.AddPaymentEnabled();

            if (!dpt.IS_FIRST_PAYMENT_DONE())
            {
                textContractAddSum.Value = dpt.Sum.ToString();
            }

            if (dpt.IS_FIRST_PAYMENT_DONE() && !dpt.AddPaymentEnabled())
            {
                DBLogger.Info("Депозит #" + dpt_id.Value.ToString() + " не передбачає поповнення!", "deposit");

                String script = "<script> alert('Вибраний депозитний договір не передбачає поповнення!');";
                script += "location.replace('" + "/barsroot/deposit/deloitte/DepositContractInfo.aspx?scheme=DELOITTE&dpt_id=" + dpt_id.Value.ToString() + "')</script>";
                Response.Write(script);
                Response.Flush();
                //Response.Redirect("/barsroot/deposit/deloitte/DepositContractInfo.aspx?scheme=DELOITTE&dpt_id=" + dpt_id.Value.ToString());
                // throw new DepositException("Вибраний депозитний договір не передбачає поповнення!");
            }

           /* if (AddPaymentEnabled()) // якщо у вид вкладу додано опер. поповнення
            {
                FillControlsFromClass(dpt);
                CheckStopFunction(textMinAddSum.ValueDecimal * 100, Convert.ToDecimal(Kv_B.Value), Nls_A.Value, dpt_id.Value);
                if (!IS_FIRST_PAYMENT_DONE(dpt))
                { 
                    btFirstPayment.Enabled = true;
                    btnAdd.Enabled = false;
                }
                else
                { 

                    btFirstPayment.Enabled = false;
                    btnAdd.Enabled = true;
                }
                
            }
            else
                { 
                //throw new DepositException("Вибраний вид депозитного договору не передбачає поповнення");
                FillControlsFromClass(dpt);
                    
                DBLogger.Info("Сума депозиту #" + dpt.Sum.ToString(), "deposit");
                DBLogger.Info("Валюта депозиту #" + dpt.Currency.ToString(), "deposit");
                textContractAddSum.Value = dpt.Sum.ToString();
                btnAdd.Enabled = false;

                if (!IS_FIRST_PAYMENT_DONE(dpt))
                    btFirstPayment.Enabled = true;
                else
                    {
                        btFirstPayment.Enabled = false;
                        throw new DepositException("Вибраний депозитний договір не передбачає поповнення!");
                    }
                }*/

        }
    }
    /// <summary>
    /// Локализация Infra
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        DateR.ToolTip = Resources.Deposit.GlobalResources.tb22;
        textIntRate.ToolTip = Resources.Deposit.GlobalResources.tb23;
        dtStartContract.ToolTip = Resources.Deposit.GlobalResources.tb24;
        dtEndContract.ToolTip = Resources.Deposit.GlobalResources.tb26;
        textMinAddSum.ToolTip = Resources.Deposit.GlobalResources.tb87;
        textContractAddSum.ToolTip = Resources.Deposit.GlobalResources.tb88;
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
        ;
    }
    #endregion
    /// <summary>
    /// Заполнение контролов страницы из класса депозита
    /// </summary>
    /// <param name="dpt"></param>
    private void FillControlsFromClass(Deposit dpt)
    {
        textDepositNumber.Text = Convert.ToString(dpt.Number);
        textClientName.Text = dpt.Client.Name;
        textContractTypeName.Text = dpt.TypeName;
        textDepositCurrency.Text = dpt.CurrencyName;
        textIntRate.ValueDecimal = dpt.RealIntRate;
        textContractCurrency.Text = dpt.CurrencyISO;
        textMinSumCurrency.Text = dpt.CurrencyISO;
        textClientPasp.Text = dpt.Client.DocSerial + " " + dpt.Client.DocNumber
            + " " + dpt.Client.DocOrg;
        DateR.Date = dpt.Client.BirthDate;
        dtEndContract.Date = dpt.EndDate;
        dtStartContract.Date = dpt.BeginDate;

        // Вклади у БАНКІВСЬКИХ МЕТАЛАХ:
        if (dpt.Currency == 959 || dpt.Currency == 961 || dpt.Currency == 962)
        {
            // сума формується на основі опису злитків
            metalParameters.Visible = true;
            textContractAddSum.Value = "0";
            textContractAddSum.ReadOnly = true;

            // депозити розміщаються і виплачуються тільки через поточні рахунки
            if (dpt.EndDate == DateTime.MinValue)
            {
                TT.Value = dpt.GetTT(DPT_OP.OP_1, CASH.YES);
            }
            else
            {
                TT.Value = dpt.GetTT(DPT_OP.OP_1, CASH.NO);
            }
        }
        else
        {
            textContractAddSum.ReadOnly = false;
            TT.Value = dpt.GetTT(DPT_OP.OP_1, CASH.YES);
        }


        Kv_B.Value = Convert.ToString(dpt.Currency);
        Nls_A.Value = dpt.dpt_nls;

        if (Request["rnk_tr"] != null)
            RNK.Value = Convert.ToString(Request["rnk_tr"]);
        else
            RNK.Value = Convert.ToString(dpt.Client.ID);

        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSelMinSum = connect.CreateCommand();
            cmdSelMinSum.CommandText = "select nvl(limit,0), tobopack.gettobocash from dpt_vidd where vidd = :vidd";
            cmdSelMinSum.Parameters.Add("vidd", OracleDbType.Decimal, dpt.Type, ParameterDirection.Input);

            OracleDataReader rdr = cmdSelMinSum.ExecuteReader();

            if (!rdr.Read())
                throw new DepositException("Не найдена информация о депозите №" + dpt.ID);

            Decimal limit = rdr.GetOracleDecimal(0).Value;
            
            if (!rdr.IsDBNull(1))
                Nls_B.Value = rdr.GetOracleString(1).Value;

            rdr.Close();
            rdr.Dispose();

            if (limit != Decimal.MinValue)
                textMinAddSum.ValueDecimal = limit;
            else
                textMinAddSum.ValueDecimal = 0;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Краткая проверка депозита на пополняемость
    /// </summary>
    /// <param name="dpt">депозит</param>
    /// <returns>возможно или нет пополнение</returns>
    private bool AddPaymentEnabled()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetRight = connect.CreateCommand();
            cmdGetRight.CommandText = @"select o.tt from DPT_TTS_VIDD v, OP_RULES o, DPT_DEPOSIT d 
                where v.vidd = d.vidd and v.tt = o.tt and o.TAG = 'DPTOP' and o.val = '1' 
                and o.tt like 'DP%'   and d.deposit_id = :dpt_id";
            cmdGetRight.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id.Value, ParameterDirection.Input);

            /// Якщо не дозволено поповнення
            if (String.IsNullOrEmpty(Convert.ToString(cmdGetRight.ExecuteScalar())))
                return false;

            DBLogger.Debug("Вид депозитного договора № " + dpt_id.Value + " допускает операцию пополнения.","deposit");

            return true;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Полная проверка депозита на пополняемость
    /// </summary>
    /// <param name="SUM">Сумма</param>
    /// <param name="dpt">Депозит</param>
    [WebMethod(EnableSession = true)]
    public static void CheckStopFunction(Decimal SUM, Decimal Kv, String Nls, String dpt_id)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdCheckStopFunc = connect.CreateCommand();
            cmdCheckStopFunc.CommandText = "select f_dpt_stop(:kod,:kv,:nls,:s,bankdate) from dual";

            // Стоп правило на срок поповнення
            cmdCheckStopFunc.Parameters.Add("kod", OracleDbType.Decimal, 1, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("kv", OracleDbType.Decimal, Kv, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("nls", OracleDbType.Varchar2, Nls, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("s", OracleDbType.Decimal, SUM, ParameterDirection.Input);

            Decimal result = Convert.ToDecimal(Convert.ToString(cmdCheckStopFunc.ExecuteScalar()));

            // Стоп правило на мінімальну суму поповнення
            cmdCheckStopFunc.Parameters.Clear();
            cmdCheckStopFunc.Parameters.Add("kod", OracleDbType.Decimal, 2, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("kv", OracleDbType.Decimal, Kv, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("nls", OracleDbType.Varchar2, Nls, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("s", OracleDbType.Decimal, SUM, ParameterDirection.Input);

            DBLogger.Info("SUM " + SUM.ToString() + "", "deposit");
            result = Convert.ToDecimal(Convert.ToString(cmdCheckStopFunc.ExecuteScalar()));

            // Стоп правило на максимальну суму поповнення
            cmdCheckStopFunc.Parameters.Clear();

            if (BankType.GetDptBankType() == BANKTYPE.UPB)
                cmdCheckStopFunc.Parameters.Add("kod", OracleDbType.Decimal, 23, ParameterDirection.Input);
            else
                cmdCheckStopFunc.Parameters.Add("kod", OracleDbType.Decimal, 24, ParameterDirection.Input);

            cmdCheckStopFunc.Parameters.Add("kv", OracleDbType.Decimal, Kv, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("nls", OracleDbType.Varchar2, Nls, ParameterDirection.Input);
            cmdCheckStopFunc.Parameters.Add("s", OracleDbType.Decimal, SUM, ParameterDirection.Input);

            result = Convert.ToDecimal(Convert.ToString(cmdCheckStopFunc.ExecuteScalar()));

            DBLogger.Debug("Стоп функция на пополнение счёта для депозита № " + dpt_id +
                " завершилась. Текущий депозитный договор можно пополнять.", "deposit");
            
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// Проверка наличия первичного взноса на депозитном счету
    /// </summary>
    /// <param name="dpt">Депозит</param>
    /// <returns>сделан\не сделан</returns>
    private bool IS_FIRST_PAYMENT_DONE( Deposit dpt )
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
            cmdDepositInfo.CommandText = "select a.ostb from dpt_deposit d, accounts a where d.deposit_id=:dpt_id and d.acc=a.acc";
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
    /// Поповнити
    /// </summary>
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (textContractAddSum.ValueDecimal >= textMinAddSum.ValueDecimal)
        {
         //   DBLogger.Info("Сума поповнення депозиту #" + textMinAddSum.ValueDecimal.ToString() + "", "deposit");
            CheckStopFunction(textMinAddSum.ValueDecimal * 100, Convert.ToDecimal(Kv_B.Value), Nls_A.Value, dpt_id.Value);

            // Друк анкети для фін.моніторингу
            if (eadFinmonQuestionnaire.Visible && Tools.PrintQuestionnaire(Convert.ToInt32(Kv_B.Value), textContractAddSum.ValueDecimal * 100))
            {
                DBLogger.Info("Сума поповнення депозиту #" + dpt_id.Value + " підпадає під контроль фінмоніторингу.", "deposit");

                btnAdd.Enabled = false;
                textContractAddSum.Enabled = false;

                ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "Mesage",
                    "alert('Сума поповнення депозиту підпадає під контроль фінмоніторингу! " +
                    "Поповнення можливе лише після друку опитувального листа!');", true);
            }
            else
            {
                replenish();
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "Error", "alert('Сума поповнення менша від мінімально допустимої!');", true);

            textContractAddSum.Focus();
        }

    }

    /// <summary>
    /// Вікно документу поповнення депозиту
    /// </summary>
    private void replenish()
    {
        Random r = new Random();

        IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
        String AfterPayProc = conn.GetSetRoleCommand("DPT_ROLE");
        AfterPayProc += "@begin dpt_web.fill_dpt_payments( " + dpt_id.Value + ", :REF ); end;";

        String url = "/barsroot/DocInput/DocInput.aspx?tt=" + TT.Value +
            "&nd=" + dpt_id.Value +
            "&SumC_t=" + (textContractAddSum.ValueDecimal * 100).ToString() +
            "&Kv_A=" + Kv_B.Value +
            "&Kv_B=" + Kv_B.Value +
            "&Nls_A=" + Nls_A.Value +
            "&RNK=" + RNK.Value +
            "&bal=0" + // Ховаєм поле з залишком на рахунку в формі вводу документу
            "&code=" + r.Next() +
            "&APROC=" + AfterPayProc;

        url = "window.showModalDialog('" + url + "',null,'dialogWidth:650px; dialogHeight:800px; center:yes; status:no'); " +
            "location.replace('DepositAddSumComplete.aspx?action=replenish" + 
            (Request["portfolio"] != null ? ("&rnk=" + RNK.Value) : "") + "');";

        ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "DocInput", url, true);
    }

    /// <summary>
    /// Вікно документу первинного внеску депозиту
    /// </summary>
    private void FirstPayment()
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Request["dpt_id"]), false);

        String sum = "";

        if (dpt.Sum != Decimal.MinValue)
        {
            sum = "&SumC_t=" + (dpt.Sum * dpt.Sum_denom).ToString();
        }

        Random r = new Random();
        string TT;
        TT = dpt.GetTT(DPT_OP.OP_0, CASH.YES);
        if (TT == String.Empty)
            TT = dpt.GetTT(DPT_OP.OP_0, CASH.NO);

        String AfterPayProc = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
            "@begin dpt_web.fill_dpt_payments(" + dpt_id.Value + ", :REF); end;";

        DBLogger.Info("поповнення депозиту #" + TT + " ;" + dpt.Currency.ToString() + "; " + dpt.dpt_nls + " ;" + dpt.Client.ID.ToString() , "deposit");

          String url = "/barsroot/DocInput/DocInput.aspx?tt=" + TT +
              "&nd=" + dpt_id.Value +
               sum +
              "&Kv_A=" + Convert.ToInt32(dpt.Currency) +
              "&Kv_B=" + Convert.ToInt32(dpt.Currency) +
              "&Nls_A=" + dpt.dpt_nls +
              "&RNK=" + dpt.Client.ID +
              "&APROC=" + AfterPayProc +
              "&code=" + r.Next();

          url = "window.showModalDialog('" + url + "',null,'dialogWidth:650px; dialogHeight:800px; center:yes; status:no');" +
            "location.replace('DepositAddSumComplete.aspx?action=replenish" +
            (Request["portfolio"] != null ? ("&rnk=" + RNK.Value) : "") + "');"; 

          ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "DocInput", url, true);
    }

    /// <summary>
    /// Первинний внесок при відкритті вкладу
    /// </summary>
    protected void btFirstPayment_Click( object sender, EventArgs e )
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Request["dpt_id"]), false);
        if (textContractAddSum.ValueDecimal >= textMinAddSum.ValueDecimal)
        {
            // Друк анкети для фін.моніторингу
            if (eadFinmonQuestionnaire.Visible && Tools.PrintQuestionnaire(Convert.ToInt32(dpt.Currency), textContractAddSum.ValueDecimal * 100))
            {
                DBLogger.Info("Сума поповнення депозиту #" + dpt_id.Value + " підпадає під контроль фінмоніторингу.", "deposit");

                btnAdd.Enabled = false;
                textContractAddSum.Enabled = false;

                ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "Mesage",
                    "alert('Сума поповнення депозиту підпадає під контроль фінмоніторингу! " +
                    "Поповнення можливе лише після друку опитувального листа!');", true);
            }
            else
            {
                //replenish();
                FirstPayment();
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "Error", "alert('Сума поповнення менша від мінімально допустимої!');", true);

            textContractAddSum.Focus();
        }
    }


    /// <summary>
    /// 
    /// </summary>
    protected void eadFinmonQuestionnaire_BeforePrint(object sender, EventArgs e)
    {
        // Опитувальний лист фінмоніторингу
        eadFinmonQuestionnaire.TemplateID = "DPT_FINMON_QUESTIONNAIRE";
        eadFinmonQuestionnaire.RNK = Convert.ToInt64(RNK.Value);
        eadFinmonQuestionnaire.AgrID = Convert.ToInt64(dpt_id.Value);
    }

    /// <summary>
    /// 
    /// </summary>
    protected void eadFinmonQuestionnaire_DocSigned(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач встановив відмітку про отримання від клієнта підписаного опитувального листа фінмоніторингу (депозит #" + 
            dpt_id.Value + ").", "deposit");
        Deposit dpt = new Deposit(Convert.ToDecimal(Request["dpt_id"]), false);
        if (!IS_FIRST_PAYMENT_DONE(dpt))
            FirstPayment();
        else
            replenish();
    }

    /// <summary>
    /// Формування сум (в унціях та грамах) поповнення депозиту на основі інфр. про злитки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvAddSum_DataBound(object sender, EventArgs e)
    {
        textContractAddSum.Value = Bars.Metals.DepositMetals.SumOunce();
        ContractAddSumGrams.Value = Convert.ToString(Bars.Metals.DepositMetals.Sum());
    }

    //*************************
    //*** Робота з FormView ***
    //*************************

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvAddSum_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvAddSum.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvAddSum_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvAddSum.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvAddSum_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvAddSum.DataBind();
    }
}
