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

using Bars.Classes;
using ibank.core;

public partial class credit_scancopy : Bars.BarsPage
{
    # region Приватные свойства
    private Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
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
        // заголовок
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);
    }
    protected void lvBidScancopyQuestions_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            VWcsBidScancopyQuestionsRecord rec = ((e.Item as ListViewDataItem).DataItem as VWcsBidScancopyQuestionsRecord);
            ByteImage bi = (e.Item.FindControl("bi") as ByteImage);

            // заполняем значение
            Common cmn = new Common(new BbConnection(), BID_ID);
            if (cmn.wu.HAS_ANSW(BID_ID, rec.QUESTION_ID).Value == 1)
                bi.Value = cmn.wu.GET_ANSW_BLOB(BID_ID, rec.QUESTION_ID);
        }
    }
    protected void lvBidGrtScancopyQuests_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            VWcsBidGrtScancopyQuestsRecord rec = ((e.Item as ListViewDataItem).DataItem as VWcsBidGrtScancopyQuestsRecord);
            VWcsGaranteesRecord recGrt = (new VWcsGarantees()).SelectGarantee(rec.GARANTEE_ID)[0];

            ByteImage bi = (e.Item.FindControl("bi") as ByteImage);
            Label lb = (e.Item.FindControl("lb") as Label);

            // заполняем значение
            Common cmn = new Common(new BbConnection(), BID_ID);
            if (cmn.wu.HAS_ANSW(BID_ID, rec.QUESTION_ID, recGrt.WS_ID, rec.GARANTEE_NUM).Value == 1)
                bi.Value = cmn.wu.GET_ANSW_BLOB(BID_ID, rec.QUESTION_ID, recGrt.WS_ID, rec.GARANTEE_NUM);

            lb.Text = String.Format("{0}({1}) - {2}", recGrt.GARANTEE_NAME, rec.GARANTEE_NUM, rec.QUESTION_NAME);
        }
    }
    # endregion

    # region Приватные методы
    # endregion
}