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

public partial class credit_manager_scancopy : Bars.BarsPage
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

        dl.DataBind();

        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        // заголовок
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);

        if (!IsPostBack)
        {
            BbConnection con = new BbConnection();
            Common cmn = new Common(con);

            try
            {
                // чекаут состояния
                if (!IsPostBack) cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_SCANCOPY", (String)null);
            }
            finally
            {
                con.CloseConnection();
            }
        }
    }
    protected void dl_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            VWcsBidScancopyQuestionsRecord rec = (e.Item.DataItem as VWcsBidScancopyQuestionsRecord);

            // контрол
            TextBoxScanner sc = (e.Item.FindControl("sc") as TextBoxScanner);
            sc.DocumentScaned += new EventHandler(sc_DocumentScaned);

            // обязательность и только чтение
            sc.IsRequired = rec.IS_REQUIRED == 1;

            // заполняем значение
            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, rec.QUESTION_ID);
            if (HasAnsw == 1) sc.Value = cmn.wu.GET_ANSW_BLOB(BID_ID, rec.QUESTION_ID);
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
            cmn.wp.ANSW_FILE_SET(BID_ID, QUESTION_ID, VAL, "sc_" + BID_ID.ToString() + "_" + QUESTION_ID + ".jpg");
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
            // чекин состояния
            cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_SCANCOPY", (String)null);

            // завершаем состояние и переходим на след
            cmn.wp.BID_STATE_DEL(BID_ID, "NEW_SCANCOPY");

            // чистим сессию при выходе
            Master.ClearSessionScans();

            // возвращаемся в карточку заявки
            Response.Redirect(String.Format("/barsroot/credit/manager/bid_card.aspx?bid_id={0}", BID_ID.ToString()));
        }
        finally
        {
            con.CloseConnection();
        }
    }
    # endregion
}