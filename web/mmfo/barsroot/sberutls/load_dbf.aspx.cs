using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sberutls_load_dbf : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        divMsg.InnerText = String.Empty;
        divMsgOk.InnerText = String.Empty;
        string extension;

        // checks if file exists
        if (!fileUpload.HasFile)
        {
            divMsg.InnerText = "Не вибрано файл для завантаження!";
            return;
        }

        // checks file extension
        extension = Path.GetExtension(fileUpload.FileName).ToLower();

        if (!extension.Equals(".dbf"))
        {
            divMsg.InnerText = "Файл має розширення не *.DBF";
            return;
        }


        byte[] data = new byte[fileUpload.PostedFile.ContentLength - 1];
        data = fileUpload.FileBytes;

        //fileUpload.PostedFile.InputStream.Read(data, 0, fileUpload.PostedFile.ContentLength);
        //fileUpload.PostedFile.InputStream.Close();

        string tabname = Path.GetFileNameWithoutExtension(fileUpload.FileName).ToUpper();

        string EncodeFile = String.Empty;
        string EncodeData = String.Empty;
        int type=1;

        if (rbEncodeInpuFileDos.Checked)
        {
            EncodeFile = "DOS";
        }
        else
        {
            EncodeFile = "WIN";
        }

        if (rbEncodeInpuDataDos.Checked)
        {
            EncodeData = "DOS";
        }
        else
        {
            EncodeData = "WIN";
        }

        if(rb0.Checked)
        {
            type =0;
        }
        else if (rb1.Checked)
        {
            type = 1;
        }
        else if(rb2.Checked)
        {
            type = 2;
        }
        else if(rb3.Checked)
        {
            type = 3;
        }

        try
        {
            InitOraConnection();
            ClearParameters();
            SetParameters("data", DB_TYPE.Blob, data, DIRECTION.Input);
            SetParameters("tabname", DB_TYPE.Varchar2, 4000, tabname, DIRECTION.InputOutput);
            SetParameters("type", DB_TYPE.Int32, type, DIRECTION.Input);
            SetParameters("EncodeFile", DB_TYPE.Varchar2, EncodeFile, DIRECTION.Input);
            SetParameters("EncodeData", DB_TYPE.Varchar2, EncodeData, DIRECTION.Input);
            SQL_NONQUERY(@"begin
                            bars_dbf.load_dbf(:data, 
                                                :tabname, 
                                                :type, 
                                                :EncodeFile, 
                                                :EncodeData);
                           end;");
            divMsgOk.InnerText = "Створено таблицю з іменем '" + tabname + "'";
        }
        catch (Exception ex)
        {
            divMsg.InnerText = "Помилка завантаження файлу '" + fileUpload.FileName + "' (" + ex.Message + ")";
        }
        finally
        {
            DisposeOraConnection();
        }


    }
}