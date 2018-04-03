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
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositEditAccount;
        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement");

        /// Перевірка що в контролі дійсно число
        textBankMFO.Attributes["onblur"] = "javascript:doValueCheck(\"textBankMFO\");";
        textIntRcpOKPO.Attributes["onblur"] = "javascript:doValueCheck(\"textIntRcpOKPO\");";
        textRestRcpMFO.Attributes["onblur"] = "javascript:doValueCheck(\"textRestRcpMFO\");";
        textRestRcpOKPO.Attributes["onblur"] = "javascript:doValueCheck(\"textRestRcpOKPO\");";

        if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
        {
            if (Request["agr_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement");
            if (Request["template"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement");

            /// Якщо рахунок не з нашого МФО
            /// пропонуємо реквізити клієнта
            textBankMFO.Attributes["onblur"] += "javascript:getNMKp();";
            textRestRcpMFO.Attributes["onblur"] += "javascript:getNMKv();";

            Int32 agr_id = Convert.ToInt32(Convert.ToString(Request["agr_id"]));

            switch (agr_id)
            {
                /// Перерахування на поточний рахунок
                case 10:
                    {
                        lbInfo.Text = Resources.Deposit.GlobalResources.tb95;
                        btPercent.Visible = false;
                        btDeposit.Visible = false;
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
                        /// Вводити літери у рахунку можна
                        /// Перевірки контрольного розряду НЕМАЄ
                        RegisterClientScript(0);
                        //btPercent.Visible = false;
                        //btDeposit.Visible = false;
                        break;
                    }
                default:
                    {

                        //Response.Write(@"<script>alert('Выбранный вид доп. соглашений не поддерживается!');
                        Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al23 + @"');
                    location.replace('..//barsweb/Welcome.aspx');</script>");
                        Response.Flush();
                        break;
                    }
            }
        }
        /// УПБ
        else
        {
            btPercent.Visible = false;
            btDeposit.Visible = false;
            RegisterClientScript(1);
            textBankAccount.Attributes["onblur"] = "javascript:doValueCheck(\"textBankAccount\");";
            textAccountNumber.Attributes["onblur"] = "javascript:doValueCheck(\"textAccountNumber\");";
            textBankAccount.Attributes["onblur"] += "javascript:chkAccount(\"textBankAccount\",\"textBankMFO\",1)";
            textAccountNumber.Attributes["onblur"] += "javascript:chkAccount(\"textAccountNumber\",\"textRestRcpMFO\",1)";
        }

        btPay.Attributes["onclick"] = "javascript:if (Validate(0))";

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
        ;

    }
    #endregion
    /// <summary>
    /// Инициализация контролов
    /// </summary>
    protected void InitControls()
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));

        cur_id.Value = dpt.Currency.ToString();
        rnk.Value = dpt.Client.ID.ToString();
        NMK.Value = dpt.Client.Name;
        OKPO.Value = dpt.Client.Code;
        textClientName.Text = dpt.Client.Name;
        textContractType.Text = dpt.TypeName;

        OracleConnection connect = new OracleConnection();

        // Заполняем свое МФО
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

            OracleCommand cmdGetMFO = connect.CreateCommand();
            cmdGetMFO.CommandText = "select d.kf from accounts s, dpt_deposit d where d.deposit_id = :dpt_id and s.acc=d.acc";
            cmdGetMFO.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);

            MFO.Value = Convert.ToString(cmdGetMFO.ExecuteScalar());
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

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
        }

        FillControlsFromClass(dpt);
    }
    /// <summary>
    /// Загрузка информации из класса депозит в контролы формы
    /// </summary>
    /// <param name="dpt">депозит</param>
    protected void FillControlsFromClass(Deposit dpt)
    {
        // Счета выплаты процентов
        textIntRcpName.Text = dpt.IntReceiverName;
        textIntRcpOKPO.Text = dpt.IntReceiverOKPO;
        textBankAccount.Text = dpt.IntReceiverAccount;
        textBankMFO.Text = dpt.IntReceiverMFO;
        // Счета выплаты депозита
        textRestRcpName.Text = dpt.RestReceiverName;
        textRestRcpOKPO.Text = dpt.RestReceiverOKPO;
        textAccountNumber.Text = dpt.RestReceiverAccount;
        textRestRcpMFO.Text = dpt.RestReceiverMFO;
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
        // Счета выплаты депозита		
        dpt.RestReceiverName = textRestRcpName.Text;
        dpt.RestReceiverOKPO = textRestRcpOKPO.Text;
        dpt.RestReceiverAccount = textAccountNumber.Text;
        dpt.RestReceiverMFO = textRestRcpMFO.Text;
    }
    /// <summary>
    /// Нажатие на кнопку "Сохранить"
    /// </summary>
    private void btPay_ServerClick(object sender, System.EventArgs e)
    {
        Deposit dpt = new Deposit(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));

        DBLogger.Info("Пользователь сохранил изменения счетов на странице редактирования счетов. Депозитный договор №" + dpt.ID.ToString(),
            "deposit");

        String template_id = String.Empty;
        Decimal agr_id = Decimal.MinValue;

        if (BankType.GetCurrentBank() != BANKTYPE.UPB)
        {
            template_id = Convert.ToString(Request["template"]);
            agr_id = Convert.ToDecimal(Request["agr_id"]);
        }

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

            OracleCommand cmdGetMFO = connect.CreateCommand();
            cmdGetMFO.CommandText = "select mfo from banks where mfo=:mfo";
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

        // Якщо рахунки виплати не змінилися
        // далі не йдемо!
        if (
            textAccountNumber.Text == dpt.RestReceiverAccount &&
            textRestRcpMFO.Text == dpt.RestReceiverMFO &&
            textRestRcpOKPO.Text == dpt.RestReceiverOKPO &&
            textRestRcpName.Text == dpt.RestReceiverName &&
            textBankAccount.Text == dpt.IntReceiverAccount &&
            textBankMFO.Text == dpt.IntReceiverMFO &&
            textIntRcpOKPO.Text == dpt.IntReceiverOKPO &&
            textIntRcpName.Text == dpt.IntReceiverName
           )
        {
            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al03 + "');</script>");
            Response.Flush();

            return;
        }

        //Сохраняем данные в классе		
        this.FillClassFromControls(dpt);

        DBLogger.Info("Пользователь нажал кнопку \"Сохранить\" (новые счета выплаты) на страницу редактирование счетов выплаты депозитного договора.  Номер договора " + Convert.ToString(Request["dpt_id"]),
                "deposit");

        /// dpt.UpdateContractAccounts(Context);

        String add_tr = "&rnk_tr=" + (Request["rnk_tr"] == null ? Convert.ToString(dpt.Client.ID)
            : Convert.ToString(Request["rnk_tr"]));
        String accounts = "&p_nls=" + dpt.IntReceiverAccount +
            "&p_mfo=" + dpt.IntReceiverMFO +
            "&p_okpo=" + dpt.IntReceiverOKPO +
            "&p_nmk=" + dpt.IntReceiverName +
            "&d_nls=" + dpt.RestReceiverAccount +
            "&d_mfo=" + dpt.RestReceiverMFO +
            "&d_okpo=" + dpt.RestReceiverOKPO +
            "&d_nmk=" + dpt.RestReceiverName;

        // Переходим на страницу с результатами
        if (BankType.GetCurrentBank() == BANKTYPE.UPB)
            Response.Redirect("DepositEditComplete.aspx?dpt_id=" + dpt.ID.ToString());
        else
            Response.Redirect("DepositAgreementPrint.aspx?dpt_id=" + dpt.ID.ToString() +
            "&agr_id=" + Request["agr_id"].ToString() +
            "&template=" + template_id + add_tr + accounts);
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
