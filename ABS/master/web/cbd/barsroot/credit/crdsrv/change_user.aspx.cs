﻿using System;
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
using Bars.UserControls;
using System.Drawing;

using Bars.Classes;
using ibank.core;

public partial class credit_crdsrv_change_user : Bars.BarsPage
{
    # region Приватные свойства
    public String SRV_HIERARCHY
    {
        get
        {
            return Convert.ToString(Request.Params.Get("srvhr"));
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        gv.DataBind();
    }
    protected void cbAll_CheckedChanged(object sender, EventArgs e)
    {
        Boolean chkd = (sender as CheckBox).Checked;

        foreach (GridViewRow row in gv.Rows)
        {
            CheckBox cb = row.FindControl("cb") as CheckBox;
            cb.Checked = chkd;
        }
    }
    protected void btChange_Click(object sender, EventArgs e)
    {
        // проверки
        Master.HideError();

        // проверяем что выбраны заявки
        List<Decimal?> Bids = new List<Decimal?>();
        foreach (GridViewRow row in gv.Rows)
        {
            CheckBox cb = row.FindControl("cb") as CheckBox;
            if (cb.Checked)
                Bids.Add((Decimal?)gv.DataKeys[row.DataItemIndex]["BID_ID"]);
        }
        if (Bids.Count == 0)
        {
            Master.ShowError("Заявки не выбраны");
            return;
        }

        // проверяем что выбран пользователь
        Decimal? STAFF_ID = (gvStaff.SelectedValue == null ? (Decimal?)null : Convert.ToDecimal(gvStaff.SelectedValue));
        if (!STAFF_ID.HasValue)
        {
            Master.ShowError(Resources.credit.StringConstants.text_no_user_selected);
            return;
        }

        // выполняем переназначение
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        foreach (Decimal? Bid in Bids)
        {
            cmn.wp.BID_SRV_USER_CHANGE(Bid, "CREDIT_SERVICE", SRV_HIERARCHY, STAFF_ID);
        }

        // алерт по успешное выполнение
        ScriptManager.RegisterStartupScript(this, typeof(String), "success_alert", String.Format("alert('{0}');", Resources.credit.StringConstants.text_done), true);
        
        // перезагрузка грида
        gv.DataBind();
    }
    # endregion
}