using System;
using barsroot.core;
using System.Web.UI;

public partial class cim_master : System.Web.UI.MasterPage
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
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
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Title"></param>
    public void SetPageTitle(String Title)
    {
        SetPageTitle(Title, false);
    }
    # endregion

    # region События
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        // подключаем скрипт локализации скриптов
        ScriptReference sr = new ScriptReference("/barsroot/cim/scripts/localization/" + WebUtility.GetCurrrentCulture() + ".js?v" + WebUtility.GetBuildVersion());
        MainScriptManager.Scripts.Add(sr);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="e"></param>
    protected override void OnPreRender(EventArgs e)
    {
        // устанавливаем заголовок страницы если он не пустой
        if (!String.IsNullOrEmpty(Page.Header.Title))
            SetPageTitle(Page.Header.Title);

        base.OnPreRender(e);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void MainScriptManager_AsyncPostBackError(object sender, AsyncPostBackErrorEventArgs e)
    {
        Exception ex = e.Exception;
        if (ex is System.Reflection.TargetInvocationException)
            ex = ex.InnerException;
    }
    # endregion
}
