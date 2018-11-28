using System;
using System.Web.UI;
using Bars.UserControls;

public partial class dialogs_textboxscanner_scan : Bars.BarsPage
{
    # region Приватные свойства
    /// <summary>
    /// Идентификатор данных в сессии
    /// </summary>
    private String ImageDataSessionID
    {
        get
        {
            return "image_bill_data";//Request.Params.Get("sid");
        }
    }

    private string ImageHeight 
    {
        get
        {
            var sessionParam = Request.Params.Get("imageHeight");
            return String.IsNullOrEmpty(sessionParam) ? "0" : sessionParam; 
        }
    }

    private string ImageWidth
    {
        get
        {
            var sessionParam = Request.Params.Get("imageWidth");
            return String.IsNullOrEmpty(sessionParam) ? "0" : sessionParam; 
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
    }
    /// <summary>
    /// Загружен ли файл
    /// </summary>
    private Boolean HasValue
    {
        get
        {
            return ImageData != null;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected override void OnPreRender(EventArgs e)
    {
        int pageCount = 0;
        if (this.Session[this.ImageDataSessionID] != null)
        {
            pageCount = ((ByteData)this.Session[this.ImageDataSessionID]).PageCount;
        }
        ScriptManager.RegisterStartupScript(this, typeof(UserControl), "Init_Script", String.Format("Initialisation('{0}', {1}, {2}, {3}, {4}); ", this.ImageDataSessionID, this.HasValue ? "true" : "false", pageCount, ImageHeight, ImageWidth), true);

        base.OnPreRender(e);
    }
    # endregion
}
