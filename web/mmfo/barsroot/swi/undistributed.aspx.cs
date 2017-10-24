using System;
using Bars.Classes;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class swi_undistributed : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = @"select ID, LOGNAME, FIO, CNT from v_sw_staff_messages";

        dsMain.SelectCommand = SelectCommand;
    }

    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", "window.showModalDialog('" + URL + "',null,'dialogWidth:400px;dialogHeight:300Px');location.href=location.href;", true);
    }

    protected void btChange_Click(object sender, EventArgs e)
    {


        if (gvMain.SelectedRows.Count == 0)
        {
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не обрано рядок!');", true);
        }
        else
        {

            string id = Convert.ToString((gvMain.Rows[gvMain.SelectedRows[0]].Cells[0]).Text);
            Window_open("/barsroot/swi/swi_users.aspx?fromUser=" + id);
        }

        gvMain.DataBind();
    }
}