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

using Bars.UserControls;
using ibank.core;
using credit;

public partial class dialogs_textboxscanner_show : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void ibPrint_Click(object sender, ImageClickEventArgs e)
    {
        // идентификатор сеCCии
        String sScanerDataSessionID = Request.Params.Get("sid");
        MultipleImage MImage = (MultipleImage)Session[sScanerDataSessionID];
        Int32 ImgCnt = MImage.ImgCount;

        String PrintSessionID = "PS_" + Guid.NewGuid();

        Common cmn = new Common(new BbConnection());
        try
        {
            for (int i = 0; i < ImgCnt; i++)
            {
                cmn.wp.PRINT_SCAN_SET(PrintSessionID, MImage.GetImage(i));
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
        }
    }
}
