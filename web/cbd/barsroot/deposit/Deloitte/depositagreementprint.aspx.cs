using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Logger;
using Bars.Exception;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Xml;

/// <summary>
/// Summary description for DepositAgreementPrint.
/// </summary>
public partial class DepositAgreementPrint : Bars.BarsPage
{
    # region Приватные свойства

    private String scheme
    {
        get
        {
            return Request["scheme"];
        }
    }
    // Депозитний договір
    private Decimal dpt_id
    {
        get
        {
            if (Request["dpt_id"] == null)
                Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=agreement&extended=0");
            return Convert.ToDecimal(Request["dpt_id"]);
        }
    }
    // Номер депозитного договору
    private String _dpt_num;
    private String dpt_num
    {
        get
        {
            if (String.IsNullOrEmpty(_dpt_num))
            {
                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();
                try
                {
                    cmd.Parameters.Add("p_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                    cmd.CommandText = "select d.deposit_id, d.nd from dpt_deposit d where d.deposit_id = :p_id";

                    OracleDataReader rdr = cmd.ExecuteReader();
                    if (rdr.Read())
                    {
                        _dpt_num = Convert.ToString(rdr["nd"]);
                    }
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            return _dpt_num;
        }
    }
    // З бази не вичитуємо - нам тут цього не треба
    private Deposit _dpt;
    private Deposit dpt
    {
        get
        {
            if (_dpt == null) _dpt = new Deposit(dpt_id, false);
            return _dpt;
        }
    }
    // Тип додаткової угоди
    private Int64 agr_id
    {
        get
        {
            if (Request["agr_id"] == null)
                Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=agreement&extended=0");
            return Convert.ToInt64(Request["agr_id"]);
        }
    }
    // Номер додаткової угоди
    private Decimal? agr_num
    {
        get
        {
            return (Decimal?)Session["DPTPRINT_AGRNUM"];
        }
        set
        {
            Session["DPTPRINT_AGRNUM"] = value;
        }
    }
    // Назва додаткової угоди
    private String _agr_type;
    private String agr_type
    {
        get
        {
            if (_agr_type == null)
            {
                if (agr_id == 5)
                {
                    _agr_type = "Довіреність";
                }
                else
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
            }
            return _agr_type;
        }
    }
    // РНК довіреної особи, що реєструють по вкладу
    private Decimal rnk
    {
        get
        {
            return Convert.ToDecimal(Request["rnk"]);
        }
    }
    /// <summary>
    /// РНК особи, що заключає дод. угоду (може бути порожнім - тоді заключає власник)
    /// </summary>
    private Decimal? rnk_tr
    {
        get
        {
            return Request["rnk_tr"] == null ? dpt.Client.ID : Convert.ToDecimal(Request["rnk_tr"]);
        }
    }
    // ІД сформормованої дод. угоди
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
    // Нова відсоткова ставка
    private String rate
    {
        get
        {
            return Request["rate"];
        }
    }
    // Дата початку дії відсоткової ставки
    private String rate_date
    {
        get
        {
            return String.IsNullOrEmpty(Request["rate_date"]) ? BankType.GetBankDate() : Request["rate_date"];
        }
    }
    // Нова дата завершення депозиту
    private DateTime? date_begin
    {
        get
        {
            // для доверености даты читаем с формы
            if (agr_id == 12)
                return dtBegin.Value <= DateTime.Now.AddYears(-100) ? (DateTime?)null : dtBegin.Value;
            else
                return Request["date_begin"] == null ? (DateTime?)null : Convert.ToDateTime(Request["date_begin"], Tools.Cinfo());
        }
    }
    private DateTime? date_end
    {
        get
        {
            // для доверености даты читаем с формы
            if (agr_id == 12)
                return dtEnd.Value <= DateTime.Now.AddYears(-100) ? (DateTime?)null : dtEnd.Value;
            else
                if (agr_id == 18) // BRSMAIN-2603
                    return dtDate.Value; // BRSMAIN-2603
                else
                    return Request["date_end"] == null ? (DateTime?)null : Convert.ToDateTime(Request["date_end"], Tools.Cinfo());
        }
    }
    // Рахунки для перерахування відсотків
    private String p_nls
    {
        get
        {
            return Request["p_nls"];
        }
    }
    private String p_mfo
    {
        get
        {
            return Request["p_mfo"];
        }
    }
    private String p_okpo
    {
        get
        {
            return Request["p_okpo"];
        }
    }
    private String p_nmk
    {
        get
        {
            return Request["p_nmk"];
        }
    }
    // Номер картки
    private String p_cardn
    {
        get
        {
            return Request["p_cardn"];
        }
    }
    // Рахунки для перерахування депозиту
    private String d_nls
    {
        get
        {
            return Request["d_nls"];
        }
    }
    private String d_mfo
    {
        get
        {
            return Request["d_mfo"];
        }
    }
    private String d_okpo
    {
        get
        {
            return Request["d_okpo"];
        }
    }
    private String d_nmk
    {
        get
        {
            return Request["d_nmk"];
        }
    }
    // Номер картки
    private String d_cardn
    {
        get
        {
            return Request["d_cardn"];
        }
    }

    private XmlDocument _p_doc;
    public XmlDocument p_doc
    {
        get
        {
            if (_p_doc == null)
            {
                _p_doc = CreateXmlDoc(p_nls, p_mfo, p_okpo, p_nmk, null);
            }
            return _p_doc;
        }
        set
        {
            _p_doc = value;
        }
    }

    private XmlDocument _d_doc;
    public XmlDocument d_doc
    {
        get
        {
            if (_d_doc == null)
            {
                _d_doc = CreateXmlDoc(d_nls, d_mfo, d_okpo, d_nmk, null);
            }
            return _d_doc;
        }
        set
        {
            _d_doc = value;
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
    /// 
    /// </summary>
    private String rate_req_id
    {
        get
        {
            return Request["rate_req"];
        }
    }

    /// <summary>
    /// Флаги доступу для довіреності
    /// </summary>
    private Decimal? Access_Flags;

    /// <summary>
    /// значення Інше в доступі до довіреності
    /// </summary>
    private string AccessOtherValue;

    #endregion

    #region События
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (Deposit.InheritedDeal(Convert.ToString(dpt_id)))
            throw new DepositException("По депозитному договору є зареєстровані спадкоємці. Дана функція заблокована.");


        if (!IsPostBack)
        {
            // автоматична ДУ про права Бенефіціара при відкритті вкладу
            if (agr_id == 5 && Session["OnBeneficiary"] != null)
            {
                CreateAgreement();

                Session.Remove("OnBeneficiary");

                Response.Redirect(String.Format("/barsroot/deposit/deloitte/DepositContractInfo.aspx?dpt_id={0}&scheme=DELOITTE", dpt_id));
            }

            // автоматична ДУ про додання малолітньої особи при відкритті вкладу
            if (agr_id == 27 /*&& Session["OnChildren"] != null*/)
            {
                DBLogger.Info("OnChildren", "deposit");
                CreateAgreement();

               // Session.Remove("OnChildren");

                Response.Redirect(String.Format("/barsroot/clientproducts/DepositClient.aspx?dpt_id={0}&scheme=DELOITTE&agr_id={1}&rnk_tr={2}&template={3}", dpt_id, 26, Request["rnk_tr"], "DPT_ADD_CHILD_MANAGER"));
            }

            // автоматична ДУ про передачу депозиту малолітньой особі при досягненні 14років
            if (agr_id == 28 )
            {
                CreateAgreement();

                Response.Redirect(String.Format("/barsroot/deposit/deloitte/DepositContractInfo.aspx?dpt_id={0}&scheme=DELOITTE", dpt_id));
            }
            // автоматична ДУ про додавання розпорядника по депозиту малолітньой особи
            if (agr_id == 26)
            {
                CreateAgreement();
                Session.Remove("OnChildren");
                Response.Redirect(String.Format("/barsroot/deposit/deloitte/DepositContractInfo.aspx?dpt_id={0}&scheme=DELOITTE", dpt_id));
            }

            // автоматична ДУ про відмову від виплати депозиту по ЕБП
            if (agr_id == 34)
            {
                CreateAgreement();

                Response.Redirect(String.Format("/barsroot/deposit/deloitte/DepositContractInfo.aspx?dpt_id={0}&scheme=DELOITTE", dpt_id));
            }

            Page.Header.Title = Resources.Deposit.GlobalResources.hDepositAgreementPrint;

            //var cblAlowedOperations = new CheckBoxList();

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = "select * from DPT_DICT_TRUSTYOPTIONS order by id_option";
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    cblAlowedOperations.Items.Add(new ListItem()
                    {
                        Value = Convert.ToString(reader["ID_OPTION"]),
                        Text = Convert.ToString(reader["NAME_OPTION"])
                    });
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            // предзаполненые параметры
            textDptNum.Text = dpt_num;
            textAgrType.Text = agr_type;
            dtDate.Value = DateTime.Now.Date;

            switch (agr_id)
            {
                case 12:  // якщо ДУ про доручення
                    trDover1.Visible = true;
                    trDover2.Visible = true;
                    trDover3.Visible = true;
                    trDover4.Visible = true;
                    dtBegin.Value = DateTime.Now.Date;
                    break;
                case 7: // якщо ДУ про Вступ в права
                    btCreate.Visible = false;
                    EADocPrint.Enabled = true;
                    break;
                case 18:// якщо ДУ на дострокове розірвання -- inga 19/05/2014// BRSMAIN-2603
                    dtDate.Enabled = true;                // BRSMAIN-2603
                    Label1.Text = "Дата видачі коштів"; // Inga 06/06/2014
                    btNextAgr.Enabled = false;
                    btPrint.Enabled = false;
                    EADocPrint.Enabled = false;
                    break;
                default:
                    // отображение кнопок печати FR для scheme == "DELOITTE"
                    btNextAgr.Enabled = false;

                    btPrint.Enabled = false;
                    EADocPrint.Enabled = false;
                    break;

            }
            

            EADocPrint.Visible = (scheme == "DELOITTE");
            btPrint.Visible = !(scheme == "DELOITTE");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btCreate_Click(object sender, EventArgs e)
    {
        // Шаблон
        String template = Request.QueryString["template"];

        if (agr_id == 12)
        {
            // Дозволенні операції згідно довіреності
            String flags = (cblAlowedOperations.Items[0].Selected ? "1" : "0") + // Отримання виписок за рахунком
                           (cblAlowedOperations.Items[1].Selected ? "1" : "0") + // Отримання депозиту та відсотків в останній день дії договору            
                           (cblAlowedOperations.Items[2].Selected ? "1" : "0") + // Дострокове повернення вкладу (депозиту)
                           // "0" +                                              // хз ???                                              
                           (cblAlowedOperations.Items[3].Selected ? "1" : "0") + // Розпоряджатися рахунками
                           (cblAlowedOperations.Items[4].Selected ? "1" : "0") + // Поповнювати рахунки
                           (cblAlowedOperations.Items[5].Selected ? "1" : "0") + // Отримувати (парераховувати) кошти з рахунків
                           (cblAlowedOperations.Items[6].Selected ? "1" : "0") + // Закрити рахунки
                           (cblAlowedOperations.Items[7].Selected ? "1" : "0");  // Інше
                           
            Access_Flags = Convert.ToDecimal(flags);
            AccessOtherValue = cblAlowedOperationsOther.Value;                  
        }
        else
        {
            Access_Flags = null;
        }

        // создаем ДУ, если не создали то CreateAgreement сама выбросит через ScriptManager ошибку
        if (!agr_uid.HasValue && CreateAgreement())
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateAgreement_Done", String.Format("alert('Додаткову угоду створено - №{0}'); ", agr_num), true);
        else
            return;

        // меняем доступность контролов
        dtBegin.Enabled = false;
        dtEnd.Enabled = false;
        nmAmount.Enabled = false;
        cblAlowedOperations.Enabled = false;
        btCreate.Enabled = false;

        btPrint.Enabled = true;
        EADocPrint.Enabled = true;

        btNextAgr.Enabled = true;

        // Формуємо текст дод. угоди, як параметр передаємо agr_uid, толко для agr_id == 12
        if (scheme != "DELOITTE")
            dpt.WriteAddAgreement(Convert.ToString(agr_uid), null);

        // формируем вызов Javascript для печати
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandText = "SELECT VAL FROM PARAMS WHERE PAR='C_FORMAT'";
            String Result = Convert.ToString(cmd.ExecuteScalar());

            switch (Result.ToUpper())
            {
                case "HTML":
                    btPrint.OnClientClick = String.Format("AddAgreementPrint('{0}', '{1}', '{2}', '{3}'); return false; ", dpt_id, agr_id, agr_num, template);
                    break;
                case "RTF":
                    btPrint.OnClientClick = String.Format("AddAgreementPrint_rtf('{0}', '{1}', '{2}', '{3}'); return false; ", dpt_id, agr_id, agr_num, template);
                    break;
                default:
                    btPrint.OnClientClick = String.Format("alert('{0}'); return false; ", Resources.Deposit.GlobalResources.al29);
                    break;
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        DBLogger.Info(String.Format("Текст дод.угоди № {0} по депозитному договору №{1} успішно зформовано та записано в БД.", agr_num, dpt.ID), "deposit");
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void EADocPrint_BeforePrint(object sender, EventArgs e)
    {
        // якщо ДУ про Вступ в права
        if ((agr_id == 7) && (!agr_uid.HasValue))
        {
            if (dpt.SetDefaultReceiver() == 1)
            {
                // реквізити для виплати відсотків
                p_doc = CreateXmlDoc(dpt.IntReceiverAccount, dpt.IntReceiverMFO, dpt.IntReceiverOKPO, dpt.IntReceiverName, null);

                // реквізити для виплати відсотків
                d_doc = CreateXmlDoc(dpt.RestReceiverAccount, dpt.RestReceiverMFO, dpt.RestReceiverOKPO, dpt.RestReceiverName, null);
            }

            if (CreateAgreement())
            {
                DBLogger.Info("Користувач завершив \"Вступ в право власності\" клієнтом з РНК=" + rnk_tr.ToString(), "deposit");
            }
        }

        // проверяем создана ли ДУ
        if (!agr_uid.HasValue)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateAgreement_Need", String.Format("alert('Необхідно спочатку створити додаткову угоду.'); "), true);
            return;
        }

        // параметры печати
        EADocPrint.RNK = Convert.ToInt64(rnk_tr);
        EADocPrint.AgrID = Convert.ToInt64(dpt_id);

        // код типу документу в ЕАД
        switch (agr_id)
        {
            // Додаткові угоди
            case 3:
            case 4:
            case 10:
            case 11:
            case 20:
            case 34:
                EADocPrint.EAStructID = 213;
                break;

            // Згода на набуття прав вкладника
            case 7:
                EADocPrint.EAStructID = 227;
                break;

            // Заповідальне розпорядження
            case 8:
                EADocPrint.EAStructID = 223;
                break;

            // анулювання заповідального розпорядження
            case 9:
                EADocPrint.EAStructID = 226;
                break;

            // Заява про зміну рахунків виплати
            //case 11:
            //    EADocPrint.EAStructID = 219;
            //    break;

            // Довіреність
            case 12:
                EADocPrint.EAStructID = 222;
                break;

            // анулювання довіреності
            case 13:
                EADocPrint.EAStructID = 225;
                break;

            // Заява на дострокове закриття вкладного рахунку
            case 18:
                EADocPrint.EAStructID = 211;
                break;

            default:
                Response.Write("<script>alert('Не вказано, або неправильний код типу додугоди!');</script>");
                Response.Flush();
                // return;
                break;
        }


        EADocPrint.TemplateID = Tools.Get_TemplateID(Convert.ToInt64(dpt_id), agr_id);
        EADocPrint.AddParams.Add(new FrxParameter("p_agrmnt_id", TypeCode.Int64, agr_uid));
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void EADocPrint_DocSigned(object sender, EventArgs e)
    {
        DBLogger.Info(String.Format("Користувач поставив відмітку про наявність підпису клієнта (rnk={0}) на дод.угоді №{1} до депозитного договору #{2}", rnk_tr, agr_num, dpt_id), "deposit");

        Response.Redirect(String.Format("/barsroot/deposit/deloitte/DepositContractInfo.aspx?dpt_id={0}&scheme=DELOITTE&rnk_tr={1}", dpt_id, rnk_tr));
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btNextAgr_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/deposit/deloitte/DepositContractInfo.aspx?dpt_id={0}&scheme=DELOITTE", dpt_id));
    }

    # endregion

    # region Приватные методы
    private Boolean CreateAgreement()
    {
        Boolean res = true;

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            // Референс запиту на відміну комісії з ГБ
            Decimal? req_num = (String.IsNullOrEmpty((String)Session["NO_COMISSION"]) ? (Decimal?)null : Convert.ToDecimal(Session["NO_COMISSION"]));
            Session["NO_COMISSION"] = String.Empty;

            // Референс документа комісії
            Decimal? doc_ref = (String.IsNullOrEmpty((String)Session["REF"]) ? (Decimal?)null : Convert.ToDecimal(Session["REF"]));
            Session["REF"] = String.Empty;

            // DepositAgreement.Create(dpt_id, agr_id, rnk_tr, rnk, id_trustee, d_doc.InnerXml, p_doc.InnerXml, 
            // date_begin, date_end, nmAmount, null);

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
                                                            null, 
                                                            :ref, 
                                                            null,
                                                            :req_num,
                                                            :agr_uid,
                                                            :p_templateid,
                                                            :p_access_others); end;";
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
            cmd.Parameters.Add("p_denomamount", OracleDbType.Decimal, nmAmount.Value, ParameterDirection.Input);
            cmd.Parameters.Add("p_denomcount", OracleDbType.Decimal, Access_Flags, ParameterDirection.Input);
            // cmd.Parameters.Add("p_denomref", OracleDbType.Decimal, doc_ref, ParameterDirection.Input);
            cmd.Parameters.Add("ref", OracleDbType.Decimal, doc_ref, ParameterDirection.Input);
            cmd.Parameters.Add("req_num", OracleDbType.Decimal, req_num, ParameterDirection.Input);
            cmd.Parameters.Add("agr_uid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);
            cmd.Parameters.Add("p_templateid", OracleDbType.Varchar2, EADocPrint.TemplateID, ParameterDirection.Input);
            cmd.Parameters.Add("p_access_others", OracleDbType.Varchar2, AccessOtherValue, ParameterDirection.Input);
            cmd.ExecuteNonQuery();

            agr_uid = ((OracleDecimal)cmd.Parameters["agr_uid"].Value).Value;

            // Вычитываем параметры созданой ДУ
            OracleCommand cmd2 = con.CreateCommand();

            cmd2.CommandText = @"select da.agrmnt_date, da.agrmnt_num from V_DPT_AGREEMENTS da 
                where da.agrmnt_id = :p_agrmnt_id";

            cmd2.Parameters.Add("p_agrmnt_id", OracleDbType.Decimal, agr_uid, ParameterDirection.Input);

            OracleDataReader rdr = cmd2.ExecuteReader();

            if (rdr.Read())
            {
                agr_num = Convert.ToDecimal(rdr["agrmnt_num"]);
            }
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
                throw new DepositException(oe.Message);
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return res;
    }
    # endregion
}
