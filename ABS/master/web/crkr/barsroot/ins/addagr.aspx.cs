using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Bars.DataComponents;
using Bars.UserControls;
using Bars.Ins;
using ibank.core;
using System.Drawing;

public partial class ins_addagr : System.Web.UI.Page
{
    # region Приватные свойства
    private VInsDealsRecord _Deal;
    # endregion

    # region Публичные свойства
    public Decimal DEAL_ID
    {
        get
        {
            if (Request.Params.Get("deal_id") == null) throw new Bars.Exception.BarsException("Не задано обов`язковий параметр Url deal_id");
            return Convert.ToDecimal(Request.Params.Get("DEAL_ID"));
        }
    }
    public VInsDealsRecord Deal
    {
        get
        {
            if (_Deal == null)
                _Deal = (new VInsDeals()).SelectDeal(DEAL_ID);

            return _Deal;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillControls();
        }
    }
    protected void bSave_Click(object sender, EventArgs e)
    {
        InsPack ip = new InsPack(new BbConnection());
        Decimal? ADDAGR_ID = ip.CREATE_ADDAGR(DEAL_ID, SER.Value, NUM.Value, SDATE.Value);
        ScriptManager.RegisterStartupScript(this, typeof(Page), "close_dialog", String.Format("CloseDialog('{0}'); ", ADDAGR_ID), true);
    }
    # endregion

    # region Приватные методы
    private void FillControls()
    {
        SDATE.Value = DateTime.Now.Date;
    }
    # endregion
}