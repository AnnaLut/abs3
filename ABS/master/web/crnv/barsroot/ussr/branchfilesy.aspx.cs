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
using Bars.Logger;
using Bars.Configuration;

public partial class ussr_branchfilesy : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        object obj = Session["curStmt"];
        string curStmt = String.Empty;
        if (null != obj)
        {
            curStmt = obj.ToString();
        }
        else
        {
            //throw new ArgumentException("Не всі параметри визначені");
        }
        ds.SelectCommand = @" 
            select 
                branch,     
                branch_name,
                substr(branch_name,1,20) || '...' as branch_name_short
            from v_branch_without_yfiles " +
            ( curStmt != String.Empty ? " where " + curStmt : String.Empty )+
            " order by branch";
    }
    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[1].Attributes.Add("Title", DataBinder.Eval(e.Row.DataItem, "BRANCH_NAME").ToString());
        }
    }
}
