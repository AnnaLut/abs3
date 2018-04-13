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
/// Summary description for DepositEditAccount.
/// </summary>
public partial class DepositEditAccount : Bars.BarsPage
{
    /// <summary>
    /// Загрузка страницы
    /// </summary>
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement");
        
        if (Request["agr_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement");

        if (Request["template"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement");

        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositEditAccount;

        /// Перевірка що в контролі дійсно число
        textBankMFO.Attributes["onblur"] = "javascript:doValueCheck(\"textBankMFO\");";
        textIntRcpOKPO.Attributes["onblur"] = "javascript:doValueCheck(\"textIntRcpOKPO\");";
        textRestRcpMFO.Attributes["onblur"] = "javascript:doValueCheck(\"textRestRcpMFO\");";
        textRestRcpOKPO.Attributes["onblur"] = "javascript:doValueCheck(\"textRestRcpOKPO\");";

        if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
        {
            /// Якщо рахунок не з нашого МФО пропонуємо реквізити клієнта
            textBankMFO.Attributes["onblur"] += "javascript:getNMKp();";
            textRestRcpMFO.Attributes["onblur"] += "javascript:getNMKv();";

            Int32 agr_id = Convert.ToInt32(Request.QueryString["agr_id"]);

            switch (agr_id)
            {
                /// Перерахування на поточний рахунок
                case 10:
                    {
                        lbInfo.Text = Resources.Deposit.GlobalResources.tb95;
                        btPercent.Visible = false;
                        btDeposit.Visible = false;
                        CardFieldsVisible("ALL", false);
                        /// Забороняємо вводити букви
                        /// Робимо перевірку контрольного розряду
                        textBankAccount.Attributes["onblur"] = "javascript:chkAccount(\"textBankAccount\",\"textBankMFO\",1,1)";
                        textAccountNumber.Attributes["onblur"] = "javascript:chkAccount(\"textAccountNumber\",\"textRestRcpMFO\",1,2)";
                        RegisterClientScript(1);
                        break;
                    }
                /// Перерахування на картковий рахунок
                case 11:
                    {
                        lbInfo.Text = Resources.Deposit.GlobalResources.tb96;

                        if (BankType.GetDptBankType() == BANKTYPE.UPB)
                        {
                            CardFieldsVisible("ALL", true);
                        }
                        else
                        {
                            CardFieldsVisible("ALL", false);
                        }

                        /// Вводити літери у рахунку можна
                        /// Перевірки контрольного розряду НЕМАЄ
                        RegisterClientScript(0);
                        break;
                    }
                default:
                    {

                        //Response.Write(@"<script>alert('Выбранный вид доп. соглашений не поддерживается!');
                        Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al23 + @"'); location.replace('..//barsweb/Welcome.aspx');</script>");
                        Response.Flush();
                        break;
                    }
            }
        }
        /// УПБ
        //else
        //{
        //    btPercent.Visible = false;
        //    btDeposit.Visible = false;
        //    RegisterClientScript(1);
        //    textBankAccount.Attributes["onblur"] = "javascript:doValueCheck(\"textBankAccount\");";
        //    textAccountNumber.Attributes["onblur"] = "javascript:doValueCheck(\"textAccountNumber\");";
        //    textBankAccount.Attributes["onblur"] += "javascript:chkAccount(\"textBankAccount\",\"textBankMFO\",1)";
        //    textAccountNumber.Attributes["onblur"] += "javascript:chkAccount(\"textAccountNumber\",\"textRestRcpMFO\",1)";
        //}


        // Перевірка заповнення рахунків для виплати депозиту та %%
        // btPay.Attributes["onclick"] = "javascript:if (Validate(0))";
        
        // Перевірка заповнення рахунку для виплати %%
        btPay.Attributes["onclick"] = "javascript:if (Validate(-1))";

        if (!IsPostBack)
        {
            InitControls();
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
        this.btPay.ServerClick += new System.EventHandler(this.btPay_ServerClick);
    }
    #endregion
    /// <summary>
    /// Инициализация контролов
    /// </summary>
    protected void InitControls()
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));

        Int32 agr_id = Convert.ToInt32(Convert.ToString(Request["agr_id"]));

        cur_id.Value = dpt.Currency.ToString();
        rnk.Value = dpt.Client.ID.ToString();
        NMK.Value = dpt.Client.Name;
        OKPO.Value = dpt.Client.Code;
        textClientName.Text = dpt.Client.Name;
        textContractType.Text = dpt.TypeName;

        MFO.Value = BankType.GetOurMfo();

        // Для УПБ вичитуєм їх збочення (номер картки та рахунку в ПЦ) з допреквізитів
        #region UPB

        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmdSQL = connect.CreateCommand();

        try
        {
            if ((BankType.GetDptBankType() == BANKTYPE.UPB) && (agr_id == 11) &&
                ((dpt.IntReceiverAccount != String.Empty) || (dpt.RestReceiverAccount != String.Empty)))
            {
                cmdSQL.Parameters.Clear();

                cmdSQL.CommandText = @"
                    select (select value from dpt_depositw where dpt_id = deposit_id and tag = 'CARDA'),
                           (select value from dpt_depositw where dpt_id = deposit_id and tag = 'CARDN') 
                      from dpt_deposit_all 
                     where deposit_id = :dpt_id ";

                cmdSQL.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);

                // Читаем результаты запроса
                OracleDataReader rdr = cmdSQL.ExecuteReader();

                if (rdr.Read())
                {
                    String CardA = String.Empty;
                    String CardN = String.Empty;

                    if (!rdr.IsDBNull(0))
                        CardA = rdr.GetOracleString(0).Value;
                    if (!rdr.IsDBNull(1))
                        CardN = rdr.GetOracleString(1).Value;

                    if (dpt.IntReceiverAccount != String.Empty)
                    {
                        // Номер рахунка в ПЦ для виплати відсотків
                        dpt.IntReceiverAccount = CardA;
                        // Номер картки для витлати відсотків
                        dpt.IntReceiverCARDN = CardN;
                    }

                    if (dpt.RestReceiverAccount != String.Empty)
                    {
                        // Номер рахунка в ПЦ для повернення депозиту
                        dpt.RestReceiverAccount = CardA;
                        // Номер картки для повернення депозиту
                        dpt.RestReceiverCARDN = CardN;
                    }
                }
            }

            cmdSQL.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }
        #endregion

        // В зависимости от признака капитализации процентов
        // показываем/не показываем счета выплаты процентов
        if (dpt.IntCap == true)
        {
            lbPercentInfo.Visible = false;
            lbBankAccount.Visible = false;
            textBankAccount.Visible = false;
            lbBankMFO.Visible = false;
            textBankMFO.Visible = false;
            lbIntRcpName.Visible = false;
            textIntRcpName.Visible = false;
            lbIntRcpOKPO.Visible = false;
            textIntRcpOKPO.Visible = false;
            
            CardFieldsVisible("INT", false);
        }
        else
        {
            lbPercentInfo.Visible = true;
            lbBankAccount.Visible = true;
            textBankAccount.Visible = true;
            lbBankMFO.Visible = true;
            textBankMFO.Visible = true;
            lbIntRcpName.Visible = true;
            textIntRcpName.Visible = true;
            lbIntRcpOKPO.Visible = true;
            textIntRcpOKPO.Visible = true;
            
            if ((BankType.GetDptBankType() == BANKTYPE.UPB) && (agr_id == 11))
            {
                CardFieldsVisible("INT", true);
            }
        }

        FillControlsFromClass(dpt);

        // Автопідстановка реквіз.депоз.рах. для договірної капіталізації (Ощадбанк)
        if ((BankType.GetDptBankType() == BANKTYPE.SBER) && (agr_id == 10))
        {
            // Додаткова угода про капіталізацію нарахованих відсотків 
            lbInfo.Text = "Додаткова угода про капіталізацію нарахованих відсотків";

            textBankAccount.ForeColor = System.Drawing.Color.Red;
            textIntRcpName.ForeColor = System.Drawing.Color.Red;
            textBankMFO.ForeColor = System.Drawing.Color.Red;
            textIntRcpOKPO.ForeColor = System.Drawing.Color.Red;

            // якщо рах. виплати %% 
            if (dpt.IntReceiverAccount != dpt.dpt_nls)
            {
                textBankAccount.Text = dpt.dpt_nls;
                textIntRcpName.Text = dpt.dpt_nls_nms;
                textBankMFO.Text = BankType.GetOurMfo();
                textIntRcpOKPO.Text = dpt.Client.Code;

                btPay_ServerClick(null, System.EventArgs.Empty);
            }
            else
            {
                btPay.Disabled = true;
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "error_mesage", "alert('ДУ про капіталізацію нарахованих відсотків вже заключена!');", true);
            }
        }
    }

    /// <summary>
    /// Управління видимістю полями вказання номера БПК
    /// </summary>
    /// <param name="p_mode">Депозит/відсотки/обидва варіанти (DPT/INT/ALL)</param>
    /// <param name="p_vsbl">Видимі/Невидимі (true/false))</param>
    private void CardFieldsVisible(String p_mode, Boolean p_vsbl)
    {
        //
        if ((p_mode == "DPT") || (p_mode == "ALL"))
        {
            lbDptCardNumber.Visible = p_vsbl;
            textDptCardNumber.Visible = p_vsbl;
        }
        //
        if ((p_mode == "INT") || (p_mode == "ALL"))
        {
            lbIntCardNumber.Visible = p_vsbl;
            textIntCardNumber.Visible = p_vsbl;
        }
    }

    /// <summary>
    /// Загрузка информации из класса депозит в контролы формы
    /// </summary>
    /// <param name="dpt">депозит</param>
    protected void FillControlsFromClass(Deposit dpt)
    {
        // Счета выплаты процентов
        textBankMFO.Text = dpt.IntReceiverMFO;
        textBankAccount.Text = dpt.IntReceiverAccount;
        textIntRcpName.Text = dpt.IntReceiverName;
        textIntRcpOKPO.Text = dpt.IntReceiverOKPO;        
        textIntCardNumber.Text = dpt.IntReceiverCARDN;

        //if (String.IsNullOrEmpty(textBankMFO.Text))
        //    textBankMFO.Text = MFO.Value;

        //if (String.IsNullOrEmpty(textIntRcpOKPO.Text))
        //    textIntRcpOKPO.Text = OKPO.Value;

        // Счета выплаты депозита
        textRestRcpMFO.Text = dpt.RestReceiverMFO;
        textAccountNumber.Text = dpt.RestReceiverAccount;
        textRestRcpName.Text = dpt.RestReceiverName;
        textRestRcpOKPO.Text = dpt.RestReceiverOKPO;
        textDptCardNumber.Text = dpt.RestReceiverCARDN;

        //if (String.IsNullOrEmpty(textRestRcpMFO.Text))
        //    textRestRcpMFO.Text = MFO.Value;

        //if (String.IsNullOrEmpty(textRestRcpOKPO.Text))
        //    textRestRcpOKPO.Text = OKPO.Value;
    }
    /// <summary>
    /// Сохранение информации из контролов в классе депозит
    /// </summary>
    /// <param name="dpt"></param>
    protected void FillClassFromControls(Deposit dpt)
    {
        // Счета выплаты процентов
        dpt.IntReceiverName = textIntRcpName.Text;
        dpt.IntReceiverOKPO = textIntRcpOKPO.Text;
        dpt.IntReceiverAccount = textBankAccount.Text;
        dpt.IntReceiverMFO = textBankMFO.Text;
        dpt.IntReceiverCARDN = textIntCardNumber.Text;

        // Счета выплаты депозита		
        dpt.RestReceiverName = textRestRcpName.Text;
        dpt.RestReceiverOKPO = textRestRcpOKPO.Text;
        dpt.RestReceiverAccount = textAccountNumber.Text;
        dpt.RestReceiverMFO = textRestRcpMFO.Text;
        dpt.RestReceiverCARDN = textDptCardNumber.Text;
    }
    /// <summary>
    /// Нажатие на кнопку "Сохранить"
    /// </summary>
    private void btPay_ServerClick(object sender, System.EventArgs e)
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Request.QueryString["dpt_id"]));

        DBLogger.Info("Пользователь сохранил изменения счетов на странице редактирования счетов. Депозитный договор №" + dpt.ID.ToString(),
            "deposit");

        OracleConnection connect = new OracleConnection();

        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            // Открываем соединение с БД
            

            // Установка роли
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            // Перевірка МФО
            OracleCommand cmdGetMFO = connect.CreateCommand();
            cmdGetMFO.CommandText = "select mfo from banks where mfo=:mfo and blk=0";
            cmdGetMFO.Parameters.Add("mfo", OracleDbType.Varchar2, textBankMFO.Text, ParameterDirection.Input);

            String result = Convert.ToString(cmdGetMFO.ExecuteScalar());

            if (result != textBankMFO.Text)
            {
                Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al01 + "');</script>");
                Response.Flush();
                return;
            }

            cmdGetMFO.Parameters.Clear();
            cmdGetMFO.Parameters.Add("mfo", OracleDbType.Varchar2, textRestRcpMFO.Text, ParameterDirection.Input);

            result = Convert.ToString(cmdGetMFO.ExecuteScalar());
            if (result != textRestRcpMFO.Text)
            {
                Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al02 + "');</script>");
                Response.Flush();
                return;
            }
            cmdGetMFO.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        // Якщо рахунки виплати не змінилися далі не йдемо!
        if (
            textAccountNumber.Text == dpt.RestReceiverAccount &&
            textRestRcpMFO.Text == dpt.RestReceiverMFO &&
            textRestRcpOKPO.Text == dpt.RestReceiverOKPO &&
            textRestRcpName.Text == dpt.RestReceiverName &&
            textDptCardNumber.Text == dpt.RestReceiverCARDN &&
            textBankAccount.Text == dpt.IntReceiverAccount &&
            textBankMFO.Text == dpt.IntReceiverMFO &&
            textIntRcpOKPO.Text == dpt.IntReceiverOKPO &&
            textIntRcpName.Text == dpt.IntReceiverName &&
            textIntCardNumber.Text == dpt.IntReceiverCARDN
           )
        {
            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al03 + "');</script>");
            Response.Flush();

            return;
        }

        //Сохраняем данные в классе		
        this.FillClassFromControls(dpt);

        DBLogger.Info("Пользователь нажал кнопку \"Сохранить\" (новые счета выплаты) на страницу редактирование счетов выплаты депозитного договора № " + Convert.ToString(Request["dpt_id"]),
                "deposit");

        /// dpt.UpdateContractAccounts(Context);

        String add_tr = "&rnk_tr=" + (Request["rnk_tr"] == null ? Convert.ToString(dpt.Client.ID) : Request.QueryString["rnk_tr"]);

        String accounts = "&p_nls=" + dpt.IntReceiverAccount +
            "&p_mfo=" + dpt.IntReceiverMFO +
            "&p_okpo=" + dpt.IntReceiverOKPO +
            "&p_nmk=" + dpt.IntReceiverName +
            ((textIntCardNumber.Visible == true) ? "&p_cardn=" + dpt.IntReceiverCARDN : "") +
            "&d_nls=" + dpt.RestReceiverAccount +
            "&d_mfo=" + dpt.RestReceiverMFO +
            "&d_okpo=" + dpt.RestReceiverOKPO +
            "&d_nmk=" + dpt.RestReceiverName +
            ((textDptCardNumber.Visible == true) ? "&d_cardn=" + dpt.RestReceiverCARDN : "");

        Response.Redirect("DepositAgreementPrint.aspx?dpt_id=" + dpt.ID.ToString() +
            "&agr_id=" + Request.QueryString["agr_id"] +
            "&template=" + Request.QueryString["template"] + add_tr + accounts);
    }

    /// <summary>
    /// Назад (до картки договору)
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnBack_Click(object sender, EventArgs e)
    {
        String url = "DepositContractInfo.aspx?dpt_id=" + Request.QueryString["dpt_id"];

        if (Request["rnk_tr"] != null)
            url += "&rnk_tr=" + Request.QueryString["rnk_tr"];

        Response.Redirect(url);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="mCase"></param>
    private void RegisterClientScript(int mCase)
    {
        string script = "<SCRIPT language='javascript'> ";
        /// В номері рахунку можуть бути літери
        if (mCase == 0)
        {
            script += "document.getElementById('textBankAccount').attachEvent('onkeydown',doNumAlpha);" +
                "document.getElementById('textBankMFO').attachEvent('onkeydown',doNum);" +
                "document.getElementById('textIntRcpOKPO').attachEvent('onkeydown',doNum);";

            script += "document.getElementById('textAccountNumber').attachEvent('onkeydown',doNumAlpha);" +
                "document.getElementById('textRestRcpMFO').attachEvent('onkeydown',doNum);" +
                "document.getElementById('textRestRcpOKPO').attachEvent('onkeydown',doNum);";
        }
        /// Всюди тільки цифри
        else if (mCase == 1)
        {
            script += "document.getElementById('textBankAccount').attachEvent('onkeydown',doNum);" +
                "document.getElementById('textBankMFO').attachEvent('onkeydown',doNum);" +
                "document.getElementById('textIntRcpOKPO').attachEvent('onkeydown',doNum);" +
                "document.getElementById('textAccountNumber').attachEvent('onkeydown',doNum);" +
                "document.getElementById('textRestRcpMFO').attachEvent('onkeydown',doNum);" +
                "document.getElementById('textRestRcpOKPO').attachEvent('onkeydown',doNum);";
        }
        script += "</SCRIPT>";

        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script", script);
    }
}
