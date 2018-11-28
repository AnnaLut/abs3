using System;

/// <summary>
/// 
/// </summary>
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
