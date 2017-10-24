using System;
using System.Data;
using System.Web.UI;
using Bars.Oracle;
using Bars.Exception;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Xml;
using BarsWeb.Core.Logger;

/// <summary>
/// Summary description for DepositAgreementPrint.
/// </summary>
public partial class DepositAgreementPrint : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public DepositAgreementPrint()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

    /// <summary>
    /// Тип додаткової угоди
    /// </summary>
    private Int64 agr_id
    {
        get
        {
            if (Request["agr_id"] == null)
                Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=agreement&extended=0");
            return Convert.ToInt64(Request["agr_id"]);
        }
    }

    /// <summary>
    /// Назва додаткової угоди
    /// </summary>
    private String _agr_type;
    private String agr_type
    {
        get
        {
            if (_agr_type == null)
            {
                try
                {
                    InitOraConnection();
                    SetParameters("id", DB_TYPE.Decimal, agr_id, DIRECTION.Input);
                    _agr_type = Convert.ToString(SQL_SELECT_scalar("select name from dpt_vidd_flags where id = :id"));
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
            return _agr_type;
        }
    }

    /// <summary>
    /// ІД сформормованої додаткової угоди
    /// </summary>
    private Decimal? agr_uid
    {
        get
        {
            return (Decimal?)ViewState["agr_uid"];
        }
        set
        {
            ViewState["agr_uid"] = value;
        }
    }

    /// <summary>
    /// DPT_TRUSTEE.ID - для дод. угоди, що анульовуємо, або згідно якої вступаємо в права
    /// </summary>
    private Decimal? id_trustee
    {
        get
        {
            return Request["idtr"] == null ? (Decimal?)null : Convert.ToDecimal(Request["idtr"]);
        }
    }

    /// <summary>
    /// Нова відсоткова ставка
    /// </summary>
    private String rate
    {
        get
        {
            return Request.QueryString["rate"];
        }
    }

    /// <summary>
    /// Дата початку дії відсоткової ставки
    /// </summary>
    private String rate_date
    {
        get
        {
            return String.IsNullOrEmpty(Request["rate_date"]) ? BankType.GetBankDate() : Request["rate_date"];
        }
    }

    /// <summary>
    /// Нова дата завершення депозиту 
    /// </summary>
    private DateTime? date_begin
    {
        get
        {
            // для доверености даты читаем с формы
            if (agr_id == 12)
                return dtBegin.Date <= DateTime.Now.AddYears(-100) ? (DateTime?)null : dtBegin.Date;
            else
                return Request["date_begin"] == null ? (DateTime?)null : Convert.ToDateTime(Request["date_begin"], Tools.Cinfo());
        }
    }
    
    /// <summary>
    /// 
    /// </summary>
    private DateTime? date_end
    {
        get
        {
            // для доверености даты читаем с формы
            if (agr_id == 12)
                return dtEnd.Date <= DateTime.Now.AddYears(-100) ? (DateTime?)null : dtEnd.Date;
            else
                return Request["date_end"] == null ? (DateTime?)null : Convert.ToDateTime(Request["date_end"], Tools.Cinfo());
        }
    }
    
    /// <summary>
    /// Формування XML із реквізитами отримувача відсотків / депозиту
    /// </summary>
    /// <param name="NLS">№ рахунка отримувача</param>
    /// <param name="MFO">МФО банку отримувача</param>
    /// <param name="OKPO">ОКПО отримувача</param>
    /// <param name="NMK">Назва отримувача</param>
    /// <param name="CardN">№ БПК отримувача</param>
    /// <returns></returns>
    private XmlDocument CreateXmlDoc(String NLS, String MFO, String OKPO, String NMK, String CardN)
    {
        XmlDocument res;

        res = new XmlDocument();

        XmlNode p_root = res.CreateElement("doc");
        res.AppendChild(p_root);

        XmlNode a_p_nls = res.CreateElement("nls");
        a_p_nls.InnerText = NLS;
        p_root.AppendChild(a_p_nls);

        XmlNode a_p_mfo = res.CreateElement("mfo");
        a_p_mfo.InnerText = MFO;
        p_root.AppendChild(a_p_mfo);

        XmlNode a_p_okpo = res.CreateElement("okpo");
        a_p_okpo.InnerText = OKPO;
        p_root.AppendChild(a_p_okpo);

        XmlNode a_p_nmk = res.CreateElement("nmk");
        a_p_nmk.InnerText = NMK;
        p_root.AppendChild(a_p_nmk);

        if (!String.IsNullOrEmpty(CardN))
        {
            XmlNode a_p_cardn = res.CreateElement("cardn");
            a_p_cardn.InnerText = CardN;
            p_root.AppendChild(a_p_cardn);
        }

        return res;
    }

    /// <summary>
    /// Флаги доступу для довіреності
    /// </summary>
    private Decimal? Access_Flags;

    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (Deposit.InheritedDeal(Convert.ToString(Request["dpt_id"])))
            throw new DepositException("По депозитному договору є зареєстровані спадкоємці. Дана функція заблокована.");

        /// Якщо прийшли без параметрів - відправляємо туди, звідки прийшли :-)
        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

        if (Request["agr_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

        if (Request["template"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

        /// Заповнюємо дані на формі
        dpt_id.Value = Convert.ToString(Request["dpt_id"]);
        template.Value = Convert.ToString(Request["template"]);
        textAgrId.Value = Convert.ToString(Request["agr_id"]);

        /// По замовчуванню КНОПКА ДРУКУ не активна
        /// Вона стає активною тільки після постбека
        /// єдиний спосіб згенерувати який - натиснути "Формувати"
        if (!IsPostBack)
        {
            btPrint.Disabled = true;

            Page.Header.Title = Resources.Deposit.GlobalResources.hDepositAgreementPrint;

            // 
            textDptNum.Text = Convert.ToString(Session["DPT_NUM"]);
            textAgrType.Text = agr_type;
            dtDate.Value = DateTime.Now.Date;

            if (Request.QueryString["agr_id"] == "12")
            {
                trDover1.Visible = true;
                // trDover2.Visible = true;
                // trDover3.Visible = true;
                // trDover4.Visible = true;
                dtBegin.Date = DateTime.Now.Date;
            }
        }

        EnablePrint();
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
        this.btForm.Click += new System.EventHandler(this.btForm_Click);
        this.btNextAgr.Click += new System.EventHandler(this.btNextAgrSameType_Click);
        ;

    }
    #endregion
    /// <summary>
    /// Формування текстів договорів
    /// </summary>
    private void btForm_Click(object sender, System.EventArgs e)
    {
        if (agr_id == 12)
        {
            /// Дозволенні операції згідно довіреності            
            String flags = (cblAlowedOperations.Items[0].Selected ? "1" : "0") + // Отримання виписок за рахунком
                           (cblAlowedOperations.Items[1].Selected ? "1" : "0") + // Отримання депозиту та відсотків в останній день дії договору            
                           (cblAlowedOperations.Items[2].Selected ? "1" : "0") + // Дострокове повернення вкладу (депозиту)
                           "0";
            Access_Flags = Convert.ToDecimal(flags);
        }
        else
        {
            Access_Flags = null;
        }

        // создаем ДУ, если не создали то CreateAgreement сама выбросит через ScriptManager ошибку
        if (!agr_uid.HasValue && CreateAgreement())
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateAgreement_Done", String.Format("alert('Створено додаткову угоду #{0}'); ", agr_id), true);
        else
            return;

        // меняем доступность контролов
        dtBegin.Enabled = false;
        dtEnd.Enabled = false;
        btPrint.Disabled = false;
        btForm.Enabled = false;
        btNextAgr.Visible = true;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btNextAgrSameType_Click(object sender, System.EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

        if (Request["agr_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

        Response.Redirect("DepositSelectTrustee.aspx?dpt_id=" + Request.QueryString["dpt_id"] + "&dest=agreement");
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
                btPrint.Attributes["onclick"] = "javascript:AddAgreementPrint();";
            else if (result == "RTF")
                btPrint.Attributes["onclick"] = "javascript:AddAgreementPrint_rtf();";
            else
            {
                btPrint.Attributes["onclick"] = "javascript:alert('" + Resources.Deposit.GlobalResources.al29 + "');";
                //btPrint.Attributes["onclick"] = "javascript:alert('Формат документов не поддерживается');";
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
    /// <returns></returns>
    private Boolean CreateAgreement()
    {
        Boolean res = true;
        Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);

        /// Додаткова угода про зміну суми
        if (agr_id == 2)
        {
            /// ДУ формується при оплаті документу - тут ми вичитуємо лише її ІД
            try
            {
                InitOraConnection();
                SetParameters("dpt_id", DB_TYPE.Decimal, dpt_id, DIRECTION.Input);
                agr_uid = Convert.ToDecimal(SQL_SELECT_scalar("SELECT value FROM dpt_depositw WHERE tag = 'LSTAG' AND dpt_id = :dpt_id"));
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else
        {
            /////////////////////////
            /// Усі інші Дод.Угоди //
            /////////////////////////

            // Депозитний договір
          //  Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);

            // З бази не вичитуємо - нам тут цього не треба
            Deposit dpt = new Deposit(dpt_id);

            // Номер сформормованої додаткової угоди
            Decimal? agr_num;

            // РНК довіреної особи, що реєструють по вкладу
            Decimal rnk = Convert.ToDecimal(Request["rnk"]);

            // РНК довіреної особи, що заключає дод. угоду (може бути порожнім - тоді заключає власник)
            Decimal rnk_tr = (Request["rnk_tr"] == null ? dpt.Client.ID : Convert.ToDecimal(Request["rnk_tr"]));

            ///
            /// Реквізити рахунку для перерахування відсотків
            /// 
            String p_nls = Request.QueryString["p_nls"];
            String p_mfo = Request.QueryString["p_mfo"];
            String p_okpo = Request.QueryString["p_okpo"];
            String p_nmk = Request.QueryString["p_nmk"];
            String p_cardn = Request.QueryString["p_cardn"];

            XmlDocument p_doc = CreateXmlDoc(p_nls, p_mfo, p_okpo, p_nmk, null);

            ///
            /// Реквізити рахунку для перерахування депозиту
            /// 
            String d_nls = Request.QueryString["d_nls"];
            String d_mfo = Request.QueryString["d_mfo"];
            String d_okpo = Request.QueryString["d_okpo"];
            String d_nmk = Request.QueryString["d_nmk"];
            String d_cardn = Request.QueryString["d_cardn"];

            XmlDocument d_doc = CreateXmlDoc(d_nls, d_mfo, d_okpo, d_nmk, null);

            // код запиту на змину %% ставки
            String rate_req_id = Request.QueryString["rate_req"];

            Decimal worn_sum = (Request["worn_sum"] == null ? 0 : Convert.ToDecimal(Request["worn_sum"]));

            /// Шаблон
            String Template = Request.QueryString["template"];

            // Періодичність
            Decimal Freq = Convert.ToDecimal(Request.QueryString["freq"]);

            // Референс запиту на відміну комісії
            Decimal? req_num = (String.IsNullOrEmpty((String)Session["NO_COMISSION"]) ? (Decimal?)null : Convert.ToDecimal(Session["NO_COMISSION"]));
            Session["NO_COMISSION"] = String.Empty;

            // Референс документа комісії
            Decimal? doc_ref = (String.IsNullOrEmpty((String)Session["REF"]) ? (Decimal?)null : Convert.ToDecimal(Session["REF"]));
            Session["REF"] = String.Empty;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = @"begin
                                      dpt_web.create_agreement( :dpt_id,
                                                                :agr_id,
                                                                :rnk_tr,
                                                                :p_trustcustid, 
                                                                :p_trustid,
                                                                :d_data,
                                                                :p_data, 
                                                                null, null, 
                                                                :date_begin, :date_end, 
                                                                null, null, null, 
                                                                :p_denomamount, 
                                                                :p_denomcount, 
                                                                :p_denomref, 
                                                                :p_comissref, 
                                                                null,
                                                                :req_num,
                                                                :agr_uid,
                                                                :p_templateid,
                                                                :p_freq ); end;";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmd.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmd.Parameters.Add("rnk_tr", OracleDbType.Decimal, rnk_tr, ParameterDirection.Input);
                cmd.Parameters.Add("p_trustcustid", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                cmd.Parameters.Add("p_trustid", OracleDbType.Decimal, id_trustee, ParameterDirection.Input);
                cmd.Parameters.Add("d_data", OracleDbType.Clob, d_doc.InnerXml, ParameterDirection.Input);
                cmd.Parameters.Add("p_data", OracleDbType.Clob, p_doc.InnerXml, ParameterDirection.Input);
                cmd.Parameters.Add("date_begin", OracleDbType.Date, date_begin, ParameterDirection.Input);
                cmd.Parameters.Add("date_end", OracleDbType.Date, date_end, ParameterDirection.Input);
                //cmd.Parameters.Add("p_rate_reqid", OracleDbType.Decimal, rate_req_id, ParameterDirection.Input);
                //cmd.Parameters.Add("p_ratevalue", OracleDbType.Decimal, rate, ParameterDirection.Input);
                //cmd.Parameters.Add("p_ratedate", OracleDbType.Date, rate_date, ParameterDirection.Input);
                cmd.Parameters.Add("p_denomamount", OracleDbType.Decimal, worn_sum, ParameterDirection.Input);
                cmd.Parameters.Add("p_denomcount", OracleDbType.Decimal, Access_Flags, ParameterDirection.Input);
                cmd.Parameters.Add("p_denomref", OracleDbType.Decimal, doc_ref, ParameterDirection.Input);
                cmd.Parameters.Add("p_comissref", OracleDbType.Decimal, doc_ref, ParameterDirection.Input);
                cmd.Parameters.Add("req_num", OracleDbType.Decimal, req_num, ParameterDirection.Input);
                cmd.Parameters.Add("agr_uid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);
                cmd.Parameters.Add("p_templateid", OracleDbType.Varchar2, Template, ParameterDirection.Input);
                cmd.Parameters.Add("p_freq", OracleDbType.Decimal, Freq, ParameterDirection.Input);

                cmd.ExecuteNonQuery();

                agr_uid = ((OracleDecimal)cmd.Parameters["agr_uid"].Value).Value;

                /// GenerateAgreementText()

                Session["DPTPRINT_DPTID"] = dpt_id;
                Session["DPTPRINT_AGRID"] = agr_id;
                Session["DPTPRINT_TEMPLATE"] = Template;

                /// Формуємо текст дод. угоди (як параметр передаємо agr_uid)
                agr_num = dpt.WriteAddAgreement(agr_uid.ToString(), null);

                // textAgrNum.Value = agr_num.ToString();

                Session["DPTPRINT_AGRNUM"] = agr_num.ToString();

                OracleCommand cmd2 = con.CreateCommand();

                cmd2.CommandText = "select to_char(c.version,'dd/mm/yyyy') from cc_docs c " +
                    "where c.id = :p_template and c.nd = :p_dpt_id and c.adds = :p_agr_num ";

                cmd2.Parameters.Add("p_template", OracleDbType.Varchar2, Template, ParameterDirection.Input);
                cmd2.Parameters.Add("p_dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmd2.Parameters.Add("p_agr_num", OracleDbType.Decimal, agr_num, ParameterDirection.Input);

                String dt = Convert.ToString(cmd2.ExecuteScalar());
                dtDate.Date = Convert.ToDateTime(dt, Tools.Cinfo());

                _dbLogger.Info( "Текст дод.угоди № " + agr_num.ToString() + " по депозитному договору №" + dpt_id.ToString() +
                               " успішно згенерований та збережений в БД.", "deposit");
            }
            catch (OracleException oe)
            {
                res = false;
                if (oe.Message.Contains("UK_DPTTRUSTEE"))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateAgreement_Done", String.Format("alert('Вказана довірена особа вже існує!'); location.href = 'DepositContractInfo.aspx?dpt_id={0}&scheme=DELOITTE'", dpt_id), true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateAgreement_Done", "alert('" + oe.Message.Replace("'", "`").Substring(11, oe.Message.IndexOf("\n") - 11) + "');", true);
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        return res;
    }
}
