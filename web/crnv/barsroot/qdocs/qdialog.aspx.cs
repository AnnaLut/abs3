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

public partial class QDialog : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        literal.Text = Convert.ToString(null == Request.QueryString["dlg_text"] ? Session["dlg_text"] : Request.QueryString["dlg_text"]);
        this.Title = Convert.ToString(null == Request.QueryString["dlg_title"] ? Session["dlg_title"] : Request.QueryString["dlg_title"]);
        pnl.GroupingText = this.Title;
        Hashtable ht = (Hashtable)Session["dlg_buttons"];
        if (null == ht) return;
        foreach (DictionaryEntry de in ht)
        {
            Button btn = new Button();
            btn.Text = de.Key.ToString();
            btn.CssClass = "DockRight";
            btn.PostBackUrl = de.Value.ToString();
            btnHolder.Controls.Add(btn);
        }
    }
}
