using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Collections.Generic;
using Bars.Exception;
using credit;

using ibank.core;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

public partial class managerMaster : System.Web.UI.MasterPage
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    public String AlertPattern = "alert('{0}');";
    public String TitleFormat = "{0} - {1}";
    # endregion

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

    /// <summary>
    /// Отображение ошибок
    /// </summary>
    public void ShowError(String ErrorText)
    {
        dvErrorBlock.Style.Add(HtmlTextWriterStyle.Display, "block");
        lbErrorText.Text += (String.IsNullOrEmpty(lbErrorText.Text) ? "" : "<br/>") + ErrorText;
    }
    public void HideError()
    {
        dvErrorBlock.Style.Add(HtmlTextWriterStyle.Display, "none");
        lbErrorText.Text = "";
    }

    /// <summary>
    /// Чистка временных параметров сессии
    /// </summary>
    public void ClearSessionScans()
    {
        String Prefix1 = "IMAGE_DATA_";
        String Prefix2 = "SCANER_DATA_";

        System.Collections.ArrayList SessionKeys = new System.Collections.ArrayList(Session.Keys);
        for (int i = 0; i < SessionKeys.Count; i++)
        {
            String key = (String)SessionKeys[i];
            if (key.StartsWith(Prefix1) || key.StartsWith(Prefix2))
            {
                Object obj = Session[key];
                if (obj is IDisposable)
                    (obj as IDisposable).Dispose();
                Session.Remove(key);
            }
        }

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
