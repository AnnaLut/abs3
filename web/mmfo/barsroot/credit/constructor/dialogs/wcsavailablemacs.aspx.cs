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

public partial class credit_constructor_dialogs_wcsavailablemacs : Bars.BarsPage
{
    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsFV.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void fvVWcsAvailableMacs_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            # region switch starments
            case "Add":
                FormView fv = (sender as FormView);

                String SUBPRODUCT_ID = Request.Params.Get("subproduct_id");
                String MAC_ID = (String)fv.DataKey.Values["MAC_ID"];
                String TYPE_ID = (String)fv.DataKey.Values["TYPE_ID"];

                BbConnection con = new BbConnection();
                WcsPack wp = new WcsPack(con);

                switch (TYPE_ID)
                {
                    # region switch starments
                    case "TEXT":
                        TextBoxString tbsVAL_TEXT = (fv.FindControl("VAL_TEXTTextBox") as TextBoxString);
                        if (tbsVAL_TEXT != null) wp.SBPROD_MAC_TEXT_SET(SUBPRODUCT_ID, MAC_ID, tbsVAL_TEXT.Value);
                        break;

                    case "NUMB":
                        TextBoxNumb tbnVAL_NUMB = (fv.FindControl("VAL_NUMBTextBox") as TextBoxNumb);
                        if (tbnVAL_NUMB != null) wp.SBPROD_MAC_NUMB_SET(SUBPRODUCT_ID, MAC_ID, tbnVAL_NUMB.Value);
                        break;

                    case "DECIMAL":
                        TextBoxDecimal tbdVAL_DECIMAL = (fv.FindControl("VAL_DECIMALTextBox") as TextBoxDecimal);
                        if (tbdVAL_DECIMAL != null) wp.SBPROD_MAC_DEC_SET(SUBPRODUCT_ID, MAC_ID, tbdVAL_DECIMAL.Value);
                        break;

                    case "DATE":
                        TextBoxDate tbdVAL_DATE = (fv.FindControl("VAL_DATETextBox") as TextBoxDate);
                        if (tbdVAL_DATE != null) wp.SBPROD_MAC_DAT_SET(SUBPRODUCT_ID, MAC_ID, tbdVAL_DATE.Value);
                        break;

                    case "LIST":
                        DDLList ddlVAL_LIST = (fv.FindControl("VAL_LISTDropDownList") as DDLList);
                        if (ddlVAL_LIST != null) wp.SBPROD_MAC_LIST_SET(SUBPRODUCT_ID, MAC_ID, ddlVAL_LIST.Value);
                        break;

                    case "REFER":
                        TextBoxRefer tbrVAL_REFER = (fv.FindControl("VAL_REFERTextBox") as TextBoxRefer);
                        if (tbrVAL_REFER != null) wp.SBPROD_MAC_REF_SET(SUBPRODUCT_ID, MAC_ID, tbrVAL_REFER.Value);
                        break;

                    case "FILE":
                        TextBoxFile tbfVAL_FILE = (fv.FindControl("VAL_FILETextBox") as TextBoxFile);
                        if (tbfVAL_FILE != null) wp.SBPROD_MAC_FILE_SET(SUBPRODUCT_ID, MAC_ID, tbfVAL_FILE.FileData);
                        break;

                    case "BOOL":
                        RBLFlag rblflVAL_BOOL = (fv.FindControl("VAL_BOOLRadioButtonList") as RBLFlag);
                        if (rblflVAL_BOOL != null) wp.SBPROD_MAC_BOOL_SET(SUBPRODUCT_ID, MAC_ID, rblflVAL_BOOL.Value);
                        break;
                    # endregion
                }
                
                ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "CloseDialog(true);", true);

                break;
            # endregion
        }
    }
    # endregion
}
