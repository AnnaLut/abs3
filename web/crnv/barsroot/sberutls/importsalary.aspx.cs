using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using Bars.Classes;
using UnityBars.XmlForms.Engine;
using Bars.DataComponents;


public partial class sberutls_importsalary : Bars.BarsPage
{
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        String cs = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        salGrid.Controls.Add(XmlFormBuilder.BuildForm("frm_import_salary_grid", this.Page, cs, XmlFormPlaces.AppData, "barsroot.core"));

    }
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        divMsg.InnerText = String.Empty;
        divMsgOk.InnerText = String.Empty;

        if (fileUpload.PostedFile.FileName == String.Empty || fileUpload.PostedFile.ContentLength == 0)
        {
            divMsg.InnerText = "Файл не вибрано";
            return;
        }
        byte[] data = new byte[fileUpload.PostedFile.ContentLength];
        fileUpload.PostedFile.InputStream.Read(data, 0, fileUpload.PostedFile.ContentLength);
        fileUpload.PostedFile.InputStream.Close();
        String InputBuffer = Encoding.GetEncoding(1251).GetString(data);

        BarsGridViewEx gv = (BarsGridViewEx)Page.FindControl("gv");
        if (gv is BarsGridViewEx)
        {
            object acc = gv.SelectedDataKey.Values[0];
           // object kv = gv.SelectedDataKey.Values[1];
           // object nms = gv.SelectedDataKey.Values[2];
           // object okpo = gv.SelectedDataKey.Values[3];

            InitOraConnection();
            try
            {
                ClearParameters();
                SetParameters("p_transit_acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
             //   SetParameters("p_NLS_2924", DB_TYPE.Varchar2, nls, DIRECTION.Input);
             //   SetParameters("p_NMS_2924", DB_TYPE.Varchar2, nms, DIRECTION.Input);
             //   SetParameters("p_OKP_2924", DB_TYPE.Varchar2, okpo, DIRECTION.Input);
                SetParameters("p_File", DB_TYPE.Varchar2, Path.GetFileName(fileUpload.PostedFile.FileName), DIRECTION.Input);
                SetParameters("p_buffer", DB_TYPE.Clob, InputBuffer, DIRECTION.Input);
                SQL_NONQUERY(@"begin obpc.pay_clob(:p_transit_acc, :p_File, :p_buffer); end;");
                divMsgOk.InnerText = "Імпорт виконано без помилок";
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else
        {
            return;
        }
    }
}
