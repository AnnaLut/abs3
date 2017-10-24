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

using Bars.Classes;
using Bars.UserControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;
using credit;

public partial class credit_constructor_dialogs_wcsavlbsurveygroups : Bars.BarsPage
{
    # region Приватные свойства
    private String SURVEY_ID
    {
        get
        {
            return Request.Params.Get("survey_id");
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void ibAdd_Click(object sender, ImageClickEventArgs e)
    {
        String SRC_SURVEY_ID = (String)gv.SelectedDataKey["SURVEY_ID"];
        String SRC_GROUP_ID = (String)gv.SelectedDataKey["GROUP_ID"];

        Common cmn = new Common(new BbConnection());
        cmn.wp.SURVEY_GROUP_CLONE(SURVEY_ID, SRC_SURVEY_ID, SRC_GROUP_ID);

        ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "CloseDialog(true);", true);
    }
    # endregion
}
