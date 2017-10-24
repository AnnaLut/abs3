using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Requests;

public partial class deposit_DptTemplates : System.Web.UI.Page
{
    # region variables
    // Депозитний договір
    private Int64 dpt_id
    {
        get
        {
            return Convert.ToInt64(ViewState["dpt_id"]);
        }
        set
        {
            ViewState["dpt_id"] = value;
        }
    }

    // РНК власника дог.
    private Int64? rnk
    {
        get
        {
            if (Session["DepositInfo"] == null)
                return null;
            else
                return Convert.ToInt64((Session["DepositInfo"] as Deposit).Client.ID);
        }
    }

    // РНК довіреної особи
    private Int64? rnk_tr
    {
        get
        {
            if (Request["rnk_tr"] == null)
                return null;
            else
                return Convert.ToInt64(Request["rnk_tr"]);
        }
    }

    // РНК спадкоємця
    private Decimal? rnk_heir
    {
        get
        {
            if (Request["inherit_id"] == null)
                return null;
            else
                return Convert.ToDecimal(Request["inherit_id"]);
        }
    }
    # endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["dpt_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
            else
            {
                dpt_id = Convert.ToInt64(Request["dpt_id"]);
            }
        }


        // Доступ до власного / довіреного депозиту
        Int64 cust_id = (rnk_tr.HasValue ? rnk_tr.Value : rnk.Value);

        if ((ClientAccessRights.Get_AccessLevel(cust_id) == LevelState.Limited) &&
            (DepositRequest.HasActive(cust_id, dpt_id) == false) &&
            (Tools.get_EADocID(Convert.ToDecimal(dpt_id)) >= 0))
        {
            // деактивуємо кнопки друку фінан. інформ. по депозиту
            btnRow1_PRINT.Enabled = false;
            btnRow1_PRINT.ToolTip = "Не достатньо прав для формування виписки";

            eadAccountStatus.Enabled = false;
        }
    }

    protected void btnPrintTemplates_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton btn = (sender as ImageButton);

        String Template = "EMPTY_TEMPLATE";

        Deposit dpt = (Deposit)Session["DepositInfo"];

        // Виписка
        if (btn.ID == "btnRow1_PRINT")
        {
            // Template = "DPT_ACCOUNT_STATEMENT";

            if (dpt.Currency == 980)
                Response.Redirect("/barsroot/cbirep/rep_query.aspx?repid=701&codeapp=WDPT&Param0=" + dpt_id.ToString());
            else
                Response.Redirect("/barsroot/cbirep/rep_query.aspx?repid=702&codeapp=WDPT&Param0=" + dpt_id.ToString());
        }

        // Друк
        FrxParameters pars = new FrxParameters();
        pars.Add(new FrxParameter("p_dpt_id", TypeCode.Int64, dpt_id));
        pars.Add(new FrxParameter("p_rnk", TypeCode.Int64, Convert.ToInt64(dpt.Client.ID)));

        FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(Template)), pars, this.Page);

        // выбрасываем в поток в формате PDF
        doc.Print(FrxExportTypes.Pdf);
    }

    // Повернутися на картку договору
    protected void btnBack_Click(object sender, EventArgs e)
    {
        String url = "DepositContractInfo.aspx?dpt_id=" + dpt_id.ToString() + "&scheme=DELOITTE";

        // Довірена особа
        if (rnk_tr.HasValue)
            url = url + "&rnk_tr=" + rnk_tr.ToString();

        // Спадкоємець
        if (rnk_heir.HasValue)
            url = url + "&inherit_id=" + rnk_heir.ToString();

        Response.Redirect(url);
    }

    protected void btnPrintTemplates_DocSigned(object sender, EventArgs e)
    {

    }
    protected void eadFinmonQuestionnaire_BeforePrint(object sender, EventArgs e)
    {
        // Опитувальний лист фінмоніторингу
        //eadFinmonQuestionnaire.TemplateID = "DPT_FINMON_QUESTIONNAIRE";
        //eadFinmonQuestionnaire.RNK = rnk.Value;
        //eadFinmonQuestionnaire.AgrID = dpt_id;
    }

    // Попереднє присвоєння реквізитів компоненті перед друком
    protected void eadAccountStatus_BeforePrint(object sender, EventArgs e)
    {
        // Довідка про стан рахунку
        eadAccountStatus.TemplateID = "DPT_ACCOUNT_STATUS";
        eadAccountStatus.RNK = rnk.Value;
        eadAccountStatus.AgrID = dpt_id;
    }
}