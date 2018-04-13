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

public partial class credit_secretarycc_printdocs : Bars.BarsPage
{
    # region Приватные свойства
    public String SRV_HIERARCHY
    {
        get
        {
            return Convert.ToString(Request.Params.Get("srvhr"));
        }
    }
    public String WS_ID
    {
        get
        {
            return "SRV_" + SRV_HIERARCHY;
        }
    }
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
    protected void lv_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Print":
                String TemplateId = (e.CommandArgument as String).Split(';')[0];

                // рабочее пространство используется только для шаблонов служб,
                // допустимые раб. пространства SRV_TOBO, SRV_RU, SRV_CA
                // String WS_ID = (e.CommandArgument as String).Split(';')[1];

                Decimal WS_NUM = Convert.ToDecimal((e.CommandArgument as String).Split(';')[1]);
                String DOCEXP_TYPE_ID = (e.CommandArgument as String).Split(';')[2];

                FrxParameters pars = new FrxParameters();
                pars.Add(new FrxParameter("p_bid_id", TypeCode.Decimal, BID_ID));
                pars.Add(new FrxParameter("p_ws_id", TypeCode.String, WS_ID));
                pars.Add(new FrxParameter("p_ws_number", TypeCode.Decimal, WS_NUM));
                FrxDoc doc = new FrxDoc(
                    FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)),
                    pars,
                    this.Page);

                switch (DOCEXP_TYPE_ID)
                {
                    case "PDF": doc.Print(FrxExportTypes.Pdf);
                        break;
                    case "RTF": doc.Print(FrxExportTypes.Rtf);
                        break;
                    case "DOC": doc.Print(FrxExportTypes.Word2007);
                        break;
                    default: doc.Print(FrxExportTypes.Pdf);
                        break;
                }

                break;
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
            String WS_ID = sc.WS_ID;
            Decimal? WS_NUM = sc.WS_NUM;
            Byte[] VAL = sc.Value;

            // установка ответа
            cmn.wp.ANSW_FILE_SET(BID_ID, QUESTION_ID, VAL, "sc_" + BID_ID.ToString() + "_" + QUESTION_ID + ".jpg", WS_ID, WS_NUM);
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void lv_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            VWcsCcBidTemplatesRecord rec = ((e.Item as ListViewDataItem).DataItem as VWcsCcBidTemplatesRecord);

            // контрол
            TextBoxScanner sc = (e.Item.FindControl("sc") as TextBoxScanner);

            // заполняем значение
            if (rec.IMG != null) sc.Value = rec.IMG;
        }
    }
    protected void bNext_Click(object sender, EventArgs e)
    {
        // чистим сессию при выходе
        Master.ClearSessionScans();

        // возвращаемся в карточку заявки
        Response.Redirect(String.Format("/barsroot/credit/secretarycc/bid_card.aspx?srvhr={0}&bid_id={1}", SRV_HIERARCHY, BID_ID.ToString()));
    }
    # endregion
}