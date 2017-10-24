using Bars.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cim_forms_ape_servicecodes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        dsServiceCodes.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        string sql = "select code_id, code_name from cim_ape_servicecode where delete_date is null {0} order by 1";
        string filter = string.Empty;
        if (!string.IsNullOrEmpty(tbCode.Text))
            filter += " and code_id like '%" + tbCode.Text + "%'";
        if (!string.IsNullOrEmpty(tbName.Text))
            filter += " and code_name like '%" + tbName.Text + "%'";
        dsServiceCodes.SelectCommand = string.Format(sql, filter);
        Master.AddScript("/barsroot/cim/forms/scripts/ape_servicecodes.js");
    }
    
    protected void btSearch_Click(object sender, EventArgs e)
    {
        gvServiceCodes.DataBind();
    }
}