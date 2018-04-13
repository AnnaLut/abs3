using System;
using csNetUpload;
using Bars.UserControls;

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
    private Byte[] ImageData
    {
        get
        {
            if (this.Session[this.ImageDataSessionID] == null) return null;

            ByteData bd = (ByteData)this.Session[this.ImageDataSessionID];
            return bd.Data;
        }
        set
        {
            if (this.Session[ImageDataSessionID] != null)
            {
                (this.Session[ImageDataSessionID] as ByteData).Dispose();
                this.Session[ImageDataSessionID] = null;
            }

            this.Session[ImageDataSessionID] = new ByteData(value);
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
                byte[] file = uc.FileToArray(0);
                ImageData = file;
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
