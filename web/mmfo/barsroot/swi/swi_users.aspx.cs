using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Bars.Classes;
using System.Web.UI.WebControls;

public partial class swi_swi_users : Bars.BarsPage
{ 
    protected void Page_Load(object sender, EventArgs e)
    {
        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = @"select distinct id, fio from v_sw_staff";

        dsMain.SelectCommand = SelectCommand;
    }

    protected void btRun_Click(object sender, EventArgs e)
    {
        
        try
        {
            if (gvMain.SelectedRows.Count == 0)
            {
                ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не обрано рядок!');", true);
            }
            else
            {
                InitOraConnection();

                string idFrom = Convert.ToString(Request["fromUser"]);
                string idTo = Convert.ToString((gvMain.Rows[gvMain.SelectedRows[0]].Cells[0]).Text);

                if (String.IsNullOrEmpty(idFrom)||idFrom== "&nbsp;")
                {
                    idFrom = "0";
                }
                if (String.IsNullOrEmpty(idTo)||idTo== "&nbsp;")
                {
                    idTo = "0";
                }

                ClearParameters();
                SetParameters("fromUser", DB_TYPE.Int32, idFrom, DIRECTION.Input);
                SetParameters("toUser", DB_TYPE.Int32, idTo, DIRECTION.Input);
                SQL_NONQUERY("begin bars_swift.impmsg_message_changeuser(null, nvl(:fromUser,0), nvl(:toUser,0)); end;");
            }
        }
        finally
        {
            DisposeOraConnection();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
        }
    }

    protected void btClose_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
    }
}