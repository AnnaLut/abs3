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
    }
    protected void ibPrint_Click(object sender, ImageClickEventArgs e)
    {
        String PrintSessionID = "PS_" + Guid.NewGuid();

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);
        MemoryStream msIn = new MemoryStream(Session[this.ImageDataSessionID] as Byte[]);
        Bitmap TiffImage = new Bitmap(msIn);
        try
        {

            Int32 ImageCount = TiffImage.GetFrameCount(FrameDimension.Page);
            for (Int32 i = 0; i < ImageCount; i++)
            {
                TiffImage.SelectActiveFrame(FrameDimension.Page, i);
                using (MemoryStream msOut = new MemoryStream())
                {
                    TiffImage.Save(msOut, ImageFormat.Png);
                    cmn.wp.PRINT_SCAN_SET(PrintSessionID, msOut.ToArray());
                }
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
            msIn.Dispose();
            TiffImage.Dispose();
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        // формируем объект cxImage на странице
        String ObjectPattern = "<object classid=\"clsid:5220cb21-c88d-11cf-b347-00aa00a28331\"><param name=\"LPKPath\" value=\"csximage.lpk\"></object><object id=\"{0}\" classid=\"clsid:62E57FC5-1CCD-11D7-8344-00C1261173F0\" codebase=\"csximage.cab\" width=\"{1}\" height=\"{2}\" sid=\"{3}\" pcount_id=\"{4}\" prev_id='{5}' next_id='{6}' dwnldUrl='null'></object>";
        ph.InnerHtml = String.Format(ObjectPattern, "csxi", 500, 500, this.ImageDataSessionID, lbPageCount.ClientID, ibPrev.ClientID, ibNext.ClientID);

        // блок инициализации
        ScriptManager.RegisterClientScriptBlock(this, typeof(UserControl), "InitByteImage_Constants", String.Format("var PageCountPattern = '{0}'; ", Resources.credit.StringConstants.text_pagecount), true);
        // инициализация
        ScriptManager.RegisterStartupScript(this, typeof(UserControl), "InitByteImage_Script", String.Format("InitByteImage('{0}', '{1}', '{2}', '{3}', '{4}'); ", "csxi", this.ImageDataSessionID, lbPageCount.ClientID, ibPrev.ClientID, ibNext.ClientID), true);
        ibPrev.OnClientClick = String.Format("ShowPrevImage('{0}'); return false;", "csxi");
        ibNext.OnClientClick = String.Format("ShowNextImage('{0}'); return false;", "csxi");

        ScriptManager.RegisterStartupScript(this, typeof(UserControl), "WndResizeEvent_Script", String.Format("window.onresize = function() {{ ShowCurrentImage('{0}'); }}; ", "csxi"), true);

        base.OnPreRender(e);
    }
    # endregion
}
