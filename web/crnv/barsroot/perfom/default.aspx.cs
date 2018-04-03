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

public partial class perfom_default : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["Perfom.StartTime"] = DateTime.Now;
    }
    protected void btRunSimple_Click(object sender, EventArgs e)
    {
        Session["Perfom.EndTime"] = DateTime.Now;
        ShowResult();
    }
    protected void btRunPostData_Click(object sender, EventArgs e)
    {
        Session["Perfom.EndTime"] = DateTime.Now;
        ShowResult();
    }
    protected void btRunConnect_Click(object sender, EventArgs e)
    {
        InitOraConnection();
        SetRole("basic_info");
        DisposeOraConnection();

        Session["Perfom.EndTime"] = DateTime.Now;
        ShowResult();
    }
    protected void btRunHardConnect_Click(object sender, EventArgs e)
    {
        try
        {
            InitOraConnection();
            SetRole("basic_info");
            SQL_SELECT_dataset(@"select codeapp,appname,codeoper,opername,funcname 
						from v_operapp 
						where frontend=1 
						and runable <> 3 
						and codeapp <> 'WTOP' 
						order by appname, opername");
        }
        finally
        {
            DisposeOraConnection();
        }

        Session["Perfom.EndTime"] = DateTime.Now;
        ShowResult();
    }

    private void ShowResult()
    { 
        DateTime start = (DateTime)Session["Perfom.StartTime"];
        DateTime end = (DateTime)Session["Perfom.EndTime"];
        TimeSpan diff = end - start;
        tbResult.Text = "Час виконання: " + diff.Milliseconds.ToString() + " мс.";
    }

}
