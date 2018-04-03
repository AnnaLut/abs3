using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Collections.Generic;
using Oracle.DataAccess.Types;
using Bars.Classes;
using ibank.core;
using credit;

public enum DialogMode
{
    Question,
    Macros
}

public partial class credit_constructor_dialogs_wcsquestions : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    public String SUBPRODUCT_ID
    {
        get
        {
            return Request.Params.Get("subproduct_id");
        }
    }
    public DialogMode Mode
    {
        get
        {
            return Request.Params.Get("mode") == "question" ? DialogMode.Question : DialogMode.Macros;
        }
    }
    public List<String> SECTIONS
    {
        get
        {
            List<String> _sections = new List<String>();
            _sections.Add("SCANCOPIES");
            _sections.Add("AUTHS");
            _sections.Add("SURVEYS");
            _sections.Add("CREDITDATAS");
            _sections.Add("GARANTEES");
            _sections.Add("INSURANCES");
            _sections.Add("INFOQUERIES");
            _sections.Add("SOLVENCIES");
            _sections.Add("SCORINGS");
            _sections.Add("STOPS");
            _sections.Add("TEMPLATES");

            if (!String.IsNullOrEmpty(Request.Params.Get("sections")))
            {
                String url_sections = Request.Params.Get("sections");
                String sign = url_sections.Substring(0, 4); // "inc:" - включая, "exc:" - исключая
                Trace.Write("url_sections = " + url_sections);

                if (sign == "inc:")
                {
                    _sections = new List<String>();
                    foreach (String str in url_sections.Substring(4).Split(','))
                        _sections.Add(str.ToUpper());
                }
                else
                {

                    foreach (String str in url_sections.Substring(4).Split(','))
                        _sections.Remove(str.ToUpper());
                }
            }

            return _sections;
        }
    }
    public String TYPES
    {
        get
        {
            /*List<String> _types = new List<String>();

            if (!String.IsNullOrEmpty(Request.Params.Get("types")))
            {
                String url_sections = Request.Params.Get("types");
                foreach (String str in url_sections.Split(','))
                    _types.Add(str.ToUpper());
            }

            return _types;*/
            return Request.Params.Get("types");
        }
    }

    # endregion

    # region Приватные методы
    private TreeNode GetNodeByValue(TreeNode Parent, String NodeValue)
    {
        foreach (TreeNode tn in Parent.ChildNodes)
            if (tn.Value.ToUpper() == NodeValue.ToUpper())
                return tn;
        return null;
    }
    private void InitSections()
    {
        TreeNode tnRoot = tv.Nodes[0];

        // 0 - Сканкопии
        if (SECTIONS.Contains("SCANCOPIES"))
        {
            TreeNode tnSection = new TreeNode("Сканкопии", "SCANCOPIES");
            tnSection.Checked = true;
            tnSection.Expanded = false;


            List<VWcsScancopiesRecord> Scancopies = (new VWcsScancopies()).Select();
            foreach (VWcsScancopiesRecord Scancopy in Scancopies)
            {
                TreeNode tn = new TreeNode(Scancopy.SCOPY_NAME, Scancopy.SCOPY_ID);
                tn.Checked = true;

                tnSection.ChildNodes.Add(tn);
            }

            tnRoot.ChildNodes.Add(tnSection);
        }

        // 1 - Авторизация
        if (SECTIONS.Contains("AUTHS"))
        {
            TreeNode tnSection = new TreeNode("Авторизация", "AUTHS");
            tnSection.Checked = true;
            tnSection.Expanded = false;

            List<VWcsAuthorizationsRecord> Auths = (new VWcsAuthorizations()).Select();
            foreach (VWcsAuthorizationsRecord Auth in Auths)
            {
                TreeNode tn = new TreeNode(Auth.AUTH_NAME, Auth.AUTH_ID);
                tn.Checked = true;

                tnSection.ChildNodes.Add(tn);
            }

            tnRoot.ChildNodes.Add(tnSection);
        }

        // 2 - Анкета
        if (SECTIONS.Contains("SURVEYS"))
        {
            TreeNode tnSection = new TreeNode("Анкета", "SURVEYS");
            tnSection.Checked = true;
            tnSection.Expanded = false;

            List<VWcsSurveysRecord> Surveys = (new VWcsSurveys()).Select();
            foreach (VWcsSurveysRecord Survey in Surveys)
            {
                TreeNode tn = new TreeNode(Survey.SURVEY_NAME, Survey.SURVEY_ID);
                tn.Checked = true;

                tnSection.ChildNodes.Add(tn);
            }

            tnRoot.ChildNodes.Add(tnSection);
        }

        // 3 - Данные кредита
        if (SECTIONS.Contains("CREDITDATAS"))
        {
            TreeNode tnSection = new TreeNode("Данные кредита", "CREDITDATAS");
            tnSection.Checked = true;
            tnSection.Expanded = false;

            List<VWcsSubproductsRecord> Infoqueries = (new VWcsSubproducts()).Select();
            foreach (VWcsSubproductsRecord Infoquery in Infoqueries)
            {
                TreeNode tn = new TreeNode(Infoquery.SUBPRODUCT_NAME, Infoquery.SUBPRODUCT_ID);
                tn.Checked = true;

                tnSection.ChildNodes.Add(tn);
            }

            tnRoot.ChildNodes.Add(tnSection);
        }
        // !!! 4 - Обеспечение
        // !!! 5 - Страховки заемщика

        // 6 - Информационные запросы
        if (SECTIONS.Contains("INFOQUERIES"))
        {
            TreeNode tnSection = new TreeNode("Информ. запросы", "INFOQUERIES");
            tnSection.Checked = true;
            tnSection.Expanded = false;

            List<VWcsSubproductsRecord> Infoqueries = (new VWcsSubproducts()).Select();
            foreach (VWcsSubproductsRecord Infoquery in Infoqueries)
            {
                TreeNode tn = new TreeNode(Infoquery.SUBPRODUCT_NAME, Infoquery.SUBPRODUCT_ID);
                tn.Checked = true;

                tnSection.ChildNodes.Add(tn);
            }

            tnRoot.ChildNodes.Add(tnSection);
        }

        // 7- Кредитоспособность
        if (SECTIONS.Contains("SOLVENCIES"))
        {
            TreeNode tnSection = new TreeNode("Кредитоспособность", "SOLVENCIES");
            tnSection.Checked = true;
            tnSection.Expanded = false;

            List<VWcsSolvenciesRecord> Solvencies = (new VWcsSolvencies()).Select();
            foreach (VWcsSolvenciesRecord Solvency in Solvencies)
            {
                TreeNode tn = new TreeNode(Solvency.SOLV_NAME, Solvency.SOLV_ID);
                tn.Checked = true;

                tnSection.ChildNodes.Add(tn);
            }

            tnRoot.ChildNodes.Add(tnSection);
        }

        // 8 - Скоринг
        if (SECTIONS.Contains("SCORINGS"))
        {
            TreeNode tnSection = new TreeNode("Скоринг", "SCORINGS");
            tnSection.Checked = true;
            tnSection.Expanded = false;

            List<VWcsScoringsRecord> Scorings = (new VWcsScorings()).Select();
            foreach (VWcsScoringsRecord Scoring in Scorings)
            {
                TreeNode tn = new TreeNode(Scoring.SCORING_NAME, Scoring.SCORING_ID);
                tn.Checked = true;

                tnSection.ChildNodes.Add(tn);
            }

            tnRoot.ChildNodes.Add(tnSection);
        }

        // 9 - Стоп-фатори/правила
        if (SECTIONS.Contains("STOPS"))
        {
            TreeNode tnSection = new TreeNode("Стоп-фатори/правила", "STOPS");
            tnSection.Checked = true;
            tnSection.Expanded = false;

            List<VWcsSubproductsRecord> Stops = (new VWcsSubproducts()).Select();
            foreach (VWcsSubproductsRecord Stop in Stops)
            {
                TreeNode tn = new TreeNode(Stop.SUBPRODUCT_NAME, Stop.SUBPRODUCT_ID);
                tn.Checked = true;

                tnSection.ChildNodes.Add(tn);
            }

            tnRoot.ChildNodes.Add(tnSection);
        }

        // !!! 10 - Шаблони
    }
    private void InitTypes()
    {
        TreeNode tnRoot = tvTypes.Nodes[0];

        List<WcsQuestionTypesRecord> Types = (new WcsQuestionTypes()).SelectTypes(TYPES);
        foreach (WcsQuestionTypesRecord Type in Types)
        {
            TreeNode tn = new TreeNode(Type.NAME, Type.ID);
            tn.Checked = true;

            tnRoot.ChildNodes.Add(tn);
        }
    }
    private void InitParams()
    {
        TreeNode tnSection = new TreeNode("Данные кредита", "CREDITDATAS");
        tnSection.Checked = true;
        tnSection.Expanded = false;

        List<WcsCreditdataBaseRecord> lst = (new WcsCreditdataBase()).SelectCreditdataBase();
        foreach (WcsCreditdataBaseRecord rec in lst)
        {
            TreeNode tn = new TreeNode(rec.NAME, rec.ID);
            tn.Checked = true;

            tnSection.ChildNodes.Add(tn);
        }

        tvParams.Nodes.Add(tnSection);

        // Параметры не показываем в режиме выбора вопросов
        switch (Mode)
        {
            case DialogMode.Macros:
                tvParams.Visible = true;
                break;
            case DialogMode.Question:
                tvParams.Visible = false;
                break;
        }
    }
    private String MakeSelectStmt()
    {
        String Res = "select * from v_wcs_questions q where (1=1)";

        // фильтрация по типу
        String TypesStmt = String.Empty;
        if (tvTypes.Nodes[0].Checked)
        {
            foreach (TreeNode tn in tvTypes.Nodes[0].ChildNodes)
                if (tn.Checked)
                    TypesStmt += "'" + tn.Value + "', ";

            if (!String.IsNullOrEmpty(TypesStmt))
                Res += " and q.type_id in (" + TypesStmt.Substring(0, TypesStmt.Length - 2) + ")";
        }
        else
            Res += " and q.type_id in ('NONE')";

        // фильтрация по секциям
        if (tv.Nodes[0].Checked)
        {
            Res += " and ((0=1) ";

            // 0 - Сканкопии
            if (GetNodeByValue(tv.Nodes[0], "SCANCOPIES") != null && GetNodeByValue(tv.Nodes[0], "SCANCOPIES").Checked)
            {
                Res += " or q.id in (select sq.question_id from v_wcs_scancopy_questions sq where sq.scopy_id in ('NONE'";
                foreach (TreeNode tn in GetNodeByValue(tv.Nodes[0], "SCANCOPIES").ChildNodes)
                    if (tn.Checked)
                        Res += ", '" + tn.Value + "'";
                Res += "))";
            }

            // 1 - Авторизация
            if (GetNodeByValue(tv.Nodes[0], "AUTHS") != null && GetNodeByValue(tv.Nodes[0], "AUTHS").Checked)
            {
                Res += " or q.id in (select aq.question_id from v_wcs_authorization_questions aq where aq.auth_id in ('NONE'";
                foreach (TreeNode tn in GetNodeByValue(tv.Nodes[0], "AUTHS").ChildNodes)
                    if (tn.Checked)
                        Res += ", '" + tn.Value + "'";
                Res += "))";
            }

            // 2 - Анкета
            if (GetNodeByValue(tv.Nodes[0], "SURVEYS") != null && GetNodeByValue(tv.Nodes[0], "SURVEYS").Checked)
            {
                Res += " or q.id in (select sgq.question_id from v_wcs_survey_group_questions sgq where sgq.survey_id in ('NONE'";
                foreach (TreeNode tn in GetNodeByValue(tv.Nodes[0], "SURVEYS").ChildNodes)
                    if (tn.Checked)
                        Res += ", '" + tn.Value + "'";
                Res += "))";
            }

            // 3 - Данные кредита
            if (GetNodeByValue(tv.Nodes[0], "CREDITDATAS") != null && GetNodeByValue(tv.Nodes[0], "CREDITDATAS").Checked)
            {
                Res += " or q.id in (select scd.question_id from v_wcs_subproduct_creditdata scd where scd.subproduct_id in ('NONE'";
                foreach (TreeNode tn in GetNodeByValue(tv.Nodes[0], "CREDITDATAS").ChildNodes)
                    if (tn.Checked)
                        Res += ", '" + tn.Value + "'";
                Res += "))";
            }

            // 7- Кредитоспособность
            if (GetNodeByValue(tv.Nodes[0], "SOLVENCIES") != null && GetNodeByValue(tv.Nodes[0], "SOLVENCIES").Checked)
            {
                Res += " or q.id in (select sq.question_id from v_wcs_solvency_questions sq where sq.solvency_id in ('NONE'";
                foreach (TreeNode tn in GetNodeByValue(tv.Nodes[0], "SOLVENCIES").ChildNodes)
                    if (tn.Checked)
                        Res += ", '" + tn.Value + "'";
                Res += "))";
            }

            Res += ")";
        }

        Trace.Write("Res = " + Res);

        return Res;
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        sds.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();

        if (!IsPostBack)
        {
            InitSections();
            InitTypes();
            InitParams();
        }

        sds.SelectCommand = MakeSelectStmt();
    }
    protected void tv_TreeNodeCheckChanged(object sender, TreeNodeEventArgs e)
    {
        Trace.Write("tv_TreeNodeCheckChanged: " + e.Node.Checked);
        foreach (TreeNode tn in e.Node.ChildNodes)
        {
            tn.Checked = e.Node.Checked;
            tv_TreeNodeCheckChanged(sender, new TreeNodeEventArgs(tn));
        }
        
        gv.DataBind();
    }
    protected void tvParams_SelectedNodeChanged(object sender, EventArgs e)
    {
        if (tvParams.SelectedNode != null)
        {
            switch (tvParams.SelectedNode.Parent.Value)
            {
                case "CREDITDATAS":
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "CloseDialog(':#" + tvParams.SelectedNode.Value + "%T-CD#');", true);
                    break;
                case "CONSTS":
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "CloseDialog(':#" + tvParams.SelectedNode.Value + "%T-K#');", true);
                    break;
            }
        }

        gv.DataBind();
    }
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl is Control && (sourceControl as Control).ID == "gv" && eventArgument.StartsWith("rc"))
        {
            Int32 rowIndex = Convert.ToInt32(eventArgument.Substring(3));
            String ID = (String)gv.DataKeys[rowIndex]["ID"];

            switch (Mode)
            {
                case DialogMode.Question:
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "CloseDialog('" + ID + "');", true);
                    break;
                case DialogMode.Macros:
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "CloseDialog(':#" + ID + "#');", true);
                    break;
            }
        }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    # endregion
}