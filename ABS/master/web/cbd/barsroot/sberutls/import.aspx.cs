using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Xml;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Runtime.InteropServices;
using System.Collections;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using Bars.Configuration;
using Bars.DataComponents;
using Bars.Oracle;
using Bars.Classes;


public partial class sberutls_import : Bars.BarsPage
{
    // Наименование форматов
    [DllImport(("xml_loader.dll"))]
    static extern string getLoadDllDescription(int DllId);

    [DllImport(("xml_loader.dll"))]
    static extern string getLoadDllVersion(int DllId);

    [DllImport(("xml_loader.dll"))]
    static extern string getLoadDllLibsConfig(int DllId);
    
    [DllImport(("xml_loader.dll"))]
    static extern int ConvertBufferEx(int DllNum, string InputFileName, string InputBuffer, out IntPtr buffer, out IntPtr bufferSize, StringBuilder res, int resSize);

    //освобождает буфер
    [DllImport(("xml_loader.dll"))]
    static extern int ReleaseBuffer(int DllNum, out IntPtr buffer, int bufferSize);

    [DllImport(("xml_loader.dll"))]
    static extern string GetLastError();

    [DllImport(("xml_loader.dll"))]
    static extern string getLoadDllLastError(int DllNum);

    private int getCurrType()
    {
        if (Request["imptype"] == "lz")
            return 1;
        else if (Request["imptype"] == "kp")
            return 2;
        else
            throw new Exception("Не коректнi параметри URL");
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        divCaption.InnerHtml = "Iмпорт документiв - <b>" + getLoadDllDescription(getCurrType()) + "</b>";
        divDllinfo.InnerHtml = "version:" + getLoadDllVersion(getCurrType()) + ", config: " + getLoadDllLibsConfig(getCurrType());
        if (!IsPostBack)
        {
        }
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        tbMessage.Text = "";
        lblResOk.Visible = false;
        lblResBad.Visible = false;
        //продолжить только если что-то загружено
        if (fileUpload.PostedFile.FileName == String.Empty || fileUpload.PostedFile.ContentLength == 0)
        {
            return;
        }

        byte[] data = new byte[fileUpload.PostedFile.ContentLength];
        fileUpload.PostedFile.InputStream.Read(data, 0, fileUpload.PostedFile.ContentLength);
        fileUpload.PostedFile.InputStream.Close();

        //преобразовать в XML
        IntPtr buffer = IntPtr.Zero;
        IntPtr bufferSize = IntPtr.Zero;
        int resSize = 4096;
        StringBuilder res = new StringBuilder(resSize);
        
        String InputBuffer = Encoding.GetEncoding(1251).GetString(data);
        int r = ConvertBufferEx(getCurrType(), fileUpload.FileName, InputBuffer, out buffer, out bufferSize, res, resSize);
        if (r == -1)
        {
            tbMessage.Text = res.ToString();
            return;
        }

        try
        {
            OracleDecimal retCode = 0;
            try
            {
                InitOraConnection();
                try
                {
                    SetRole("OPER000");
                    ClearParameters();
                    SetParameters("p_packname", DB_TYPE.Varchar2, fileUpload.FileName, DIRECTION.Input);
                    SetParameters("p_indoc", DB_TYPE.Clob, Marshal.PtrToStringAnsi(buffer), DIRECTION.Input);
                    SetParameters("p_retcode", DB_TYPE.Decimal, retCode, DIRECTION.Output);
                    BeginTransaction();
                    try
                    {
                        SQL_NONQUERY(@"
                        begin 
                            bars_xmlklb.IMPORT_DOC (
                                p_packname => :p_packname , 
                                p_indoc => :p_indoc, 
                                p_retcode => :p_retcode); 
                        end;");
                        retCode = (OracleDecimal)GetParameter("p_retcode");

                        SQL_Reader_Exec("select * from tmp_impklbx");
                        while (SQL_Reader_Read())
                        {
                            string line =
                                "файл: " + SQL_Reader_GetValues()[0].ToString() +
                                " рядок: " + SQL_Reader_GetValues()[1].ToString() +
                                " № документа:" + SQL_Reader_GetValues()[2].ToString() +
                                " код помилки:" + SQL_Reader_GetValues()[3].ToString() +
                                " текст помилки:" + SQL_Reader_GetValues()[4].ToString();
                            tbMessage.Text += line + Environment.NewLine;
                        }
                        SQL_Reader_Close();
                    }
                    finally
                    {
                        //фиксация изменений в случае успешной загрузки всех документов
                        if (!retCode.IsNull && 0 == retCode.Value)
                        {
                            Commit();
                        }
                        else
                        {
                            RollbackTransaction();
                        }
                    }

                    lblResOk.Visible = retCode.Value == 0;
                    lblResBad.Visible = retCode.Value != 0;
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
            catch (OracleException E)
            {
                tbMessage.Text += E.Message;
            }
        }
        finally
        {
            ReleaseBuffer(getCurrType(), out buffer, bufferSize.ToInt32());
            tbMessage.Text += Environment.NewLine;
            tbMessage.Text += getLoadDllLastError(getCurrType()) +
                Environment.NewLine + Environment.NewLine; 
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
}
