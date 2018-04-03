﻿using System;
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
using Bars.Classes;

/// <summary>
/// Депозитний модуль: Рахунки виплати
/// </summary>
public partial class DepositAccount : Bars.BarsPage
{
    /// <summary>
    /// Загрузка страницы
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositAccount;
        textBankMFO.Attributes["onblur"] = "javascript:doValueCheck(\"textBankMFO\");";
        textIntRcpOKPO.Attributes["onblur"] = "javascript:doValueCheck(\"textIntRcpOKPO\");";
        textRestRcpMFO.Attributes["onblur"] = "javascript:doValueCheck(\"textRestRcpMFO\");";
        textRestRcpOKPO.Attributes["onblur"] = "javascript:doValueCheck(\"textRestRcpOKPO\");";

        /// Реєструємо скріпт, який перевіряє
        /// коректність заповнення контролів
        RegisterEventScript();

        if (BankType.GetCurrentBank() != BANKTYPE.PRVX)
        {
            textBankAccount.Attributes["onblur"] = "javascript:doValueCheck(\"textBankAccount\");";
            textAccountNumber.Attributes["onblur"] = "javascript:doValueCheck(\"textAccountNumber\");";
            textBankAccount.Attributes["onblur"] += "javascript:chkAccount(\"textBankAccount\",\"textBankMFO\",1);";
            textAccountNumber.Attributes["onblur"] += "javascript:chkAccount(\"textAccountNumber\",\"textRestRcpMFO\",1);";
        }
        else
        {
            textBankMFO.Attributes["onblur"] += "javascript:getNMKp();";
            textRestRcpMFO.Attributes["onblur"] += "javascript:getNMKv();";
        }

        if ((Deposit)Session["DepositInfo"] == null)
        {
            DBLogger.Info("Пользователь зашёл на страницу задания счетов при заведении депозитного договора без данных о депозите и был перенаправлен на страницу карточки клиента",
                "deposit");

            Response.Redirect("DepositClient.aspx");
        }

        if (!IsPostBack)
        {
            InitControls();

            if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
                btNext_ServerClick(sender, e);

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
        this.btnBack.ServerClick += new System.EventHandler(this.btnBack_ServerClick);
        this.btNext.ServerClick += new System.EventHandler(this.btNext_ServerClick);
        ;

    }
    #endregion
    /// <summary>
    /// Инициализация контролов при загрузке
    /// </summary>
    protected void InitControls()
    {
        if ((Deposit)this.Session["DepositInfo"] == null)
        {
            Response.Redirect("DepositClient.aspx");
            return;
        }

        Deposit dpt = (Deposit)this.Session["DepositInfo"];

        // Проверяем заполнен ли тип договора
        if (dpt.Type == decimal.MinValue)
        {
            Response.Redirect("DepositClient.aspx");
            return;
        }

        // Заполняем ФИО клиента и тип договора
        textClientName.Text = dpt.Client.Name;
        textContractType.Text = dpt.TypeName;

        // В зависимости от признака капитализации процентов
        // показываем/не показываем счета выплаты процентов
        if (dpt.IntCap == true)
        {
            btNext.Attributes["onclick"] = "if (ckDptField() && Validate(1) && chkAccount('textAccountNumber','textRestRcpMFO',1))";

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
            btNext.Attributes["onclick"] = "if (ckDptField() && Validate(0) && chkAccount('textBankAccount','textBankMFO',1) && chkAccount('textAccountNumber','textRestRcpMFO',1))";

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

        FillControlsFromClass();

        GetDptFields();
    }

    /// <summary>
    /// Заполнение контролов из класса депозита
    /// </summary>
    protected void FillControlsFromClass()
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];
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
    /// Заполнение класса депозита из контролов
    /// </summary>
    protected void FillClassFromControls()
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];

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
        // Відкриття технічного рахунку
        //
        String[] dpt_fields = dpt_controls.Value.Split(',');
        foreach (String name in dpt_fields)
        {
            for (int i = 0; i < dpt.DptField.Count; i++)
            {
                DepositField dpf = (DepositField)dpt.DptField[i];
                if (dpf.Tag != name)
                    continue;
                dpf.Val = Request.Form[name].ToString();
                break;
            }
        }
    }
    /// <summary>
    /// Нажатие кнопки "Сформировать договор"
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btNext_ServerClick(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь подтвердил информацию о депозитном договоре и нажал кнопку \"Формировать договор\"",
            "deposit");

        OracleConnection connect = new OracleConnection();

        try
        {
            string Value = string.Empty;
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
                Value = Resources.Deposit.GlobalResources.al07;

                Response.Write("<script>alert('" + Value + "');</script>");
                Response.Flush();
                return;
            }

            cmdGetMFO.Parameters.Clear();
            cmdGetMFO.Parameters.Add("mfo", OracleDbType.Varchar2, textRestRcpMFO.Text, ParameterDirection.Input);

            result = Convert.ToString(cmdGetMFO.ExecuteScalar());
            if (result != textRestRcpMFO.Text)
            {
                Value = Resources.Deposit.GlobalResources.al08;

                Response.Write("<script>alert('" + Value + "');</script>");
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

        // Заполняем класс
        FillClassFromControls();

        // Вызываем процесс создания договора
        Deposit dpt = (Deposit)Session["DepositInfo"];
        
        if (Convert.ToString(Request["action"]) == "rollback")
            dpt.RollbackDeposit();
        else
            dpt.WriteToDatabase();
        
        dpt.ReadFromDatabase();

        Session["DPT_ID"] = dpt.ID;
        Session["DPT_NUM"] = dpt.Number;

        Session["DepositInfo"] = dpt;

        String dest = "depositbonus.aspx";
        String script = "<script>";

        if (dpt.GetTechAcc)
        {
            DBLogger.Info("Вызвана операция взятия коммиссии за открытие технического счета.  Депозит № "
                + ((Deposit)Session["DepositInfo"]).ID.ToString()
                , "deposit");

            Random r = new Random();
            String dop_rec = "&RNK=" + Convert.ToString(Convert.ToString(dpt.Client.ID)) +
                "&Code=" + Convert.ToString(r.Next());

            String BeforePayProc = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") + 
                "@" + "begin dpt_web.fill_dpt_payments(" + dpt.ID + ",:REF);end;";

            String url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + dpt.GetTechTT(DPT_OP.OP_195,TECH_TYPE.TT_COMISS) + 
                "&nd=" + dpt.ID + "&SumC_t=1" + dop_rec + "&APROC=" + BeforePayProc + "\"";

            script += "window.showModalDialog(encodeURI(" + url + "),null," +
                "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";
        }

        script += "location.replace('" + dest + "')</script>";
        Response.Write(script);
        Response.Flush();
    }

    /// <summary>
    /// Нажатие кнопки назад
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btnBack_ServerClick(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь нажал кнопку \"назад\" на странице задания счетов при заведении депозитного договора. Номер договора "
            + ((Deposit)Session["DepositInfo"]).ID.ToString(),
            "deposit");

        Response.Redirect("DepositContract.aspx");
    }
    /// <summary>
    /// 
    /// </summary>
    private void RegisterEventScript()
    {
        String script = String.Empty;
        Deposit dpt = (Deposit)this.Session["DepositInfo"];

        if (dpt.IntCap)
        {
            if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
            {
                script = @"<script language='javascript'>
				document.getElementById('textAccountNumber').attachEvent('onkeydown',doNumAlpha);
				document.getElementById('textRestRcpMFO').attachEvent('onkeydown',doNum);
				document.getElementById('textRestRcpOKPO').attachEvent('onkeydown',doNum);
				</script>";
            }
            else
            {
                script = @"<script language='javascript'>
				document.getElementById('textAccountNumber').attachEvent('onkeydown',doNum);
				document.getElementById('textRestRcpMFO').attachEvent('onkeydown',doNum);
				document.getElementById('textRestRcpOKPO').attachEvent('onkeydown',doNum);
				</script>";
            }
        }
        else
        {
            if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
            {
                script = @"<script language='javascript'>
				document.getElementById('textBankAccount').attachEvent('onkeydown',doNumAlpha);			
				document.getElementById('textBankMFO').attachEvent('onkeydown',doNum);
				document.getElementById('textIntRcpOKPO').attachEvent('onkeydown',doNum);
				document.getElementById('textAccountNumber').attachEvent('onkeydown',doNumAlpha);
				document.getElementById('textRestRcpMFO').attachEvent('onkeydown',doNum);
				document.getElementById('textRestRcpOKPO').attachEvent('onkeydown',doNum);
				</script>";
            }
            else
            {
                script = @"<script language='javascript'>
				document.getElementById('textBankAccount').attachEvent('onkeydown',doNum);			
				document.getElementById('textBankMFO').attachEvent('onkeydown',doNum);
				document.getElementById('textIntRcpOKPO').attachEvent('onkeydown',doNum);
				document.getElementById('textAccountNumber').attachEvent('onkeydown',doNum);
				document.getElementById('textRestRcpMFO').attachEvent('onkeydown',doNum);
				document.getElementById('textRestRcpOKPO').attachEvent('onkeydown',doNum);
				</script>";
            }
        }
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_CK", script);
    }
    /// <summary>
    /// 
    /// </summary>
    private void GetDptFields()
    {
        dpt_controls.Value = String.Empty;
        mand_field.Value = String.Empty;

        if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
        {
            tbDptField.Visible = false;
        }
        else if (BankType.GetCurrentBank() == BANKTYPE.UPB)
        {
            OracleConnection connect = new OracleConnection();
            Deposit dpt = (Deposit)this.Session["DepositInfo"];
            dpt.ReadDptField();

            if (dpt.DptField.Count < 1)
            {
                tbDptField.Visible = false;
                return;
            }
            else
            {
                HtmlTableRow row;

                for (int i = 0; i < dpt.DptField.Count; i++)
                {
                    DepositField dpf = (DepositField)dpt.DptField[i];

                    row = new HtmlTableRow();
                    row.Cells.Add(new HtmlTableCell());
                    row.Cells.Add(new HtmlTableCell());
                    row.Cells.Add(new HtmlTableCell());

                    tbDptField.Rows.Add(row);

                    String control_name = dpf.Tag;
                    int ws_pos = control_name.IndexOf(" ");
                    if (ws_pos > 0)
                        control_name = control_name.Substring(0, ws_pos);

                    dpt_controls.Value += control_name + ",";

                    tbDptField.Rows[i + 1].Cells[0].Style.Add("WIDTH", "20%");
                    tbDptField.Rows[i + 1].Cells[1].Style.Add("WIDTH", "25%");
                    tbDptField.Rows[i + 1].Cells[2].Style.Add("WIDTH", "55%");

                    tbDptField.Rows[i + 1].Cells[0].InnerText = dpf.Nmk;
                    tbDptField.Rows[i + 1].Cells[0].Style.Add("FONT-FAMILY", "Arial");
                    tbDptField.Rows[i + 1].Cells[0].Style.Add("FONT-SIZE", "10pt");

                    int tab_index = (10 + i);

                    tbDptField.Rows[i + 1].Cells[1].NoWrap = true;
                    tbDptField.Rows[i + 1].Cells[1].InnerHtml = "<input name=\"" + control_name
                        + "\" type=\"text\" runat=\"server\" TabIndex=\"" + tab_index + "\" value=\"" + dpf.Val + "\"";
                    tbDptField.Rows[i + 1].Cells[1].InnerHtml += "class=\"InfoText\"";
                    tbDptField.Rows[i + 1].Cells[1].InnerHtml += " />";

                    if (dpf.Req == "1")
                    {
                        tbDptField.Rows[i + 1].Cells[0].Style.Add("color", "red");
                        mand_field.Value += control_name + ",";
                    }
                }
                if (mand_field.Value.Length > 0)
                    mand_field.Value = mand_field.Value.Remove(mand_field.Value.Length - 1, 1);
            }
        }
    }
}
