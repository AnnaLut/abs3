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
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

public partial class admin_CreateNotice : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        gvBoards.EnableViewState = true;
    }
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        sdsBoards.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_BOARD");
        sdsBoards.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void gvBoards_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void gvBoards_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        sdsBoards.UpdateParameters.Clear();
        Parameter p2 = new Parameter(
            "msg_title", TypeCode.String, 
            null == e.NewValues[0] ? null : e.NewValues[0].ToString());
        p2.Size = 500;
        sdsBoards.UpdateParameters.Add(p2);

        Parameter p3 = new Parameter(
            "msg_text", TypeCode.String, 
            null == e.NewValues[0] ? null : e.NewValues[1].ToString());
        p3.Size = 10240;
        sdsBoards.UpdateParameters.Add(p3);

        Parameter p1 = new Parameter("id", TypeCode.String, e.Keys[0].ToString());
        sdsBoards.UpdateParameters.Add(p1);

    }
    protected void gvBoards_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        sdsBoards.DeleteParameters.Clear();
        Parameter p1 = new Parameter("id", TypeCode.String, gvBoards.DataKeys[e.RowIndex].Value.ToString());
        sdsBoards.DeleteParameters.Add(p1);
    }
    protected void btnNew_Click(object sender, EventArgs e)
    {
        
        if (String.IsNullOrEmpty(tbTitle.Text) || String.IsNullOrEmpty(tbText.Text))
            return;

        InitOraConnection();
        try
        {
            SetRole("WR_BOARD");
            ClearParameters();
            SetParameters("msg_title", DB_TYPE.Varchar2, tbTitle.Text.Trim(), DIRECTION.Input);
            SetParameters("msg_text", DB_TYPE.Clob, tbText.Text.Trim(), DIRECTION.Input);
            SQL_NONQUERY("insert into bars_board (msg_title, msg_text, writer) values (:msg_title, :msg_text, user_name)");
        }
        finally
        {
            DisposeOraConnection();
        }

        gvBoards.DataBind();
        tbTitle.Text = string.Empty;
        tbText.Text = string.Empty;
    }
    protected void gvBoards_PreRender(object sender, EventArgs e)
    {
        //не использовать defaultButton при нажатии Enter
        gvBoards.Attributes.Add("onkeypress", "if (event.keyCode == 13) return false;");
    }
}
