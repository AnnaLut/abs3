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
using Bars.Classes;

public partial class admin_operateusers : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        // Наполнение грида
        sdsUsers.PreliminaryStatement = "set role WR_NS";
        sdsUsers.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditUser")
        {
            string sUserId = e.CommandArgument.ToString();
            Session["oCurUser"] = null;
            Response.Redirect("operateuserdata.aspx?uid=" + sUserId);
        }
        else if (e.CommandName == "DeleteUser")
        {
            string sUserId = e.CommandArgument.ToString();
            ClassUser oCurUser = new ClassUser(decimal.Parse(sUserId));
            oCurUser.Delete();
            Session["oCurUser"] = null;
            gvUsers.DataBind();
        }
    }
    protected void btNew_Click(object sender, EventArgs e)
    {
        string sUserId = "-1";
        Session["oCurUser"] = null;
        Response.Redirect("operateuserdata.aspx?uid=" + sUserId);
    }
}
