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

using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

using Bars.UserControls;
using ibank.core;
using credit;

public partial class dialogs_byteimage_show : Bars.BarsPage
{
    # region Приватные свойства
    /// <summary>
    /// Идентификатор данных в сессии
    /// </summary>
    private String ImageDataSessionID
    {
        get
        {
            return Request.Params.Get("sid");
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BImg.BDValue = (ByteData)this.Session[this.ImageDataSessionID];
        }
    }
    protected void ibPrint_Click(object sender, ImageClickEventArgs e)
    {
        String PrintSessionID = "PS_" + Guid.NewGuid();

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);
        try
        {
            for (Int32 i = 0; i < BImg.BDValue.PageCount; i++)
            {
                cmn.wp.PRINT_SCAN_SET(PrintSessionID, BImg.BDValue.GetPage(i).MainData);
            }

            FrxParameters pars = new FrxParameters();
            pars.Add(new FrxParameter("p_ps_id", TypeCode.String, PrintSessionID));
            FrxDoc doc = new FrxDoc(
                FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID("PRINT_SCANS")),
                pars,
                this.Page);
            doc.Print(FrxExportTypes.Pdf);
        }
        finally
        {
            cmn.wp.PRINT_SCAN_CLEAR(PrintSessionID);
            con.CloseConnection();
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "WndResizeEvent_Script", String.Format("window.onresize = function() {{ ResizeImageToWindow('{0}'); }}; ", BImg.BaseClientID), true);

        base.OnPreRender(e);
    }
    # endregion
}
