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

public partial class credit_usercontrols_dialogs_textboxfile_show : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // идентификатор сессии
        string sFileDataSessionID = Request.Params.Get("sid");

        // загрузка файла в поток
        byte[] bFileData = (byte[])Session[sFileDataSessionID];

        if (bFileData != null)
            Response.OutputStream.Write(bFileData, 0, bFileData.Length);
    }
}
