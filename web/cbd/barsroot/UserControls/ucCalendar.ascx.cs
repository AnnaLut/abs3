using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class ucCalendar : BarsWebPart
{
    public ucCalendar()
    {
        this.Title = "Календарь";
        this.Description = "Просмотр текущей даты и времени";
        this.TitleIconImageUrl = "/Common/Images/default/16/сalendar.png";
        this.CatalogIconImageUrl = "/Common/Images/default/16/сalendar.png"; 
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        tbCurDate.Text = DateTime.Now.ToLongDateString();
        Page.ClientScript.RegisterStartupScript(this.GetType(), "InitClock", "<script>StartClock('" + tbCurTime.ClientID + "');</script>");
    }
}
