using System;
using System.Data;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;
using System.Data.Odbc;
using System.Runtime.InteropServices;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using Bars.Logger;
using Bars.Configuration;

/*
 Дополнительные шаги
 1. Увеличить maxRequestLength в machine.config
 2. Установить ODBC драйверы для Centura
 */

public partial class ussr_dbfimp : Bars.BarsPage
{
    private UssrDbfImp dbf;

    private bool bShowSecureButtons
    {
        get 
        {
            if (Session["SSBUTTONS"] == null)
            {
                InitOraConnection();
                try
                {
                    object res = SQL_SELECT_scalar(@"select nvl(decode(gval,0,0,lval),0) as val  
                                                     from ( select max(decode(par, 'DBFIMPG', val, null)) as gval, max(decode(par, 'DBFIMPL', val, null)) as lval
                                                            from params
                                                            where par in ('DBFIMPL', 'DBFIMPG' )
                                                          )");
                    Session["SSBUTTONS"] = (1 == Convert.ToInt16(res));
                }
                finally { DisposeOraConnection(); }
            }

            return (bool)Session["SSBUTTONS"];
        }
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        dbf = new UssrDbfImp();
        dbf.Log += new LogEventHandler(dbfLog);
        btnGetLog.Enabled = bShowSecureButtons;
        btnLoad.Enabled = bShowSecureButtons;
        fileUpload.Enabled = bShowSecureButtons;
    }

    void dbfLog(object sender, LogEventArgs e)
    {
        if (e.SeverityType == LogSeverityType.Info)
        {
            tbMessage.ForeColor = System.Drawing.Color.Black;
        }
        else
        {
            tbMessage.ForeColor = System.Drawing.Color.Red;
        }
        tbMessage.Text = e.Text;
        DBLogger.Info("ussr_imp.web_intf: " + e.Text);
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        if (fileUpload.HasFile)
        {
            //
            // временный каталог
            //
            string tempDir = Path.GetTempPath() + "\\dbfimp\\";
            if (!Directory.Exists(tempDir))
            {
                Directory.CreateDirectory(tempDir);
            }

            //
            // временный файл
            //
            string fileName = Path.GetFileName(fileUpload.FileName);
            string tempFile = tempDir + Path.GetFileNameWithoutExtension(fileName) + "___" + Context.Session.SessionID + Path.GetExtension(fileName);
            if (File.Exists(tempFile))
            {
                File.Delete(tempFile);
            }

            //
            // upload файла
            //
            fileUpload.SaveAs(tempFile);

            //
            // импорт файла
            //
            dbf.Import(tempFile);
            gv.DataBind();
        }
        else
        {
        }
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToString() != "Sort" && e.CommandName.ToString() != "Page")
        {
            int fileId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "DeleteFile":
                    dbf.deleteFile(fileId);
                    break;
                case "Start":
                    dbf.createDeposits(fileId);
                    break;
                case "ViewGood":
                    Session["fileId"] = fileId;
                    Response.Redirect("dbfdataview.aspx");
                    break;
                case "ViewBad":
                    Session["fileId"] = fileId;
                    Response.Redirect("dbferrview.aspx");
                    break;
            }
        }
    }

    protected void btnGetLog_Click(object sender, EventArgs e)
    {
        HttpResponse response = HttpContext.Current.Response;
        string attachment = "attachment; filename=import.txt";
        response.ClearContent();
        response.BufferOutput = true;
        response.AddHeader("content-disposition", attachment);
        response.ContentType = "text/plain";
        response.Charset = "utf-8";
        response.ContentEncoding = Encoding.GetEncoding(1251);
        response.Write(tbMessage.Text);
        response.Flush();
        response.End();

    }
    protected void gv_PreRender(object sender, EventArgs e)
    {
        //не использовать defaultButton при нажатии Enter
        gv.Attributes.Add("onkeypress", "if (event.keyCode == 13) return false;");

    }
    protected void ibExportExcel_Click(object sender, ImageClickEventArgs e)
    {
        gv.Export(Bars.DataComponents.ExportMode.Excel);
    }
    protected void ibExportExcel_Click1(object sender, ImageClickEventArgs e)
    {
        gv.DataBind();
    }

    public bool ShowGoodButton(object oTotalCount, object oErrCount)
    {
        int nTotalCount = Convert.ToInt32(oTotalCount);
        int nErrCount = Convert.ToInt32(oErrCount);

        bool bRes = this.bShowSecureButtons && (nTotalCount > nErrCount);

        return bRes;
    }
    public bool ShowBadButton(object oTotalCount, object oErrCount)
    {
        int nTotalCount = Convert.ToInt32(oTotalCount);
        int nErrCount = Convert.ToInt32(oErrCount);

        bool bRes = (nErrCount > 0);

        return bRes;
    }
}
