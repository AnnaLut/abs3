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
using Bars.UserControls;
using System.Drawing;

using Bars.Classes;
using ibank.core;

public partial class credit_srv_queries_arh : Bars.BarsPage
{
    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // заголовок страницы
        switch (Request.Params.Get("type"))
        {
            case "user":
                Master.SetPageTitle(String.Format(this.Title, Resources.credit.StringConstants.text_users), true);
                break;
            case "branch":
                Master.SetPageTitle(String.Format(this.Title, Resources.credit.StringConstants.text_branchs), true);
                break;
            case "all":
                Master.SetPageTitle(String.Format(this.Title, Resources.credit.StringConstants.text_all), true);
                break;
        }

        // первоначальная установка границ по дате
        if (!IsPostBack)
        {
            BidDateFrom.Value = DateTime.Now.AddMonths(-1);
            BidDateTo.Value = DateTime.Now.AddDays(1);
        }
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        // обеспечение
        if (!CreditGuarantee.Items.FindByValue("ALL").Selected)
        {
            String strCreditGuarantee = String.Empty;
            foreach (ListItem li in CreditGuarantee.Items)
                if (li.Selected)
                    strCreditGuarantee += (String.IsNullOrEmpty(strCreditGuarantee) ? "" : ";") + li.Value;

            ods.SelectParameters["CreditGuarantee"].DefaultValue = strCreditGuarantee;
        }
        else
            ods.SelectParameters["CreditGuarantee"].DefaultValue = String.Empty;

        // статус
        if (!BidState.Items.FindByValue("ALL").Selected)
        {
            String strBidState = String.Empty;
            foreach (ListItem li in BidState.Items)
                if (li.Selected)
                    strBidState += (String.IsNullOrEmpty(strBidState) ? "" : ";") + li.Value;

            ods.SelectParameters["BidState"].DefaultValue = strBidState;
        }
        else
            ods.SelectParameters["BidState"].DefaultValue = String.Empty;

        gv.DataBind();
    }
    # endregion
}