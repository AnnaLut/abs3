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

[Serializable]
public class ScannerInitParams
{
    # region Приватные свойства
    private Boolean _UseTwainInterface = false;

    private Int32 _TwainUnits = 0;
    private Int32 _TwainPixelType = 1;
    private Int32 _TwainResolution = 100;

    private Boolean _TwainAutoDeskew = true;
    private Boolean _TwainAutoBorder = true;

    private Boolean _AutoZoom = true;
    private Boolean _WaitForAcquire = true;
    private Boolean _ShowTwainProgress = true;

    private Int32 _Compression = 1;
    # endregion

    # region Публичные свойства
    public Boolean UseTwainInterface
    {
        get { return _UseTwainInterface; }
        set { _UseTwainInterface = value; }
    }

    public Int32 TwainUnits
    {
        get { return _TwainUnits; }
        set { _TwainUnits = value; }
    }
    public Int32 TwainPixelType
    {
        get { return _TwainPixelType; }
        set { _TwainPixelType = value; }
    }
    public Int32 TwainResolution
    {
        get { return _TwainResolution; }
        set { _TwainResolution = value; }
    }

    public Boolean TwainAutoDeskew
    {
        get { return _TwainAutoDeskew; }
        set { _TwainAutoDeskew = value; }
    }
    public Boolean TwainAutoBorder
    {
        get { return _TwainAutoBorder; }
        set { _TwainAutoBorder = value; }
    }

    public Boolean AutoZoom
    {
        get { return _AutoZoom; }
        set { _AutoZoom = value; }
    }
    public Boolean WaitForAcquire
    {
        get { return _WaitForAcquire; }
        set { _WaitForAcquire = value; }
    }
    public Boolean ShowTwainProgress
    {
        get { return _ShowTwainProgress; }
        set { _ShowTwainProgress = value; }
    }

    public Int32 Compression
    {
        get { return _Compression; }
        set { _Compression = value; }
    }
    # endregion

    # region Конструктор
    public ScannerInitParams()
    {
    }
    # endregion
}

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
    /// <summary>
    /// Загружен ли файл
    /// </summary>
    private Boolean HasValue
    {
        get
        {
            Boolean res = this.Session[this.ImageDataSessionID] != null;
            return res;
        }
    }
    private ScannerInitParams InitParams
    {
        get
        {
            if (ViewState["InitParams"] == null)
            {
                ScannerInitParams _InitParams = new ScannerInitParams();
                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                try
                {
                    OracleCommand cmd = new OracleCommand("select nvl(min(pg.val), 0) as val from params$global pg where pg.par = 'SCN_UINT'", con);
                    _InitParams.UseTwainInterface = (Convert.ToInt32(cmd.ExecuteScalar()) == 0 ? false : true);
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }

                ViewState["InitParams"] = _InitParams;
            }

            return (ScannerInitParams)ViewState["InitParams"];
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected override void OnPreRender(EventArgs e)
    {
        // кнопка просмотра
        ibView.Visible = this.HasValue;
        ibView.OnClientClick = String.Format("ViewClick('{0}'); return false;", this.ImageDataSessionID);

        // инициализация
        String InitParams_Script = String.Format(@" InitParams.UseTwainInterface = {0};
                                                    InitParams.TwainUnits = {1};
                                                    InitParams.TwainPixelType = {2};
                                                    InitParams.TwainResolution = {3};
                                                    InitParams.TwainAutoDeskew = {4};
                                                    InitParams.TwainAutoBorder = {5};
                                                    InitParams.AutoZoom = {6};
                                                    InitParams.WaitForAcquire = {7};
                                                    InitParams.ShowTwainProgress = {8};
                                                    InitParams.Compression = {9}; ",
                                                    InitParams.UseTwainInterface ? "true" : "false",
                                                    InitParams.TwainUnits,
                                                    InitParams.TwainPixelType,
                                                    InitParams.TwainResolution,
                                                    InitParams.TwainAutoDeskew ? "true" : "false",
                                                    InitParams.TwainAutoBorder ? "true" : "false",
                                                    InitParams.AutoZoom ? "true" : "false",
                                                    InitParams.WaitForAcquire ? "true" : "false",
                                                    InitParams.ShowTwainProgress ? "true" : "false",
                                                    InitParams.Compression);       
        ScriptManager.RegisterStartupScript(this, typeof(UserControl), "InitParams_Script", InitParams_Script, true);

        ScriptManager.RegisterStartupScript(this, typeof(UserControl), "Init_Script", String.Format("Initialisation('{0}', {1}); ", this.ImageDataSessionID, this.HasValue ? "true" : "false"), true);

        base.OnPreRender(e);
    }
    # endregion

    # region Веб-методы
    [WebMethod(EnableSession = true)]
    public static void DeleteAllFromMemory(String sid)
    {
        HttpContext.Current.Session.Remove(sid);
    }
    # endregion
}
