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

public partial class credit_manager_curaccount : Bars.BarsPage
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

    # region Публичные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // заголовок
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // чекаут состояния
            if (!IsPostBack) cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_CURACC", (String)null);
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void bNext_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // сохраняем если нет ошибок при заполнении
            if (SaveData(con, BID_ID))
            {
                // чекин состояния и чистка сессии
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CURACC", (String)null);

                // завершаем состояние и переходим на след
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CURACC");

                // возвращаемся в карточку заявки
                Response.Redirect(String.Format("/barsroot/credit/manager/bid_card.aspx?bid_id={0}", BID_ID.ToString()));
            }
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void rbl_DataBound(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();

        try
        {
            // наполняем данными
            if (!IsPostBack) FillData(con, BID_ID);
        }
        finally
        {
            con.CloseConnection();
        }

        if (rbl.Items.Count == 0)
        {
            rbl.Items.Add(new ListItem(Resources.credit.StringConstants.text_client_hasno_curaccs, ""));
            rbl.Enabled = false;
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
    }
    # endregion

    # region Приватные методы
    private void FillData(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // заполняем значение
        List<VWcsBidCuraccountsRecord> lst = (List<VWcsBidCuraccountsRecord>)ods.Select();
        for (int i = 0; i < lst.Count; i++)
            if (lst[i].SELECTED == 1)
            {
                rbl.Items[i].Selected = true;
                break;
            }
    }
    private Boolean Validate(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        Master.HideError();

        // проверяем что выбран хоть один счет
        if (rbl.Items.Count == 1 && rbl.Items[0].Value == "")
        {
            Master.ShowError(Resources.credit.StringConstants.text_client_hasno_curaccs);
            return false;
        }

        Boolean flag = false;
        for (int i = 0; i < rbl.Items.Count; i++)
            if (rbl.Items[i].Selected)
            {
                flag = true;
                break;
            }
        if (!flag)
        {
            Master.ShowError(Resources.credit.StringConstants.text_no_curacc_selected);
            return false;
        }

        return true;
    }
    private Boolean SaveData(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        if (!Validate(con, BID_ID)) return false;

        // сохраняем системные вопросы
        for (int i = 0; i < rbl.Items.Count; i++)
            if (rbl.Items[i].Selected)
            {
                cmn.wp.ANSW_TEXT_SET(BID_ID, "PI_CURACC_ACCNO", rbl.Items[i].Value);
                break;
            }

        return true;
    }
    # endregion
}