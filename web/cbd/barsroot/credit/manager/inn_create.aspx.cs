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

public partial class credit_manager_inn_create : Bars.BarsPage
{
    # region Приватные свойства
    private Decimal? PREV_BID_ID
    {
        get
        {
            return String.IsNullOrEmpty(Request.Params.Get("bid_id")) ? (Decimal?)null : Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    private String SUBPRODUCT_ID
    {
        get
        {
            return Request.Params.Get("sbp_id");
        }
    }
    private String SearchINN
    {
        get
        {
            return (String)this.ViewState["SEARCH_INN"];
        }
        set
        {
            this.ViewState["SEARCH_INN"] = value;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HideError();
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        gv.DataBind();
        SearchINN = INN.Value;
    }
    protected void bNext_Click(object sender, EventArgs e)
    {
        String CODE_002 = INN.Value;
        // проверяем выполнялся ли поиск по этому ИНН
        if (String.IsNullOrEmpty(SearchINN) || SearchINN != CODE_002)
        {
            Master.ShowError(String.Format(Resources.credit.StringConstants.text_inn_search_required, CODE_002));
            return;
        }

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            Decimal? RNK = gv.SelectedValue != null ? (Decimal?)gv.SelectedDataKey["RNK"] : (Decimal?)null;

            // если заявки еще нет то создаем, если заявка из предварительных то передаем дальше
            Decimal? BID_ID;
            if (PREV_BID_ID.HasValue)
            {
                BID_ID = PREV_BID_ID;

                // устанавливаем выбранный РНК или ИНН
                if (RNK.HasValue)
                    cmn.wp.BID_SET_RNK(BID_ID, RNK);
                else
                    cmn.wp.BID_SET_INN(BID_ID, CODE_002);
            }
            else
            {
                BID_ID = cmn.wp.BID_CREATE(SUBPRODUCT_ID, CODE_002, RNK);
            }

            // завершаем состояние и переходим к вводу заявки
            ScriptManager.RegisterStartupScript(this, typeof(String), "redirect", "location.replace('/barsroot/credit/manager/bid_card.aspx?bid_id=" + Convert.ToString(BID_ID) + "');", true);

            cmn.wp.BID_STATE_DEL(BID_ID, "NEW_PRESCORING");
            cmn.wp.BID_STATE_DEL(BID_ID, "NEW_START");
            cmn.wp.BID_STATE_SET_IMMEDIATE(BID_ID, "NEW_DATAINPUT", (String)null);
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        String CODE_002 = INN.Value;

        if (!String.IsNullOrEmpty(CODE_002))
        {
            if (gv.Rows.Count == 0)
            {
                // Новый клиент
                bNext.OnClientClick = String.Format("if (!confirm('" + Resources.credit.StringConstants.text_reg_bid2new_client + "')) return false;", CODE_002);
            }
            else
            {
                // Существующий клиент
                Decimal? RNK = (Decimal?)gv.SelectedDataKey["RNK"];
                bNext.OnClientClick = String.Format("if (!confirm('" + Resources.credit.StringConstants.text_reg_bid2_client_rnk + "')) return false;", Convert.ToString(RNK));
            }
        }

        base.OnPreRender(e);
    }
    # endregion
}