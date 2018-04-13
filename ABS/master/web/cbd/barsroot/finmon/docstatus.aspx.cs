using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Types;
using System.Globalization;
using Bars.UserControls;
using Bars.Oracle;
using Bars.Classes;
using System.Web.Services;


public partial class finmon_docstatus : Bars.BarsPage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string title = Request["ref"];
        lbTitle.Text = "Коментар до документів з реф= " + title.Substring(title.IndexOf(":") + 1, title.Length - title.IndexOf(":") - 2).Replace("-",",");       
    }
    
    protected void btSearch_Click(object sender, EventArgs e)
    {
        string p_ref = Request["ref"];
        int p_count = Convert.ToInt16(p_ref.Substring(0, p_ref.IndexOf(":")));

        int slenth = p_ref.Length;
        string str = p_ref.Substring(p_ref.IndexOf(":") + 1, slenth - p_ref.IndexOf(":") - 1);

        string p_comm = tbComent.Text;
        Session["FinminReload"] = "1";
        InitOraConnection();
        try
        {

            for (int i = 0; i < p_count; i++)
            {
                string r = str.Substring(0, str.IndexOf("-"));
                slenth = str.Length;
                str = str.Substring(str.IndexOf("-") + 1, slenth - str.IndexOf("-") - 1);
               // tbComent.Text += i.ToString() + "-" + r + "/";

                ClearParameters();

                SetParameters("p_ref", DB_TYPE.Decimal, r, DIRECTION.Input);
                SetParameters("p_status", DB_TYPE.Varchar2, "I", DIRECTION.Input);
                SetParameters("p_comm", DB_TYPE.Varchar2, p_comm, DIRECTION.Input);

                SQL_NONQUERY("begin p_fm_set_status(:p_ref,null,:p_status,:p_comm,null); end;");

            }
        }
        finally
        {
            DisposeOraConnection();
        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", " window.close('this');", true);
                
    }

}