using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Oracle;
using Bars.Classes;
using Bars.Web.Controls;
using System.Globalization;

enum CurrentModes {Edit, Visa}
public partial class SetCurRatesBase : Bars.BarsPage
{
    private const string roleName = "WR_RATES";
    DateTimeFormatInfo dateFormat;
    private string isShowArchive
    {
        get { return Request.QueryString["archive"] == null ? "0" : Request.QueryString["archive"].ToString(); }
    }
    private CurrentModes currentMode
    {
        get { return Request["mode"] == "1" ? CurrentModes.Edit : CurrentModes.Visa; }
    }
    protected override void OnInit(EventArgs e)
    {
        //иногда бывают невн€тные глюки с BarsGridView, лечатс€ путем присвоени€
        //строки соединени€ в этом событии
        ds.PreliminaryStatement = String.Format("begin bars_role_auth.set_role('{0}'); end;", roleName);
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {   
        //неверные параметры запуска функции
        if (null == Request["mode"]) 
            throw new ArgumentException(msg5.Text); 

        //формат даты по-умолчанию
        dateFormat = new DateTimeFormatInfo();
        dateFormat.ShortDatePattern = "dd.MM.yyyy";
        dateFormat.DateSeparator = ".";
        //строка соединени€ и внешний вид
        dsArch.PreliminaryStatement = ds.PreliminaryStatement;
        dsArch.ConnectionString = ds.ConnectionString;
        dsBranch.PreliminaryStatement = ds.PreliminaryStatement;
        dsBranch.ConnectionString = ds.ConnectionString;
        gv.Columns[7].Visible = currentMode == CurrentModes.Edit;
        gv.Columns[0].Visible = currentMode == CurrentModes.Visa;
        lblHeader.Text = currentMode == CurrentModes.Edit ? msg6.Text : msg7.Text;
    }

    protected override void OnPreRender(EventArgs e)
    {
        gvArch.Visible = isShowArchive == "1" && !(currentMode == CurrentModes.Visa);
        lblArch.Visible = gvArch.Visible;
        itbArchive.Visible = currentMode == CurrentModes.Edit;
        itbArchive.Text = gvArch.Visible ? msg2.Text/*"—крыть архив"*/ : msg1.Text/*"ѕоказать архив"*/;
        hrArch.Visible = gvArch.Visible;
        base.OnPreRender(e);
    }
    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        gv.DataBind();
    }
    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (currentMode==CurrentModes.Edit) return;
        int index = Convert.ToInt32(e.CommandArgument);
        GridViewRow row = gv.Rows[index];
        InitOraConnection();
        try
        {
            SQL_NONQUERY("begin bars_role_auth.set_role('"+roleName+"'); end;");
            ClearParameters();
            SetParameters("p_kv", DB_TYPE.Decimal, Convert.ToInt32(row.Cells[1].Text), DIRECTION.Input);
            SetParameters("p_vdate", DB_TYPE.Date, Convert.ToDateTime(row.Cells[2].Text, dateFormat), DIRECTION.Input);
            SetParameters("p_branch", DB_TYPE.Varchar2, ddlBranch.SelectedValue, DIRECTION.Input);
            SetParameters("p_otm", DB_TYPE.Char, e.CommandName == "Visa" ? "Y" : "N", DIRECTION.Input);
            SQL_NONQUERY("begin bars_cur_rates.set_visa(:p_kv, :p_vdate, :p_branch, :p_otm); end;");
        }
        finally
        {
            DisposeOraConnection();
        }
        gv.DataBind();
    }
    protected void gv_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && currentMode == CurrentModes.Visa)
        {
            // Retrieve the Button control from the first column.
            ImageTextButton visaButton = (ImageTextButton)e.Row.Cells[0].Controls[1];
            ImageTextButton visaStornoButton = (ImageTextButton)e.Row.Cells[0].Controls[3];

            visaButton.OnClientClick = "if (!confirm('"+msg3.Text+"')) return false;";
            visaStornoButton.OnClientClick = "if (!confirm('" + msg4.Text + "')) return false;";

            // Set the Button's CommandArgument property with the
            // row's index.
            visaButton.CommandArgument = e.Row.RowIndex.ToString();
            visaStornoButton.CommandArgument = e.Row.RowIndex.ToString();
        }
    }
    protected void itbVisa_Click(object sender, EventArgs e)
    {

    }
}
