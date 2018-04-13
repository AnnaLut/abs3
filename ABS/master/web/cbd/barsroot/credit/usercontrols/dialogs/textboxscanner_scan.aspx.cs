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

using System.Web.Services;

using Bars.UserControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

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
            return Request.Params.Get("sid");
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
