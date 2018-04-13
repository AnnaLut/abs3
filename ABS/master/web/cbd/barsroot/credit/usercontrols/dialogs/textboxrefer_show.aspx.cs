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
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;
using credit;
using Bars.UserControls;
using Bars.Classes;

public partial class credit_dialogs_textboxrefer_show : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region Приватные методы
    private DataControlField FindByDataField(DataControlFieldCollection dcfc, String DataFieldName)
    {
        foreach (DataControlField dcf in dcfc)
        {
            BoundField bf = (dcf as BoundField);
            if (bf != null && bf.DataField == DataFieldName)
                return dcf;
        }
        return null;
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // параметры страницы
        String ReferDataSessionID = Request.Params.Get("refdatasid");
        ReferQueryObject rqo = (ReferQueryObject)Session[ReferDataSessionID];

        Trace.Write("rqo = " + rqo);
        // заголовок страницы
        lbPageTitle.Text = String.Format(lbPageTitle.Text, rqo.TableSemantic);

        // параметры источника данных
        // sds.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("BASIC_INFO");
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        // если не задан идентификатор заявки то не парсим sql
        Trace.Write("rqo.QuerySTMT = " + rqo.QuerySTMT);
        if (rqo.BID_ID.HasValue)
        {
            BbConnection con = new BbConnection();
            Common cmn = new Common(con, rqo.BID_ID);

            if (!String.IsNullOrEmpty(rqo.WS_ID) && rqo.WS_NUM.HasValue)
                sds.SelectCommand = cmn.wu.PARSE_SQL(rqo.BID_ID, rqo.QuerySTMT, rqo.WS_ID, rqo.WS_NUM);
            else if (!String.IsNullOrEmpty(rqo.WS_ID))
                sds.SelectCommand = cmn.wu.PARSE_SQL(rqo.BID_ID, rqo.QuerySTMT, rqo.WS_ID);
            else
                sds.SelectCommand = cmn.wu.PARSE_SQL(rqo.BID_ID, rqo.QuerySTMT);
        }
        else sds.SelectCommand = rqo.QuerySTMT;
        Trace.Write("rqo.BID_ID = " + rqo.BID_ID);
        Trace.Write("rqo.WS_ID = " + rqo.WS_ID);
        Trace.Write("rqo.WS_NUM = " + rqo.WS_NUM);
        Trace.Write("sds.SelectCommand = " + sds.SelectCommand);

        // форматируем грид
        foreach (String key in rqo.Columns.Keys)
        {
            BoundField bf = new BoundField();
            bf.DataField = key;
            bf.HeaderText = (String)rqo.Columns[key];
            if (FindByDataField(gv.Columns, key) == null) gv.Columns.Add(bf);
        }
    }
    # endregion
}
