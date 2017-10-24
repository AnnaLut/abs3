using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ins_ins_master : System.Web.UI.MasterPage
{
    # region Публичные методы
    /// <summary>
    /// Заголовок страницы
    /// </summary>
    public void SetPageTitle(String Title, Boolean OverWrite)
    {
        if (String.IsNullOrEmpty(lbPageTitle.Text) || OverWrite)
            lbPageTitle.Text = Title;
    }
    public void SetPageTitle(String Title)
    {
        SetPageTitle(Title, false);
    }
    # endregion
    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected override void OnPreRender(EventArgs e)
    {
        // устанавливаем заголовок страницы если он не пустой
        if (!String.IsNullOrEmpty(Page.Header.Title))
            SetPageTitle(Page.Header.Title);

        base.OnPreRender(e);
    }
    # endregion
}
