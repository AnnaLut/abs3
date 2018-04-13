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
using Oracle.DataAccess.Types;
using System.Globalization;
using System.Xml;
using Bars.Exception;

/// <summary>
/// Summary description for DepositAgreementPrint.
/// </summary>
public partial class DepositAgreementPrint : Bars.BarsPage
{
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

        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositAgreementPrint;

        OracleConnection connect = new OracleConnection();
        
        /// По замовчуванню кнопка друку не активна
        /// Вона стає активною тільки після постбека
        /// єдиний спосіб згенерувати який - натиснути "Формувати"
        if (!IsPostBack)
        {
            btPrint.Disabled = true;

            if (Convert.ToString(Request["agr_id"]) == "12")
            {
                dtBegin.Date = DateTime.Now;
                trDover1.Visible = true;
                
            }

        }

        EnablePrint();

        try
        {            
            /// Заповнюємо дані на формі
            dpt_id.Value = Convert.ToString(Request["dpt_id"]);
            template.Value = Convert.ToString(Request["template"]);
            textAgrId.Value = Convert.ToString(Request["agr_id"]);
            textDptNum.Text = Convert.ToString(Session["DPT_NUM"]);            
            dtDate.Value = DateTime.Now.Date;

            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = "select name from dpt_vidd_flags where id = :id";
            cmdSearch.Parameters.Add("id", OracleDbType.Decimal, Request["agr_id"], ParameterDirection.Input);

            textAgrType.Text = Convert.ToString(cmdSearch.ExecuteScalar());
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
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
        OracleConnection connect = new OracleConnection();

        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        /// З бази не вичитуємо - нам тут цього не треба
        Deposit dpt = new Deposit(Convert.ToDecimal(Request["dpt_id"]));

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            /// Шаблон
            String t_id = Convert.ToString(Request["template"]);
            /// Депозитний договір
            Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
            /// Тип додаткової угоди
            Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);
            /// Номер додаткової угоди
            Decimal agr_num = Decimal.MinValue;
            /// РНК довіреної особи, що реєструють по вкладу
            Decimal rnk = Convert.ToDecimal(Convert.ToString(Request["rnk"]));
            /// РНК довіреної особи, що заключає дод. угоду
            /// може бути порожнім - тоді заключає власник
            Decimal rnk_tr = (Request["rnk_tr"] == null ? dpt.Client.ID
                : Convert.ToDecimal(Convert.ToString(Request["rnk_tr"])));
            /// ІД сформормованої дод. угоди
            String agr_uid = String.Empty;
            /// id з dpt_trustee, для дод. угоди, що анульовуємо,
            /// або по якій вступаємо в права
            String id_trustee = Convert.ToString(Request["idtr"]);
            /// Нова відсоткова ставка
            String rate = (Request["rate"] == null ? String.Empty
                : Convert.ToString(Request["rate"]));
            /// Дата початку дії відсоткової ставки
            String rate_date = (Request["rate_date"] == null ? String.Empty
                : Convert.ToString(Request["rate_date"]));
            if (String.IsNullOrEmpty(rate_date))
                rate_date = BankType.GetBankDate();
            /// Нова дата завершення депозиту
            String date_begin = (Request["date_begin"] == null ? String.Empty
                : Convert.ToString(Request["date_begin"]));
            String date_end = (Request["date_end"] == null ? String.Empty
                : Convert.ToString(Request["date_end"]));
            ///
            /// Рахунки для перерахування відсотків
            /// 
            String p_nls = (Request["p_nls"] == null ? String.Empty
                : Convert.ToString(Request["p_nls"]));
            String p_mfo = (Request["p_mfo"] == null ? String.Empty
                : Convert.ToString(Request["p_mfo"]));
            String p_okpo = (Request["p_okpo"] == null ? String.Empty
                : Convert.ToString(Request["p_okpo"]));
            String p_nmk = (Request["p_nmk"] == null ? String.Empty
                : Convert.ToString(Request["p_nmk"]));
            // Номер картки
            String p_cardn = (Request["p_cardn"] == null ? String.Empty
                : Convert.ToString(Request["p_cardn"]));
            ///
            /// Рахунки для перерахування депозиту
            /// 
            String d_nls = (Request["d_nls"] == null ? String.Empty
                : Convert.ToString(Request["d_nls"]));
            String d_mfo = (Request["d_mfo"] == null ? String.Empty
                : Convert.ToString(Request["d_mfo"]));
            String d_okpo = (Request["d_okpo"] == null ? String.Empty
                : Convert.ToString(Request["d_okpo"]));
            String d_nmk = (Request["d_nmk"] == null ? String.Empty
                : Convert.ToString(Request["d_nmk"]));
            // Номер картки
            String d_cardn = (Request["d_cardn"] == null ? String.Empty
                : Convert.ToString(Request["d_cardn"]));

            String rate_req_id = (Request["rate_req"] == null ? String.Empty
                : Convert.ToString(Request["rate_req"]));

            Decimal worn_sum = (Request["worn_sum"] == null ? 0
                : Convert.ToDecimal(Convert.ToString(Request["worn_sum"])));
                

            /// Референс запиту на відміну комісії з ГБ
            String req_num = Convert.ToString(Session["NO_COMISSION"]);
            Session["NO_COMISSION"] = String.Empty;

            /// Референс документа комісії
            String doc_ref = Convert.ToString(Session["REF"]);
            Session["REF"] = String.Empty;

            /// Додаткова угода про зміну суми
            /// Сама угода формується при оплаті - тут ми вичитуємо лише її ід
            if (agr_id == 2)
            {
                OracleCommand cmdRegister = connect.CreateCommand();
                cmdRegister.CommandText = "select value from dpt_depositw where tag = 'LSTAG' and dpt_id = :dpt_id ";
                cmdRegister.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                agr_uid = Convert.ToString(cmdRegister.ExecuteScalar());
            }
            /// Додаткова угода про зміну відсоткової ставки
            else if (agr_id == 3)
            {
                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = "begin " +
                    " dpt_web.create_agreement " +
                    " (:dpt_id,:agr_id,:rnk_tr, " +
                    " null,null,null,null,null,null,null,null,null, " +
                    " null,null, " +
                    " null,null,null,null,null,:req_num,:agr_uid " +
                    " ); " +
                    "end;";
                cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmd.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmd.Parameters.Add("rnk_tr", OracleDbType.Decimal, rnk_tr, ParameterDirection.Input);
                //cmd.Parameters.Add("p_rate_reqid", OracleDbType.Decimal, rate_req_id, ParameterDirection.Input);
                //cmd.Parameters.Add("p_ratevalue", OracleDbType.Decimal, rate, ParameterDirection.Input);
                //cmd.Parameters.Add("p_ratedate", OracleDbType.Date, Convert.ToDateTime(rate_date, cinfo), ParameterDirection.Input);
                if (!String.IsNullOrEmpty(req_num))
                    cmd.Parameters.Add("req_num", OracleDbType.Decimal, req_num, ParameterDirection.Input);
                else
                    cmd.Parameters.Add("req_num", OracleDbType.Decimal, null, ParameterDirection.Input);
                cmd.Parameters.Add("agr_uid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                agr_uid = Convert.ToString(cmd.Parameters["agr_uid"].Value);
            }
            /// Додаткова угода про зміну терміну вкладу
            else if (agr_id == 4)
            {
                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = "begin " +
                                    " dpt_web.create_agreement " +
                                    " (:dpt_id, :agr_id, :rnk_tr, " +
                                    " null, null, null, null, null, null, :date_begin, :date_end, " +
                                    " null, null, null, null, null, null, null, null, " +
                                    " :req_num,:agr_uid ); " +
                                    "end;";
                cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmd.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmd.Parameters.Add("rnk_tr", OracleDbType.Decimal, rnk_tr, ParameterDirection.Input);
                cmd.Parameters.Add("date_begin", OracleDbType.Date, Convert.ToDateTime(date_begin, cinfo), ParameterDirection.Input);
                cmd.Parameters.Add("date_end", OracleDbType.Date, Convert.ToDateTime(date_end, cinfo), ParameterDirection.Input);
                if (!String.IsNullOrEmpty(req_num))
                    cmd.Parameters.Add("req_num", OracleDbType.Decimal, req_num, ParameterDirection.Input);
                else
                    cmd.Parameters.Add("req_num", OracleDbType.Decimal, null, ParameterDirection.Input);
                cmd.Parameters.Add("agr_uid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                agr_uid = Convert.ToString(cmd.Parameters["agr_uid"].Value);
            }
            /// Додаткові угоди про 3х осіб - створення
            else if (agr_id == 5 || agr_id == 8)
            {
                /// Реєструємо додаткову угоду
                OracleCommand cmdRegister = connect.CreateCommand();
                cmdRegister.CommandText = "begin dpt_web.create_agreement " +
                " (:dpt_id,:agr_id,:init_cust_id,:p_trustcustid, " +
                " null,null,null,null,null,null,null,null,null,null,null,null,null,:ref,null,:req_num, " +
                " :p_agrmntid " +
                " ); " +
                "end;";

                cmdRegister.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("init_cust_id", OracleDbType.Decimal, rnk_tr, ParameterDirection.Input);
                cmdRegister.Parameters.Add("p_trustcustid", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                if (!String.IsNullOrEmpty(doc_ref))
                    cmdRegister.Parameters.Add("ref", OracleDbType.Decimal, doc_ref, ParameterDirection.Input);
                else
                    cmdRegister.Parameters.Add("ref", OracleDbType.Decimal, null, ParameterDirection.Input);
                if (!String.IsNullOrEmpty(req_num))
                    cmdRegister.Parameters.Add("req_num", OracleDbType.Decimal, req_num, ParameterDirection.Input);
                else
                    cmdRegister.Parameters.Add("req_num", OracleDbType.Decimal, null, ParameterDirection.Input);
                cmdRegister.Parameters.Add("p_agrmntid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);

                cmdRegister.ExecuteNonQuery();

                agr_uid = Convert.ToString(cmdRegister.Parameters["p_agrmntid"].Value);
            }
            /// Додаткові угоди про довіреність - створення
            else if (agr_id == 12)
            {
                /// Реєструємо додаткову угоду
                OracleCommand cmdRegister = connect.CreateCommand();
                cmdRegister.CommandText = "begin dpt_web.create_agreement " +
                " (:dpt_id,:agr_id,:init_cust_id,:p_trustcustid, " +
                " null,null,null,null,null,trunc(:dat_begin),trunc(:dat_end),null,null,null,null,null,null,:ref,null,:req_num, " +
                " :p_agrmntid " +
                " ); " +
                "end;";

                cmdRegister.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("init_cust_id", OracleDbType.Decimal, rnk_tr, ParameterDirection.Input);
                cmdRegister.Parameters.Add("p_trustcustid", OracleDbType.Decimal, rnk, ParameterDirection.Input);

                if (dtBegin.Date <= DateTime.Now.AddYears(-100))
                    cmdRegister.Parameters.Add("dat_begin", OracleDbType.Date, null, ParameterDirection.Input);
                else
                    cmdRegister.Parameters.Add("dat_begin", OracleDbType.Date, dtBegin.Date, ParameterDirection.Input);

                if (dtEnd.Date <= DateTime.Now.AddYears(-100))
                    cmdRegister.Parameters.Add("dat_end", OracleDbType.Date, null, ParameterDirection.Input);
                else
                    cmdRegister.Parameters.Add("dat_end", OracleDbType.Date, dtEnd.Date, ParameterDirection.Input);

                if (!String.IsNullOrEmpty(doc_ref))
                    cmdRegister.Parameters.Add("ref", OracleDbType.Decimal, doc_ref, ParameterDirection.Input);
                else
                    cmdRegister.Parameters.Add("ref", OracleDbType.Decimal, null, ParameterDirection.Input);
                if (!String.IsNullOrEmpty(req_num))
                    cmdRegister.Parameters.Add("req_num", OracleDbType.Decimal, req_num, ParameterDirection.Input);
                else
                    cmdRegister.Parameters.Add("req_num", OracleDbType.Decimal, null, ParameterDirection.Input);
                cmdRegister.Parameters.Add("p_agrmntid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);

                cmdRegister.ExecuteNonQuery();

                agr_uid = Convert.ToString(cmdRegister.Parameters["p_agrmntid"].Value);
            }
            /// Додаткові угоди про 3х осіб - анулювання + вступ в права
            else if (agr_id == 6 || agr_id == 9 || agr_id == 13 || agr_id == 7)
            {
                /// Реєструємо додаткову угоду
                OracleCommand cmdRegister = connect.CreateCommand();
                cmdRegister.CommandText = "begin dpt_web.create_agreement " +
                " (:dpt_id,:agr_id,:init_cust_id,:p_trustcustid,:p_trustid, " +
                " null,null,null,null,null,null,null,null,null,null,null,null,:ref,null,:req_num, " +
                " :p_agrmntid " +
                " ); " +
                "end;";

                cmdRegister.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("init_cust_id", OracleDbType.Decimal, rnk_tr, ParameterDirection.Input);
                cmdRegister.Parameters.Add("p_trustcustid", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                cmdRegister.Parameters.Add("p_trustid", OracleDbType.Decimal, id_trustee, ParameterDirection.Input);
                if (!String.IsNullOrEmpty(doc_ref))
                    cmdRegister.Parameters.Add("ref", OracleDbType.Decimal, doc_ref, ParameterDirection.Input);
                else
                    cmdRegister.Parameters.Add("ref", OracleDbType.Decimal, null, ParameterDirection.Input);
                if (!String.IsNullOrEmpty(req_num))
                    cmdRegister.Parameters.Add("req_num", OracleDbType.Decimal, req_num, ParameterDirection.Input);
                else
                    cmdRegister.Parameters.Add("req_num", OracleDbType.Decimal, null, ParameterDirection.Input);
                cmdRegister.Parameters.Add("p_agrmntid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);

                cmdRegister.ExecuteNonQuery();

                agr_uid = Convert.ToString(cmdRegister.Parameters["p_agrmntid"].Value);
            }
            /// Перерахування на поточні / карткові рахунки
            else if (agr_id == 10 || agr_id == 11)
            {
                /// Реєструємо додаткову угоду
                OracleCommand cmdRegister = connect.CreateCommand();
                cmdRegister.CommandText = "begin dpt_web.create_agreement " +
                " (:dpt_id,:agr_id,:init_cust_id,null,null, " +
                " :d_data,:p_data,null,null,null,null,null,null,null,null,null,null,null,null,:req_num, " +
                " :p_agrmntid " +
                " ); " +
                "end;";

                XmlDocument p_doc = new XmlDocument();
                XmlNode p_root = p_doc.CreateElement("doc");
                p_doc.AppendChild(p_root);

                XmlNode a_p_nls = p_doc.CreateElement("nls");
                a_p_nls.InnerText = p_nls;
                p_root.AppendChild(a_p_nls);

                XmlNode a_p_mfo = p_doc.CreateElement("mfo");
                a_p_mfo.InnerText = p_mfo;
                p_root.AppendChild(a_p_mfo);

                XmlNode a_p_okpo = p_doc.CreateElement("okpo");
                a_p_okpo.InnerText = p_okpo;
                p_root.AppendChild(a_p_okpo);

                XmlNode a_p_nmk = p_doc.CreateElement("nmk");
                a_p_nmk.InnerText = p_nmk;
                p_root.AppendChild(a_p_nmk);

                if (p_cardn != String.Empty)
                {
                    XmlNode a_p_cardn = p_doc.CreateElement("cardn");
                    a_p_cardn.InnerText = p_cardn;
                    p_root.AppendChild(a_p_cardn);
                }

                XmlDocument d_doc = new XmlDocument();
                XmlNode d_root = d_doc.CreateElement("doc");
                d_doc.AppendChild(d_root);

                XmlNode a_d_nls = d_doc.CreateElement("nls");
                a_d_nls.InnerText = d_nls;
                d_root.AppendChild(a_d_nls);

                XmlNode a_d_mfo = d_doc.CreateElement("mfo");
                a_d_mfo.InnerText = d_mfo;
                d_root.AppendChild(a_d_mfo);

                XmlNode a_d_okpo = d_doc.CreateElement("okpo");
                a_d_okpo.InnerText = d_okpo;
                d_root.AppendChild(a_d_okpo);

                XmlNode a_d_nmk = d_doc.CreateElement("nmk");
                a_d_nmk.InnerText = d_nmk;
                d_root.AppendChild(a_d_nmk);

                if (d_cardn != String.Empty)
                {
                    XmlNode a_d_cardn = d_doc.CreateElement("cardn");
                    a_d_cardn.InnerText = d_cardn;
                    d_root.AppendChild(a_d_cardn);
                }

                cmdRegister.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("init_cust_id", OracleDbType.Decimal, rnk_tr, ParameterDirection.Input);
                cmdRegister.Parameters.Add("d_data", OracleDbType.Clob, d_doc.InnerXml, ParameterDirection.Input);
                cmdRegister.Parameters.Add("p_data", OracleDbType.Clob, p_doc.InnerXml, ParameterDirection.Input);
                ///cmdRegister.Parameters.Add("ref", OracleDbType.Decimal, doc_ref, ParameterDirection.Input);
                if (!String.IsNullOrEmpty(req_num))
                    cmdRegister.Parameters.Add("req_num", OracleDbType.Decimal, req_num, ParameterDirection.Input);
                else
                    cmdRegister.Parameters.Add("req_num", OracleDbType.Decimal, null, ParameterDirection.Input);
                cmdRegister.Parameters.Add("p_agrmntid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);

                cmdRegister.ExecuteNonQuery();

                agr_uid = Convert.ToString(cmdRegister.Parameters["p_agrmntid"].Value);
            }
            /// Додаткова угода про прийом на вклад зношених купюр
            else if (agr_id == 14)
            {
                /// Реєструємо додаткову угоду
                OracleCommand cmdRegister = connect.CreateCommand();
                cmdRegister.CommandText = "begin dpt_web.create_agreement " +
                " (:dpt_id,:agr_id,:init_cust_id,null, " +
                " null,null,null,null,null,null,null,null,null,null,:p_denomamount,null,:p_denomref,:p_comisref,null,:req_num, " +
                " :p_agrmntid " +
                " ); " +
                "end;";

                cmdRegister.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("init_cust_id", OracleDbType.Decimal, rnk_tr, ParameterDirection.Input);

                cmdRegister.Parameters.Add("p_denomamount", OracleDbType.Decimal, worn_sum, ParameterDirection.Input);

                if (!String.IsNullOrEmpty(doc_ref))
                {
                    cmdRegister.Parameters.Add("p_denomref", OracleDbType.Decimal, doc_ref, ParameterDirection.Input);
                    cmdRegister.Parameters.Add("p_comisref", OracleDbType.Decimal, doc_ref, ParameterDirection.Input);
                }
                else
                {
                    cmdRegister.Parameters.Add("p_denomref", OracleDbType.Decimal, null, ParameterDirection.Input);
                    cmdRegister.Parameters.Add("p_comisref", OracleDbType.Decimal, null, ParameterDirection.Input);
                }
                
                if (!String.IsNullOrEmpty(req_num))
                    cmdRegister.Parameters.Add("req_num", OracleDbType.Decimal, req_num, ParameterDirection.Input);
                else
                    cmdRegister.Parameters.Add("req_num", OracleDbType.Decimal, null, ParameterDirection.Input);
                
                cmdRegister.Parameters.Add("p_agrmntid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);

                cmdRegister.ExecuteNonQuery();

                agr_uid = Convert.ToString(cmdRegister.Parameters["p_agrmntid"].Value);
            }
            /// Додаткова угода про відміну автопролонгації
            else if (agr_id == 17)
            {
                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = "begin " +
                    " dpt_web.create_agreement " +
                    " (:dpt_id, :agr_id, :rnk_tr, " +
                    " null, null, null, null, null, null, null, null, null, " +
                    " null, null, null, null, null, null, null, null, :p_agrmntid " +
                    " ); " +
                    "end;";
                cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmd.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmd.Parameters.Add("rnk_tr", OracleDbType.Decimal, rnk_tr, ParameterDirection.Input);
                cmd.Parameters.Add("p_agrmntid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                agr_uid = Convert.ToString(cmd.Parameters["p_agrmntid"].Value);
            }
            /// Інші додаткові угоди (лише друк шаблону)
            else
            {
                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = "begin " +
                    " dpt_web.create_agreement " +
                    " (:dpt_id, :agr_id, :rnk_tr, " +
                    " null, null, null, null, null, null, null, null, null, " +
                    " null, null, null, null, null, null, null, null, :p_agrmntid, :p_templateid " +
                    " ); " +
                    "end;";
                cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmd.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmd.Parameters.Add("rnk_tr", OracleDbType.Decimal, rnk_tr, ParameterDirection.Input);
                cmd.Parameters.Add("p_agrmntid", OracleDbType.Decimal, agr_uid, ParameterDirection.Output);
                cmd.Parameters.Add("p_templateid", OracleDbType.Varchar2, t_id, ParameterDirection.Input);

                cmd.ExecuteNonQuery();

                agr_uid = Convert.ToString(cmd.Parameters["p_agrmntid"].Value);
            }

            Session["DPTPRINT_DPTID"] = dpt_id;
            Session["DPTPRINT_AGRID"] = textAgrId.Value;
            Session["DPTPRINT_TEMPLATE"] = template.Value;

            /// Формуємо текст дод. угоди (як параметр передаємо agr_uid)
            agr_num = dpt.WriteAddAgreement(agr_uid, null);

            textAgrNum.Value = agr_num.ToString();

            Session["DPTPRINT_AGRNUM"] = textAgrNum.Value;

            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = "select to_char(c.version,'dd/mm/yyyy') from cc_docs c " +
                "where c.id=:template and c.nd = :dpt_id and c.adds = :agr_num ";

            cmdSearch.Parameters.Add("template", OracleDbType.Varchar2, t_id, ParameterDirection.Input);
            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmdSearch.Parameters.Add("agr_num", OracleDbType.Decimal, agr_num, ParameterDirection.Input);

            String dt = Convert.ToString(cmdSearch.ExecuteScalar());
            dtDate.Date = Convert.ToDateTime(dt, cinfo);

            btPrint.Disabled = false;
            btForm.Enabled = false;
            dtBegin.Enabled = false;
            dtEnd.Enabled = false;

            if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
                btNextAgr.Visible = true;

            DBLogger.Info("Текст доп соглашения № " + agr_num +
                " по депозитному договору №" + dpt.ID + " успешно сформирован и записан в базу.",
                "deposit");
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
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btNextAgrSameType_Click(object sender, System.EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
        if (Request["agr_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

        Decimal dpt_id = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));

        Response.Redirect("DepositSelectTrustee.aspx?dpt_id=" + dpt_id + "&dest=agreement");
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
}
