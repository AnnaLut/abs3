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

public partial class BarsWebPartManagerPanel : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["OptionMode"] != null && (bool)Session["OptionMode"] == true)
        {
            divControls.Visible = true;
            divImg.Visible = false;
            switch(BarsPartManager.DisplayMode.Name.ToLower())
            {
                case "browse": lbModeValue.Text = cmdBrowseView.Text; break;
                case "edit": lbModeValue.Text = cmdEditView.Text; break;
                case "design": lbModeValue.Text = cmdDesignView.Text; break;
                case "catalog": lbModeValue.Text = cmdCatalogView.Text; break;
                default: lbModeValue.Text = ""; break;
            }
        }
        else
        {
            divControls.Visible = false;
            divImg.Visible = true;
        }
    }
    protected void cmdBrowseView_Click(object sender, EventArgs e)
    {
        BarsPartManager.DisplayMode = WebPartManager.BrowseDisplayMode;
        lbModeValue.Text = cmdBrowseView.Text;
    }
    protected void cmdDesignView_Click(object sender, EventArgs e)
    {
        BarsPartManager.DisplayMode = WebPartManager.DesignDisplayMode;
        lbModeValue.Text = cmdDesignView.Text;
    }
    protected void cmdEditView_Click(object sender, EventArgs e)
    {
        BarsPartManager.DisplayMode = WebPartManager.EditDisplayMode;
        lbModeValue.Text = cmdEditView.Text;
    }
    protected void cmdClear_Click(object sender, EventArgs e)
    {
        BarsPartManager.Personalization.ResetPersonalizationState();
    }
    protected void cmdCatalogView_Click(object sender, EventArgs e)
    {
        BarsPartManager.DisplayMode = WebPartManager.CatalogDisplayMode;
        lbModeValue.Text = cmdCatalogView.Text;
    }
    protected void lnShowOptions_Click(object sender, EventArgs e)
    {
        divControls.Visible = true;
        divImg.Visible = false;
        Session["OptionMode"] = true;
    }
    protected void cmdHide_Click(object sender, EventArgs e)
    {
        divControls.Visible = false;
        divImg.Visible = true;
        Session["OptionMode"] = false;
    }
}
