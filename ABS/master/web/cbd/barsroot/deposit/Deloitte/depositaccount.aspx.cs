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
        if ((Deposit)Session["NewDeposit"] == null)
        {
            DBLogger.Info("Пользователь зашёл на страницу задания счетов при заведении депозитного договора без данных о депозите и был перенаправлен на страницу карточки клиента",
                "deposit");

            Response.Redirect("/barsroot/clientproducts/DepositClient.aspx");
        }
        else
        {
            Deposit dpt = (Deposit)Session["NewDeposit"];


            // для рах. "до запитання" зразу йдем далі
            if ((dpt.dpt_duration_months == 0) && (dpt.dpt_duration_days == 0))
                btNext_ServerClick(sender, e);

            // якщо ЕБП + в клієнта більше одного рах.2625 у валюті вкладу
            if (Request.QueryString["scheme"] == "DELOITTE")
            {
                //якщо депозит не в валюті карток(грн/usd/eur) то поля виплати не обов'язкові.
                if ( dpt.Currency != 980 && dpt.Currency != 840 && dpt.Currency != 978)
                    btNext.ValidationGroup = "";
                //якщо депозит відкривають за довіренністю - треба відсканувати довіреність
                if ((Session["OnTrustee"] != null) && (Convert.ToString(Session["OnTrustee"]) == "YES"))
                {
                    scWarrant.Visible = true;
                }

                if (dpt.SetDefaultReceiver() == 1)
                    // Якщо рахунки виплати по договору заповненні автоматично 
                    btNext_ServerClick(sender, e);
                else
                {
                    // Якщо вклад на бенефіціара
                    if ((Session["OnBeneficiary"] != null) && (Convert.ToString(Session["OnBeneficiary"]) == "YES"))
                        btNext.Value = "Вибір бенефіціара";
                    //якщо вклад на ім'я малолітної особи
                    if ((Session["OnChildren"] != null) && (Convert.ToString(Session["OnChildren"]) == "YES"))
                        btNext.Value = "Вибір малолітньої особи та розпорядника";
                }
            }

            Page.Header.Title = Resources.Deposit.GlobalResources.hDepositAccount;

            textBankMFO.Attributes["onblur"] = "javascript:doValueCheck(\"textBankMFO\");";
            textIntRcpOKPO.Attributes["onblur"] = "javascript:doValueCheck(\"textIntRcpOKPO\");";
            textRestRcpMFO.Attributes["onblur"] = "javascript:doValueCheck(\"textRestRcpMFO\");";
            textRestRcpOKPO.Attributes["onblur"] = "javascript:doValueCheck(\"textRestRcpOKPO\");";
        
            /// Реєструємо скріпт, який перевіряє коректність заповнення контролів
            RegisterEventScript(dpt);

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

            if (!IsPostBack)
            {
                FillControlsFromClass(dpt);

                GetDptFields();
            }
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
    }
    #endregion
    /// <summary>
    /// Заполнение контролов из класса депозита
    /// </summary>
    protected void FillControlsFromClass(Deposit dpt)
    {
        // Проверяем заполнен ли тип договора
        if (dpt.Type == decimal.MinValue)
        {
            Response.Redirect("/barsroot/clientproducts/DepositClient.aspx");
            return;
        }

        MFO.Value = BankType.GetOurMfo();
        RNK.Value = Convert.ToString(dpt.Client.ID);

        if ((Session["OnOwner"] != null) && (Convert.ToString(Session["OnOwner"]) == "YES") && (Request["rnk"] != null) && (Request["rnk_tr"] != null))
            {
                RNK.Value = Request["rnk"];//якщо депозит на ім'я, то робимо підміну власника депозиту, а на особу, що заводить робимо довіреність. 
                
                Client cl = new Client(Convert.ToDecimal(RNK.Value));
                dpt.Client = cl;
                dpt.Client.Code = cl.Code;
                dpt.Client.Name = cl.Name;
            }
        
        NMK.Value = dpt.Client.Name;
        OKPO.Value = dpt.Client.Code;
        KV.Value = dpt.Currency.ToString();

        // Заполняем ФИО клиента и тип договора
        textClientName.Text = dpt.Client.Name;
        textContractType.Text = dpt.TypeName;

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
    }

    /// <summary>
    /// Заполнение класса депозита из контролов
    /// </summary>
    protected void FillClassFromControls()
    {
        Deposit dpt = (Deposit)Session["NewDeposit"];

        // Счета выплаты процентов
        if (!String.IsNullOrEmpty(textBankAccount.Text))
        {
            dpt.IntReceiverMFO = textBankMFO.Text;
            dpt.IntReceiverAccount = textBankAccount.Text;
            dpt.IntReceiverName = textIntRcpName.Text;
            dpt.IntReceiverOKPO = textIntRcpOKPO.Text;
        }
        
        // Счета выплаты депозита
	    if (!String.IsNullOrEmpty(textAccountNumber.Text))
        {
            dpt.RestReceiverMFO = textRestRcpMFO.Text;
            dpt.RestReceiverAccount = textAccountNumber.Text;
            dpt.RestReceiverName = textRestRcpName.Text;
            dpt.RestReceiverOKPO = textRestRcpOKPO.Text;
        }
        
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
        // Відправка сканкопій до ЕАД
        Bars.EAD.EadPack ep = new Bars.EAD.EadPack(new ibank.core.BbConnection());

      
        
        if ((Session["OnTrustee"] != null) && (Convert.ToString(Session["OnTrustee"]) == "YES") && !scWarrant.HasValue )
        {
            Response.Write("<script>alert('" + "Спочатку необхідно відсканувати довіреність!" + "');</script>");
            Response.Flush();
            return;
        }
        
        try
        {
            string Value = string.Empty;

            // Создаем соединение
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

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
        Deposit dpt = (Deposit)Session["NewDeposit"];

        dpt.WriteToDatabase();

        dpt.ReadFromDatabaseExt(true, false, true);
      
        //для депозиту, оформленого по довіреності, створюємо довіреність на особу, що оформлювала депозит
        if ((Session["OnTrustee"] != null) && (Convert.ToString(Session["OnTrustee"]) == "YES"))
        {
          
            decimal dpt_agreement =
          DepositAgreement.Create(dpt.ID, 12, dpt.Client.ID, Convert.ToDecimal(Request["rnk_tr"]), null, null, null, dpt.BeginDate , dpt.EndDate , 1, null,11111111, dpt.Sum_cent );
            Decimal? WarrantID = ep.DOC_CREATE("SCAN", null, scWarrant.Value, 222, Convert.ToDecimal(Request["rnk_tr"]), dpt.ID);
         }

        //для депозиту, оформленого на ім'я, створюємо довіреність на особу, що оформлювала депозит
        if ((Session["OnOwner"] != null) && (Convert.ToString(Session["OnOwner"]) == "YES"))
        {

            decimal dpt_agreement =
          DepositAgreement.Create(dpt.ID, 12, dpt.Client.ID, Convert.ToDecimal(Request["rnk_tr"]), null, null, null, dpt.BeginDate, dpt.EndDate, 1, null, 11111111, dpt.Sum_cent);
          //  Decimal? WarrantID = ep.DOC_CREATE("SCAN", null, scWarrant.Value, 222, Convert.ToDecimal(Request["rnk_tr"]), dpt.ID);
        }
       

        // якщо депозит "Строковий пенсійний"
        if (Deposit.GetProductCode(dpt.Type) == 10)
        {
            //  якщо клієнт НЕ пенсійного віку (60 та 55 років
            if (((dpt.Client.Sex == 1) && (DateTime.Now.Date < dpt.Client.BirthDate.AddYears(60))) ||
                ((dpt.Client.Sex == 2) && (DateTime.Now.Date < dpt.Client.BirthDate.AddYears(55))))
            {
                // створюємо запис про псевдо друк пенсійного посвідчення клієнта для ЕАД 
                //Bars.EAD.EadPack ep = new Bars.EAD.EadPack(new ibank.core.BbConnection());

                Decimal? PensionID = ep.DOC_CREATE("SCAN", null, new Byte[0], 143, dpt.Client.ID, dpt.ID);

                DBLogger.Info("Користувач відкрив депозит \"Строковий пенсійний\" клієнту (РНК=" + Convert.ToString(dpt.Client.ID) +
                    " не пенсійного віку.", "deposit");
            }
        }

        // Чистим змінну сесії після відкриття договору
       Session.Remove("NewDeposit");
       Session.Remove("OnTrustee");
       Session.Remove("OnOwner");

        //адреса переходу
        String dest;
        dest = "/barsroot/deposit/deloitte/DepositContractInfo.aspx?scheme=DELOITTE";
      
        // Якщо вклад на бенефіціара
        if ((Session["OnBeneficiary"] != null) && (Convert.ToString(Session["OnBeneficiary"]) == "YES"))
        {
            Session["DepositInfo"] = dpt;

            dest = "/barsroot/clientproducts/DepositClient.aspx?scheme=DELOITTE&dpt_id=" + Convert.ToString(dpt.ID) +
                "&agr_id=5&dest=print&template=" + "DPT_ADD_OB_3OS" + "&rnk_tr=" + Convert.ToString(dpt.Client.ID);
        }

        // Якщо вклад на ім'я мадлолітньої особи
        if ((Session["OnChildren"] != null) && (Convert.ToString(Session["OnChildren"]) == "YES"))
        {
            Session["DepositInfo"] = dpt;

            dest = "/barsroot/clientproducts/DepositClient.aspx?scheme=DELOITTE&dpt_id=" + Convert.ToString(dpt.ID) +
                "&agr_id=27&dest=print&template=" + "DPT_ADD_CHILD" + "&rnk_tr=" + Convert.ToString(dpt.Client.ID);
        }

        String script = "<script>";

        # region tech
        //if (dpt.GetTechAcc)
        //{
        //    DBLogger.Info("Вызвана операция взятия коммиссии за открытие технического счета.  Депозит № "
        //        + ((Deposit)Session["NewDeposit"]).ID.ToString(), "deposit");

        //    Random r = new Random();
        //    String dop_rec = "&RNK=" + Convert.ToString(dpt.Client.ID) +
        //        "&Code=" + Convert.ToString(r.Next());

        //    String BeforePayProc = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") + 
        //        "@" + "begin dpt_web.fill_dpt_payments(" + dpt.ID + ",:REF);end;";

        //    String url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + dpt.GetTechTT(DPT_OP.OP_195,TECH_TYPE.TT_COMISS) + 
        //        "&nd=" + dpt.ID + "&SumC_t=1" + dop_rec + "&APROC=" + BeforePayProc + "\"";

        //    script += "window.showModalDialog(encodeURI(" + url + "),null," +
        //        "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";
        //}
        # endregion

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
            + ((Deposit)Session["NewDeposit"]).ID.ToString(),
            "deposit");

        Response.Redirect("/barsroot/deposit/deloitte/DepositContract.aspx?scheme=DELOITTE");
    }
    /// <summary>
    /// 
    /// </summary>
    private void RegisterEventScript(Deposit dpt)
    {
        String script = String.Empty;

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
            Deposit dpt = (Deposit)this.Session["NewDeposit"];
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
