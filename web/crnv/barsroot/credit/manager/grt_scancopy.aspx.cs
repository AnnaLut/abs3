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

public partial class credit_manager_grt_scancopy : Bars.BarsPage
{
    # region Приватные свойства
    private VWcsBidGaranteesRecord _BidGarantee;

    private Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    private String GARANTEE_ID
    {
        get
        {
            return Request.Params.Get("garantee_id");
        }
    }
    private Decimal? GARANTEE_NUM
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("garantee_num"));
        }
    }
    # endregion

    # region Публичные свойства
    public VWcsBidGaranteesRecord BidGarantee
    {
        get
        {
            if (_BidGarantee == null)
                _BidGarantee = (new VWcsBidGarantees()).SelectBidGarantee(BID_ID, GARANTEE_ID, GARANTEE_NUM)[0];

            return _BidGarantee;
        }
    }
    public Boolean? ReadOnly
    {
        get
        {
            return Request.Params.Get("readonly") == "1" ? true : false;
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

        dl.DataBind();

        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        // заголовок Сканирование документов обеспечения {0} - {1} заявки №{2}
        Master.SetPageTitle(String.Format(this.Title, BidGarantee.GARANTEE_NAME, Convert.ToString(GARANTEE_NUM), Convert.ToString(BID_ID)), true);

        // переводим обеспечение в состояние Сканування
        if (BidGarantee.STATUS_ID == 0) // Новий
            cmn.wp.BID_GARANTEE_STATUS_SET(BID_ID, GARANTEE_ID, GARANTEE_NUM, 1); // Сканування
    }
    protected void dl_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            VWcsBidGrtScancopyQuestsRecord rec = (e.Item.DataItem as VWcsBidGrtScancopyQuestsRecord);

            // контрол
            TextBoxScanner sc = (e.Item.FindControl("sc") as TextBoxScanner);
            sc.DocumentScaned += new EventHandler(sc_DocumentScaned);

            // обязательность и только чтение
            sc.IsRequired = rec.IS_REQUIRED == 1;

            // заполняем значение
            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, rec.QUESTION_ID, BidGarantee.WS_ID, GARANTEE_NUM);
            if (HasAnsw == 1) sc.Value = cmn.wu.GET_ANSW_BLOB(BID_ID, rec.QUESTION_ID, BidGarantee.WS_ID, GARANTEE_NUM);
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void sc_DocumentScaned(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // контрол сканера
            TextBoxScanner sc = (sender as TextBoxScanner);

            // ид вопроса и значение
            String QUESTION_ID = sc.SupposedQuestionID;
            Byte[] VAL = sc.Value;

            // установка ответа
            cmn.wp.ANSW_FILE_SET(BID_ID, QUESTION_ID, VAL, "sc_" + BID_ID.ToString() + "_" + QUESTION_ID + ".jpg", BidGarantee.WS_ID, GARANTEE_NUM);
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
            // переводим обеспечение в след состояние
            if (BidGarantee.STATUS_ID == 1) // Сканування
                cmn.wp.BID_GARANTEE_STATUS_SET(BID_ID, GARANTEE_ID, GARANTEE_NUM, 2); // Заповнення анкети (початкове)

            // чистим сессию при выходе
            Master.ClearSessionScans();

            // возвращаемся в карточку заявки
            Response.Redirect(String.Format("/barsroot/credit/manager/garantees.aspx?bid_id={0}&readonly={1}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0)));
        }
        finally
        {
            con.CloseConnection();
        }
    }
    # endregion
}