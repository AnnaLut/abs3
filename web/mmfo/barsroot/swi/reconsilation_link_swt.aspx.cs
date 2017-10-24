using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;

public partial class swi_reconsilation_link_swt : Bars.BarsPage
{

    protected void Page_Load(object sender, EventArgs e)
    {

        dsMainDoc.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = @"select swref, mt, trn, sender, receiver,  amount, vdate from V_SW_IMPMSG";

        dsMainDoc.SelectCommand = SelectCommand;
        
    }

    protected void gvMainDoc_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void btLink_Click(object sender, EventArgs e)
    {

        InitOraConnection();
        try
        {
            
            if(Request["STMT_REF"]!=null & Request["COLN"]!=null)
            {
                string swref = Convert.ToString((gvMainDoc.Rows[gvMainDoc.SelectedRows[0]].Cells[0]).Text);

                ClearParameters();
                SetParameters("stmt_ref", DB_TYPE.Varchar2, Convert.ToString(Request["STMT_REF"]), DIRECTION.Input);
                SetParameters("coln", DB_TYPE.Varchar2, Convert.ToString(Request["COLN"]), DIRECTION.Input);
                SetParameters("swref", DB_TYPE.Varchar2, swref, DIRECTION.Input);
                SQL_NONQUERY("begin bars_swift.stmt_srcmsg_link(:stmt_ref, :coln, :swref, 1); end;");
            }

        }
        finally
        {
            DisposeOraConnection();
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
    }


    protected void btClose_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
    }
}