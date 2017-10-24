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

using System.Collections.Generic;
using credit;
using Bars.UserControls;

using Bars.Classes;
using ibank.core;

using System.IO;
using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.Zip;

public partial class credit_secretarycc_printdocs_multi : Bars.BarsPage
{
    # region Приватные свойства
    public String SRV_HIERARCHY
    {
        get
        {
            return Convert.ToString(Request.Params.Get("srvhr"));
        }
    }
    public String WS_ID
    {
        get
        {
            return "SRV_" + SRV_HIERARCHY;
        }
    }
    private String strBID_IDs
    {
        get
        {
            return Request.Params.Get("bid_ids");
        }
    }
    private List<Decimal> BID_IDs
    {
        get
        {
            return (new List<String>(strBID_IDs.Split(','))).ConvertAll<Decimal>(new Converter<string, decimal>(Convert.ToDecimal));
        }
    }
    # endregion

    # region События
    protected override void OnInit(EventArgs e)
    {
        // чистим сессию при входе
        if (!IsPostBack)
        {
            Master.ClearSessionScans();
        }

        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        // заголовок
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(strBID_IDs)), true);
    }
    protected void lv_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Print":

                String TemplateId = (e.CommandArgument as String).Split(';')[0];

                // рабочее пространство используется только для шаблонов служб,
                // допустимые раб. пространства SRV_TOBO, SRV_RU, SRV_CA
                // String WS_ID = (e.CommandArgument as String).Split(';')[1];

                Decimal WS_NUM = Convert.ToDecimal((e.CommandArgument as String).Split(';')[1]);
                String DOCEXP_TYPE_ID = (e.CommandArgument as String).Split(';')[2];

                String ZipFilePath = Path.GetTempPath() + TemplateId + ".zip";

                ZipOutputStream ZipFile = new ZipOutputStream(File.Create(ZipFilePath));
                ZipFile.SetLevel(9);

                foreach (Decimal BID_ID in BID_IDs)
                {
                    // параметры
                    FrxParameters pars = new FrxParameters();
                    pars.Add(new FrxParameter("p_bid_id", TypeCode.Decimal, BID_ID));
                    pars.Add(new FrxParameter("p_ws_id", TypeCode.String, WS_ID));
                    pars.Add(new FrxParameter("p_ws_number", TypeCode.Decimal, WS_NUM));

                    // объект
                    FrxDoc doc = new FrxDoc(
                        FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)),
                        pars,
                        this.Page);

                    // пофайловая пеачть
                    byte[] buffer = new byte[40960];

                    String EntryPath;
                    String FilePath;
                    switch (DOCEXP_TYPE_ID)
                    {
                        case "PDF":
                            EntryPath = TemplateId + "_" + BID_ID.ToString() + ".pdf";
                            FilePath = doc.Export(FrxExportTypes.Pdf);
                            break;
                        case "RTF":
                            EntryPath = TemplateId + "_" + BID_ID.ToString() + ".rtf";
                            FilePath = doc.Export(FrxExportTypes.Rtf);
                            break;
                        case "DOC":
                            EntryPath = TemplateId + "_" + BID_ID.ToString() + ".docx";
                            FilePath = doc.Export(FrxExportTypes.Word2007);
                            break;
                        default:
                            EntryPath = TemplateId + "_" + BID_ID.ToString() + ".pdf";
                            FilePath = doc.Export(FrxExportTypes.Pdf);
                            break;
                    }

                    ZipEntry Entry = new ZipEntry(EntryPath);
                    ZipFile.PutNextEntry(Entry);

                    FileStream fs = new FileStream(FilePath, FileMode.Open);
                    StreamUtils.Copy(fs, ZipFile, buffer);
                    fs.Close();

                    File.Delete(FilePath);
                }
                ZipFile.CloseEntry();
                ZipFile.Close();

                // выбрасываем в поток с одновременным удалением
                Response.WriteFile(ZipFilePath);
                Response.Flush();
                File.Delete(ZipFilePath);

                break;
        }
    }
    protected void bNext_Click(object sender, EventArgs e)
    {
        // возвращаемся в обработку заявок
        Response.Redirect(String.Format("/barsroot/credit/secretarycc/queries.aspx?srvhr={0}", SRV_HIERARCHY));
    }
    # endregion
}