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
/// Summary description for DepositAgreementTemplate.
/// </summary>
public partial class DepositAgreementTemplate : Bars.BarsPage
{
    protected System.Data.DataSet dsTemplate;
    private OracleDataAdapter adapterSearchAgreement;
    private int row_counter = 0;
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositAgreementTemplate;
        OracleConnection connect = new OracleConnection();

        try
        {
            if (Request["dpt_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
            if (Request["agr_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

            Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
            Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);

            hid_agr_id.Value = Convert.ToString(Request["agr_id"]);

            text_dpt_num.Text = Convert.ToString(Session["DPT_NUM"]);
            text_agr_id.Text = Convert.ToString(Request["name"]);

            DBLogger.Info("Выбор шаблона для доп. соглашения тип=" + agr_id + 
                " по договору №" + dpt_id, "deposit");

            RegisterClientScript();

            btForm.Attributes["onclick"] = "javascript:if (tmpl_ck()&&openOPDialog())";

            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = "select rnk from dpt_deposit where deposit_id = :dpt_id";
            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            rnk.Value = Convert.ToString(cmdSearch.ExecuteScalar());

            cmdSearch.Parameters.Clear();

            cmdSearch.CommandText = "select v.id as id,name from dpt_vidd_scheme v, doc_scheme s, dpt_deposit d " +
                "where v.id=s.id  and d.deposit_id = :dpt_id and d.vidd = v.vidd and v.flags = :agr_id"; ;
            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmdSearch.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);

            adapterSearchAgreement = new OracleDataAdapter();
            adapterSearchAgreement.SelectCommand = cmdSearch;
            adapterSearchAgreement.Fill(dsTemplate);

            gridTemplate.DataSource = dsTemplate;
            gridTemplate.DataBind();

            /// agr_id == 14 - для цієї дод. угоди потрібно вказати суму
            if (dsTemplate.Tables[0].Rows.Count == 1 && (agr_id != 2 && agr_id != 14))
            {
                Template_id.Value = dsTemplate.Tables[0].Rows[0].ItemArray[0].ToString();
                btForm_ServerClick(sender, e);
            }

            gridTemplate.HeaderStyle.BackColor = Color.Gray;
            gridTemplate.HeaderStyle.Font.Bold = true;
            gridTemplate.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Локализация грида
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем грид
        if (gridTemplate.Controls.Count > 0)
        {
            Table tb = gridTemplate.Controls[0] as Table;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb69;
        }
    }
    /// <summary>
    /// Клієнтський скріпт, який
    /// при виборі рядка таблиці
    /// виділяє його кольором
    /// </summary>
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
			function S(id,val)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('Template_id').value = val;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script", script);
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
        this.dsTemplate = new System.Data.DataSet();
        ((System.ComponentModel.ISupportInitialize)(this.dsTemplate)).BeginInit();
        this.gridTemplate.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridTemplate_ItemDataBound);
        this.btForm.ServerClick += new System.EventHandler(this.btForm_ServerClick);
        // 
        // dsTemplate
        // 
        this.dsTemplate.DataSetName = "NewDataSet";
        this.dsTemplate.Locale = new System.Globalization.CultureInfo("uk-UA");
        ;
        ((System.ComponentModel.ISupportInitialize)(this.dsTemplate)).EndInit();

    }
    #endregion
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void gridTemplate_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            DataGridItem row = e.Item;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S('" + row_counter + "','" + row.Cells[0].Text + "')");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btForm_ServerClick(object sender, System.EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

        if (Request["agr_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

        Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
        Int32 agr_id = Convert.ToInt32(Request["agr_id"]);
        String template_id = Convert.ToString(Template_id.Value);
        String destination = String.Empty;

        DBLogger.Info("Пользователь выбрал шаблон " + template_id + " для доп. соглашения тип=" + agr_id +
            " по договору №" + dpt_id, "deposit");

        switch (agr_id)
        {
            /// Зміна суми вкладу
            case 2:
                {
                    /// Поповнення
                    if (OP.Value == "1")
                        destination = ("DepositAddSum.aspx?next=print&dpt_id=" + dpt_id.ToString());

                    /// Часткове зняття
                    if (OP.Value == "2")
                        destination = ("DepositSelectTT.aspx?dest=close&next=print&dpt_id=" + dpt_id.ToString());

                    break;
                }
            case 3:  // Відсоткова ставка
            case 4:  // Строк вкладу (ДУ на пролонгацію для ОБ)
                {
                    destination = ("DepositTermRateEdit.aspx?next=print&dpt_id=" + dpt_id.ToString());
                    break;
                }
            /// Про права бенефіціара
            case 5:
                {
                    destination = ("DepositClient.aspx?next=print&dpt_id=" + dpt_id.ToString());
                    break;
                }
            /// Про відміну прав бенефіціара
            case 6:
                {
                    destination = ("DepositCancelAgreement.aspx?next=print&dpt_id=" + dpt_id.ToString());
                    break;
                }
            /// Про вступ бенефіціара в права
            case 7:
                {
                    destination = ("DepositAgreementBeneficiary.aspx?dpt_id=" + dpt_id.ToString());
                    break;
                }
            /// Про заповідане розпорядження
            case 8:
                {
                    destination = ("DepositClient.aspx?next=print&dpt_id=" + dpt_id.ToString());
                    break;
                }
            /// Про відміну заповіданого розпорядження
            case 9:
                {
                    destination = ("DepositCancelAgreement.aspx?next=print&dpt_id=" + dpt_id.ToString());
                    break;
                }
            case 10:  // Про перечислення вкладу і нарахованих відсотків
            case 11:  // Про перерахування відсотків по вкладу на картковий рахунок
                {
                    destination = ("DepositEditAccount.aspx?next=print&dpt_id=" + dpt_id.ToString());
                    break;
                }
            /// Дополнительное соглашение о доверенности
            case 12:
                {
                    destination = ("DepositClient.aspx?next=print&dpt_id=" + dpt_id.ToString());
                    break;
                }
            /// Дополнительное соглашение об отмене доверенности
            case 13:
                {
                    destination = ("DepositCancelAgreement.aspx?next=print&dpt_id=" + dpt_id.ToString());
                    break;
                }
            /// Додаткова угода про прийом на вклад зношених купюр
            case 14:
                {
                    destination = ("/barsroot/deposit/DepositAgreementPrint.aspx?dpt_id=" + dpt_id.ToString() +
                        "&worn_sum=" + WORNSUM.Value);
                    TreatWornBillsAgreement();
                    break;
                }
            // ДУ про зміну періодичності сплати процентів
            case 19:
                {
                    destination = ("DepositChangeFrequency.aspx?dpt_id=" + dpt_id.ToString());
                    break;
                }
            // ДУ які не потребують додаткового введення (лише друк)
            default:
                {
                    destination = ("/barsroot/deposit/DepositAgreementPrint.aspx?dpt_id=" + dpt_id.ToString());
                    break;
                }
        }

        destination += "&agr_id=" + agr_id.ToString();

        destination += "&template=" + template_id;

        if (Request["rnk_tr"] != null)
            destination += "&rnk_tr=" + Request.QueryString["rnk_tr"];
        else
            destination += "&rnk_tr=" + rnk.Value;

        if (Request.QueryString["other"] == "Y")
            destination += "&other=Y";

        destination = String.Format("location.replace('{0}'); ", destination);

        ScriptManager.RegisterStartupScript(this, this.GetType(), "destination", destination, true);

    }
    private void TreatWornBillsAgreement()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);
            Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);

            String dest = "DepositAgreementPrint.aspx?dpt_id="
                + Convert.ToString(dpt_id) + "&agr_id=" + Convert.ToString(agr_id) +
                "&template=" + Convert.ToString(Template_id.Value) +
                "&rnk_tr=" + (Request["rnk_tr"] == null ? rnk.Value : Convert.ToString(Request["rnk_tr"])) +
                "&worn_sum=" + WORNSUM.Value;

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "select nvl(main_tt,'') from dpt_vidd_flags where id=:agr_id";
            cmd.Parameters.Add("agr_id", OracleDbType.Decimal, Convert.ToDecimal(agr_id), ParameterDirection.Input);

            String TT = Convert.ToString(cmd.ExecuteScalar());

            if (TT != String.Empty && String.IsNullOrEmpty(Convert.ToString(Session["NO_COMISSION"])))
            {
                Decimal cl_id;
                Deposit dpt_dop = new Deposit(dpt_id);

                if (Request["rnk_tr"] != null)
                    cl_id = Convert.ToDecimal(Convert.ToString(Request["rnk_tr"]));
                else
                    cl_id = dpt_dop.Client.ID;

                Random r = new Random();
                String dop_rec = "&RNK=" + Convert.ToString(cl_id) +
                    "&Code=" + Convert.ToString(r.Next());

                string url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + TT + "&nd=" +
                    Convert.ToString(dpt_id) + "&SumC_t=1&SMAIN=" + WORNSUM.Value +
                    "&KVMAIN=" + dpt_dop.Currency + "&APROC=" +
                    OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                    "@" + "begin dpt_web.fill_dpt_payments(" + dpt_id + ",:REF);end;";

                string script = "<script>window.showModalDialog(encodeURI(" + url + dop_rec + "\"" + "),null," +
                    "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";

                script += "location.replace('" + dest + "');";

                script += "</script>";
                Response.Write(script);
                Response.Flush();
                return;
            }
            else
            {
                String script = "<script>location.replace('" + dest + "');";

                script += "</script>";
                Response.Write(script);
                Response.Flush();
                return;
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
