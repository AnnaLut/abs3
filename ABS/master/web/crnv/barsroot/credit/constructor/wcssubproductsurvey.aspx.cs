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

using Bars.UserControls;
using Bars.Classes;
using credit;
using ibank.core;
using System.Collections.Generic;

public partial class credit_constructor_wcssubproductsurvey : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region Публичные методы
    # endregion

    # region События
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title + " субпродукту \"" + Master.SUBPRODUCT_NAME + "\"", true);
    }
    protected void ibAdd_Click(object sender, ImageClickEventArgs e)
    {
        if (lb.SelectedIndex != -1)
        {
            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBPROD_SURVEY_SET(Master.SUBPRODUCT_ID, lb.SelectedValue);

            lb.DataBind();
        }
    }
    protected void btDelete_Click(object sender, EventArgs e)
    {
        WcsPack wp = new WcsPack(new BbConnection());
        wp.SBPROD_SURVEY_DEL(Master.SUBPRODUCT_ID);

        lb.DataBind();
    }
    protected void lb_DataBound(object sender, EventArgs e)
    {
        if (lb.SelectedIndex == -1 && lb.Items.Count > 0)
            lb.SelectedIndex = 0;

        List<VWcsSubproductSurveyRecord> lst = (new VWcsSubproductSurvey()).SelectSubproductSurvey(Master.SUBPRODUCT_ID);
        if (lst.Count > 0)
        {
            VWcsSubproductSurveyRecord rec = lst[0];

            SURVEY_ID.Value = rec.SURVEY_ID;
            SURVEY_NAME.Value = rec.SURVEY_NAME;
            GRP_CNT.Value = rec.GRP_CNT;
        }
        else
        {
            SURVEY_ID.Value = (String)null;
            SURVEY_NAME.Value = (String)null;
            GRP_CNT.Value = (Decimal?)null;
        }
    }
    # endregion
}
