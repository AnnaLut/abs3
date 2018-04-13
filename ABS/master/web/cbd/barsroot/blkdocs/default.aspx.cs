using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Bars.Oracle;
using Bars.Classes;

public partial class blkdocs_Default : Bars.BarsPage
{
    private string roleName = "WR_BLKDOCS";
    protected override void OnInit(EventArgs e)
    {
        ds.PreliminaryStatement = String.Format("set role {0}", roleName);
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        itbStorno.OnClientClick = "if (!isRowChecked()){alert('" + lblMsg3.Text + "');return false;}";
        itbUnblock.OnClientClick = "if (!isRowChecked()){alert('" + lblMsg3.Text + "');return false;}";
        itbStorno.OnClientClick += "if (!confirm('"+lblMsg2.Text+"?'))return false;";
        itbUnblock.OnClientClick += "if (!confirm('" + lblMsg1.Text + "?'))return false;";

    }
    protected void gv_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chk = (CheckBox)e.Row.FindControl("chkSelect");
            if (chk != null)
            {
                chk.Attributes.Add("onclick", "SelectRow()");
            }
            e.Row.Attributes.Add("onclick", "SelectRow()");
        }
    }
    protected void itbRefresh_Click(object sender, EventArgs e)
    {
        gv.DataBind();
    }
    protected void itbUnblock_Command(object sender, CommandEventArgs e)
    {
        decimal docRef = 0;

        #region Получениe референса из GridView
        foreach (GridViewRow gr in gv.Rows)
        {
            CheckBox chk = (CheckBox)gr.FindControl("chkSelect");
            if (chk == null) continue;
            if (!chk.Checked) continue;
            docRef = Convert.ToDecimal(gv.DataKeys[gr.RowIndex]["ref"].ToString());
            break;
        }
        #endregion

        string procName = String.Empty;

        #region Определение процедуры обработки
        switch (e.CommandName)
        {                                                                                                                                                                                                                                                    
            case "DocUnBlock":
                procName = "unblock";
                break;
            case "DocStorno":
                procName = "back_doc";
                break;
        }
        #endregion Определение процедуры обработки

        InitOraConnection();
        try
        {
            SetRole(roleName);
            ClearParameters();
            SetParameters("p_ref", DB_TYPE.Decimal, docRef, DIRECTION.Input);
            SQL_NONQUERY(String.Format("begin bars_blkdocs.{0}(:p_ref); end;",procName));
            gv.DataBind();
        }
        finally
        {
            DisposeOraConnection();
        }
    }
}
