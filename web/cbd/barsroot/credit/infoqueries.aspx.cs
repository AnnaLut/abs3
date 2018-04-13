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
using System.Drawing;
using credit;
using Bars.UserControls;

using Bars.Classes;
using ibank.core;

public partial class credit_infoqueries : Bars.BarsPage
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
    protected void Page_Load(object sender, EventArgs e)
    {
        // заголовок
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);
    }
    protected void lvItems_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            // получаем доступ к данным
            VWcsBidInfoqueriesRecord iq_rec = ((e.Item.Parent.Parent.Parent as ListViewDataItem).DataItem as VWcsBidInfoqueriesRecord);
            VWcsInfoqueryQuestionsRecord rec = ((e.Item as ListViewDataItem).DataItem as VWcsInfoqueryQuestionsRecord);

            // создаем контролы
            HtmlTableCell tdQuestionValue = ((e.Item as ListViewDataItem).FindControl("tdQuestionValue") as HtmlTableCell);

            Common cmn = new Common(new BbConnection(), BID_ID);

            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, rec.QUESTION_ID, iq_rec.WS_ID, 0);
            Trace.Write(iq_rec.WS_ID);
            if (HasAnsw == 1)
            {
                Label l = new Label();
                l.ID = "l";

                # region Switch TYPE_ID
                switch (rec.TYPE_ID)
                {
                    case "TEXT":
                    case "NUMB":
                    case "DECIMAL":
                    case "DATE":
                    case "BOOL":
                        l.Text = cmn.wu.GET_ANSW_FORMATED(BID_ID, rec.QUESTION_ID, 0, iq_rec.WS_ID, 0);
                        break;
                    case "LIST":
                        l.Text = String.Format("{0} - {1}", cmn.wu.GET_ANSW_LIST(BID_ID, rec.QUESTION_ID, iq_rec.WS_ID, 0), cmn.wu.GET_ANSW_LIST_TEXT(BID_ID, rec.QUESTION_ID, iq_rec.WS_ID, 0));
                        break;
                    case "REFER":
                        l.Text = String.Format("{0} - {1}", cmn.wu.GET_ANSW_REFER(BID_ID, rec.QUESTION_ID, iq_rec.WS_ID, 0), cmn.wu.GET_ANSW_REFER_TEXT(BID_ID, rec.QUESTION_ID, iq_rec.WS_ID, 0));
                        break;
                    /* !!! Добавить возможность обработки файлов
                    case "FILE":
                        break;*/
                    case "XML":
                        String XMLDataSessionID = "XML_DATA_" + rec.QUESTION_ID + "_" + Guid.NewGuid();
                        this.Session[XMLDataSessionID] = cmn.wu.GET_ANSW_XML(BID_ID, rec.QUESTION_ID, iq_rec.WS_ID, 0);
                        l.Text = String.Format("<a href='/barsroot/credit/usercontrols/dialogs/textboxxml_show.aspx?sid={0}&fname={1}&rnd={2}' target='_blank'>Файл</a>", XMLDataSessionID, "XML_DATA_" + rec.QUESTION_ID + ".xml", (new Random()).Next().ToString());

                        break;
                }
                # endregion

                tdQuestionValue.Controls.Add(l);
            }
        }
    }
    protected void lv_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        Label GROUP_NAME = e.Item.FindControl("GROUP_NAME") as Label;
        VWcsBidInfoqueriesRecord DataItem = (e.Item as ListViewDataItem).DataItem as VWcsBidInfoqueriesRecord;

        GROUP_NAME.Text = String.Format("{0}{1} - {2}", DataItem.TYPE_NAME, (DataItem.TYPE_ID == "MANUAL" ? "(" + DataItem.SERVICE_NAME + " " + DataItem.SRV_HIERARCHY_NAME + ")" : ""), DataItem.IQUERY_NAME);

        switch (Convert.ToInt32(DataItem.STATUS))
        {
            case 0:
                // 0 - Очікує
                if (DataItem.IS_REQUIRED == 1)
                {
                    GROUP_NAME.ForeColor = Color.FromArgb(200, 200, 0);
                    GROUP_NAME.ToolTip = Resources.credit.StringConstants.text_wait;
                }
                else
                {
                    GROUP_NAME.ForeColor = Color.FromArgb(255, 130, 0);
                    GROUP_NAME.ToolTip = Resources.credit.StringConstants.text_wait_optional;
                }
                break;
            case 1:
                // 1 - Виконується
                GROUP_NAME.ForeColor = Color.Black;
                GROUP_NAME.ToolTip = Resources.credit.StringConstants.text_inproc;
                break;
            case 2:
                // 2 - Виконано
                GROUP_NAME.ForeColor = Color.FromArgb(0, 150, 0);
                GROUP_NAME.ToolTip = Resources.credit.StringConstants.text_done;
                break;
            case 3:
                // 3 - Помилка
                GROUP_NAME.ForeColor = Color.FromArgb(200, 0, 0);
                GROUP_NAME.ToolTip = String.Format(Resources.credit.StringConstants.text_error, DataItem.STATUS_MSG);
                break;
        }
    }
    # endregion

    # region Приватные методы
    # endregion
}