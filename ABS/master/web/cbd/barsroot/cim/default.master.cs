using System;
using System.Linq;
using Bars.DataComponents;
using barsroot.core;
using System.Web.UI;
using barsroot.cim;
using System.Collections.Generic;
using System.Collections;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;

public static class ControlExtensions
{
    /// <summary>
    /// recursively finds a child control of the specified parent.
    /// </summary>
    /// <param name="control"></param>
    /// <param name="id"></param>
    /// <returns></returns>
    public static Control FindControlRecursive(this Control control, string id)
    {
        if (control == null) return null;
        //try to find the control at the current level
        Control ctrl = control.FindControl(id);

        if (ctrl == null)
        {
            //search the children
            foreach (Control child in control.Controls)
            {
                ctrl = FindControlRecursive(child, id);

                if (ctrl != null) break;
            }
        }
        return ctrl;
    }
}

public partial class cim_master : System.Web.UI.MasterPage
{
    # region Приватные свойства
    private string[] scripts = new string[]
    {
        "/Common/jquery/jquery.js",
        //"//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js",
            "/Common/jquery/jquery-ui.1.8.js",
            //"//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js",
            "/Common/jquery/jquery.ui.datepicker-uk.js",
            "/Common/jquery/jquery.validate.js",
            "/Common/jquery/additional-methods.js",
            "/Common/jquery/jquery.cookies.js",
            "/Common/jquery/jquery.blockUI.js",
            "/Common/jquery/jquery.custom.js",
            "/Common/jquery/jquery.alerts.js",
            //"/Common/jquery/jquery.numeric.js",
            "/Common/jquery/jquery.inputmask.bundle.js",
            "/Common/jquery/jquery.bgiframe.js",
            //"/Common/jquery/jquery.fixedheadertable.js",
            "/Common/Script/json.js",
            //"/Common/jquery/jquery.jqGrid.js",
            "~/cim/scripts/common.js"
    };

    # endregion

    # region Публичные свойства
    public String TitleFormat = "{0} - {1}";
    public string BuildVersion = (CimManager.IsDebug) ? ("t" + DateTime.Now.Ticks) : ("t00030");
    # endregion

    # region Публичные методы
    /// <summary>
    /// Заголовок страницы
    /// </summary>
    public void SetPageTitle(String Title, Boolean OverWrite)
    {
        if (String.IsNullOrEmpty(lbPageTitle.Text) || OverWrite)
            lbPageTitle.Text = Title;

        ScriptManager sm = ScriptManager.GetCurrent(Page);
        for (int i = 0; i < scripts.Length; i++)
            sm.Scripts.Add(new ScriptReference(scripts[i] + "?v" + CimManager.Version));
    }

    /// <summary>
    /// Добавить на страницу скрипт с добавлением хвостика-версии
    /// </summary>
    /// <param name="src"></param>
    public void AddScript(string src)
    {
        ScriptManager.GetCurrent(this.Page).Scripts.Add(new ScriptReference(string.Format("{0}?v{1}.{2}", src, CimManager.Version, BuildVersion)));
    }

    public void WriteMessage(Control ctrl, string message, MessageType type)
    {
        System.Drawing.Color color = System.Drawing.Color.Green;
        switch (type)
        {
            case MessageType.Error: color = System.Drawing.Color.Red; break;
            case MessageType.Warning: color = System.Drawing.Color.Yellow; break;
            case MessageType.Info: color = System.Drawing.Color.Black; break;
            case MessageType.Success: color = System.Drawing.Color.Green; break;
        }

        if (ctrl is Label)
        {
            Label lbl = ctrl as Label;
            lbl.Text = message;
            lbl.ForeColor = color;
        }
    }

    /// <summary>
    /// Добавить блок инициализации 
    /// </summary>
    /// <param name="initParams"></param>
    public void AddInitScript(string initParams)
    {
        if (!this.Page.ClientScript.IsStartupScriptRegistered(this.GetType(), "init"))
            this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "init", initParams, true);
    }

    public void HideTitle()
    {
        divTitle.Visible = false;
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
        dvVersion.InnerText = "v. " + CimManager.Version;
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("uk");
        cinfo.NumberFormat.NumberDecimalSeparator = ".";
        cinfo.DateTimeFormat.DateSeparator = "/";
        Thread.CurrentThread.CurrentCulture = cinfo;

        // Инициализация переменных в сессии
        if (!IsPostBack)
        {
            if (Session[barsroot.cim.Constants.StateKeys.BankDate] == null)
            {
                new CimManager(true);
            }
        }
    }


    string[] gridIds = new[] { "gvVCimContracts", "gvVCimUnboundPayments", "gvVCimUnboundVmd", "gvCimTradePrimPayments", "gvCimBoundPrimVmd", "gvCimTradeSecondPayments", "gvCimBoundSecondVmd", "gvVCimBoundPayments", "gvCimBoundVmd" };
    /// <summary>
    /// 
    /// </summary>
    /// <param name="e"></param>
    protected override void OnPreRender(EventArgs e)
    {
        // устанавливаем заголовок страницы если он не пустой
        if (!String.IsNullOrEmpty(Page.Header.Title))
            SetPageTitle(Page.Header.Title);

        try
        {
            ////
            foreach (var gridId in gridIds)
            {
                Control ctrl = this.FindControlRecursive(gridId);
                if (ctrl is BarsGridViewEx)
                {
                    BarsGridViewEx gv = (BarsGridViewEx)ctrl;
                    string sessionKey = string.Format("cim.filter{0}{1}", ctrl.ID, Request["contr_id"]);
                    if (gv.FilterState.Count > 0)
                        Session[sessionKey] = gv.FilterState;
                    else if (Session[sessionKey] != null)
                    {
                        if (!IsPostBack)
                        {
                            gv.FilterState = (List<Filter>)Session[sessionKey];
                            hlClearFilter.Visible = true;
                            //gv.DataBind();
                        }
                        else
                            Session[sessionKey] = null;
                    }
                }
            }
        }
        catch
        {
        }
        ////

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
        decimal? rec_id = 0;
        Session[barsroot.cim.Constants.StateKeys.LastError] = ErrorHelper.AnalyzeException(ex, ref rec_id);
        Session[barsroot.cim.Constants.StateKeys.LastErrorRecID] = rec_id;
    }
    # endregion
    protected void hlClearFilter_Click(object sender, EventArgs e)
    {
        var sessionObjects = new List<string>();
        foreach (var key in Session.Keys)
        {
            string sKey = Convert.ToString(key);
            if (sKey.StartsWith("cim.filter"))
                sessionObjects.Add(sKey);
        }
        foreach (var sessionObject in sessionObjects)
            Session.Remove(sessionObject);

        Response.Redirect(Request.Url.AbsoluteUri);
    }
}
