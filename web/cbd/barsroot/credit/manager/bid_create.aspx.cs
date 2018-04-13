using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Collections.Generic;
using credit;

using Bars.Classes;
using ibank.core;
using Bars.UserControls;

public partial class credit_manager_bid_create : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region События
    protected override void OnInit(EventArgs e)
    {
        // чистим сессию при входе
        if (!IsPostBack)
        {
            Master.ClearSessionScans();
        }

        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void dl_ItemCommand(object source, DataListCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Select":
                Common cmn = new Common();

                // выбраный субпродукт 
                String SUBPRODUCT_ID = Convert.ToString(e.CommandArgument);
                
                // переходим к вводу ИНН
                ScriptManager.RegisterStartupScript(this, typeof(String), "redirect", "location.replace('/barsroot/credit/manager/inn_create.aspx?sbp_id=" + SUBPRODUCT_ID + "');", true);

                break;
        }
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        dl.DataBind();
    }
    # endregion
}