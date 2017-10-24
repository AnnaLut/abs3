using System;
using System.IO;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using barsroot.cim;
using System.Web.Services;
using cim;
using System.Globalization;
using Bars.Classes;
using Control = System.Web.UI.Control;

public partial class cim_journals_default : System.Web.UI.Page
{
    #region Private Methods
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    private void SetJournalInfo()
    {
        //pnReport.Visible = rblJTypes.SelectedValue == "4";
        if (rblJTypes.SelectedValue == "1")
            pnJournalBlock.GroupingText = "Журнал реєстрації експортних операцій.";
        else if (rblJTypes.SelectedValue == "2")
            pnJournalBlock.GroupingText = "Журнал реєстрації імпортних операцій.";
        else if (rblJTypes.SelectedValue == "3")
            pnJournalBlock.GroupingText = "Журнал реєстрації експорту або імпорту послуг (робіт, прав інтелектуальної власності) на умовах попередньої оплати або попередньої поставки";
        else if (rblJTypes.SelectedValue == "4")
            pnJournalBlock.GroupingText = "Журнал реєстрації інших операцій";
        else
            pnJournalBlock.GroupingText = string.Empty;
    }
    #endregion


    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title, true);
        Master.AddScript("/barsroot/cim/journals/script/journal.js");
        //ScriptManager.GetCurrent(this).RegisterPostBackControl(btBuildReport);

        dsBranches.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsJournals.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        if (!IsPostBack)
        {
            CimManager cm = new CimManager(true);
            tbFinishDate.Text = cm.BankDate.Value.ToString("dd/MM/yyyy");
            tbStartDate.Text = cm.BankDate.Value.ToString("dd/MM/yyyy");
            Session[Constants.StateKeys.BranchMask] = cm.Branch;
            if (Session["cim_journal_num"] != null)
                rblJTypes.SelectedValue = Convert.ToString(Session["cim_journal_num"]);
            SetJournalInfo();
        }
    }

    protected void gvVCimJournal_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView objGridView = (GridView)sender;
            GridViewRow objgridviewrow = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell objtablecell = new TableCell();
            AddMergedCells(objgridviewrow, objtablecell, 1, "");
            AddMergedCells(objgridviewrow, objtablecell, 1, "");
            AddMergedCells(objgridviewrow, objtablecell, 1, "");
            AddMergedCells(objgridviewrow, objtablecell, 2, "Клієнт");
            AddMergedCells(objgridviewrow, objtablecell, 2, "Контрагент");
            AddMergedCells(objgridviewrow, objtablecell, 2, "Контракт");
            AddMergedCells(objgridviewrow, objtablecell, 1, "");
            AddMergedCells(objgridviewrow, objtablecell, 1, "");
            AddMergedCells(objgridviewrow, objtablecell, 3, "Платіж");
            AddMergedCells(objgridviewrow, objtablecell, 6, "Митна декларація (Акт)");
            AddMergedCells(objgridviewrow, objtablecell, 1, "");
            AddMergedCells(objgridviewrow, objtablecell, 1, "");

            objGridView.Controls[0].Controls.AddAt(0, objgridviewrow);
        }
    }

    protected void AddMergedCells(GridViewRow objgridviewrow, TableCell objtablecell, int colspan, string celltext)
    {
        objtablecell = new TableCell();
        objtablecell.Text = celltext;
        objtablecell.Font.Bold = true;
        objtablecell.ColumnSpan = colspan;

        if (colspan == 1)
        {
            objtablecell.Style.Add("border-right", "none");
        }
        else
        {
            objtablecell.Style.Add("border", "1px dotted black");
            objtablecell.CssClass = "ctrl-td";
        }
        objtablecell.HorizontalAlign = HorizontalAlign.Center;
        objgridviewrow.Cells.Add(objtablecell);
    }
    protected void gvVCimJournal_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            bool isDeleted = ((DataRowView)e.Row.DataItem).Row["DELETE_DATE"] != DBNull.Value;
            if (isDeleted)
            {
                e.Row.Cells[2].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[3].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[4].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[10].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[11].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[21].ForeColor = System.Drawing.Color.Red;
            }
        }
    }
    protected void rblJTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetJournalInfo();
        gvVCimJournal.DataBind();
        Session["cim_journal_num"] = rblJTypes.SelectedValue;
    }
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        gvVCimJournal.DataBind();
    }

    protected void btBuildReport_Click(object sender, EventArgs e)
    {

    }
    protected void ddJBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        string branch = Convert.ToString(ddJBranch.SelectedValue);
        Session[Constants.StateKeys.BranchMask] = branch;
        gvVCimJournal.DataBind();
    }
    [WebMethod(EnableSession = true)]
    public static string PrintReport(string date, string branch, string rb, string type)
    {
        string TemplateId = string.Format("journal{0}.frx", rb);
        //string DOCEXP_TYPE_ID = "RTF";
        FrxParameters pars = new FrxParameters();
        pars.Add(new FrxParameter("p_dat", TypeCode.String, date));
        pars.Add(new FrxParameter("p_branch", TypeCode.String, branch));
        string templatePath = Path.Combine(System.Web.HttpContext.Current.Server.MapPath("templates"), TemplateId);

        FrxDoc doc = new FrxDoc(templatePath, pars, null);
        if(type == "word")
            return doc.Export(FrxExportTypes.Word2007);
        return doc.Export(FrxExportTypes.Excel2007);
    }

    [WebMethod(EnableSession = true)]
    public static void DeleteJournalRecord(decimal docKind, decimal docType, decimal boundId)
    {
        CimManager cm = new CimManager(false);
        cm.DeleteJournalRecord(docKind, docType, boundId);
    }

    [WebMethod(EnableSession = true)]
    public static void EnumJournal()
    {
        CimManager cm = new CimManager(false);
        cm.EnumJournal();
    }

    [WebMethod(EnableSession = true)]
    public static void UpdateComment(string comment, decimal docKind, decimal docType, decimal boundId, string level)
    {
        CimManager cm = new CimManager(false);
        cm.UpdateComment(comment, docKind, docType, boundId, level);
    }
    
}