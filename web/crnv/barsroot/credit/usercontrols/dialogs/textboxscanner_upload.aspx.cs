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

using csNetUpload;
using Bars.UserControls;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

public partial class dialogs_textboxscanner_upload : Bars.BarsPage
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
        try
        {
            // загрузка файла
            UploadClass uc = new UploadClass();
            uc.ReadUpload();

            if (uc.FileCount > 0)
            {
                this.Session[ImageDataSessionID] = uc.FileToArray(0);
            }
        }
        catch (System.Exception ex)
        {
            Bars.Logger.DBLogger.Error("ex.InnerException = " + ex.InnerException + " ex.Message = " + ex.Message + " ex.Source = " + ex.Source + " ex.StackTrace = " + ex.StackTrace);
            throw;
        }
    }
    # endregion

    # region Приватные методы
    # endregion
}
