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
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using Bars.Logger;

public partial class ussr_dbfdataview : Bars.BarsPage
{
    # region Приватные свойства
    private string Role = "WR_USSR_TECH";
    # endregion

    # region События страницы
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        ds.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(Role);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string sSource = (Session["source"] == null ? "" : Convert.ToString(Session["source"]));
        decimal nFileID = (Session["fileId"] == null ? 0 : Convert.ToDecimal(Session["fileId"]));

        switch (sSource)
        {
            case "dbfyproc":
                divTitle.InnerText = "Перегляд даних файлу Y (" + this.GetFileName(nFileID, "v_ussr_collation_files") + ")";
                ds.SelectCommand = ds.SelectCommand.Replace("DATA_TABLE", "v_ussr_collation_data");
                break;
            default:
                divTitle.InnerText = "Перегляд даних завантаженого файлу (" + this.GetFileName(nFileID, "v_ussr_dbf_files") + ")";
                ds.SelectCommand = ds.SelectCommand.Replace("DATA_TABLE", "v_ussr_dbf_data");
                break;
        }

        ds.SelectParameters.Add(new Parameter("file_id", TypeCode.Decimal, nFileID.ToString()));
    }

    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);
        //не использовать defaultButton при нажатии Enter
        gv.Attributes.Add("onkeypress", "if (event.keyCode == 13) return false;");
    }

    protected void hypExcel_Command(object sender, CommandEventArgs e)
    {
        gv.Export(Bars.DataComponents.ExportMode.Excel);
    }
    # endregion

    # region Приватные методы
    /// <summary>
    /// Имя файла по его ID
    /// </summary>
    /// <param name="nFileID">ID файла</param>
    /// <param name="sDataTable">Источник данных</param>
    private string GetFileName(decimal nFileID, string sDataTable)
    {
        string sRes = "";

        InitOraConnection();
        try
        {
            SetRole(Role);

            ClearParameters();
            SetParameters("pid", DB_TYPE.Decimal, nFileID, DIRECTION.Input);
            sRes = Convert.ToString(SQL_SELECT_scalar("select FILE_NAME from " + sDataTable + " where ID = :pid"));
        }
        finally
        {
            DisposeOraConnection();
        }

        return sRes;
    }
    # endregion
}
