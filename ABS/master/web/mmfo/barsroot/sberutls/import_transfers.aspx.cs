using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Security.Cryptography.Xml;
using System.Xml;

public partial class sberutls_import_transfers : Bars.BarsPage
{
    const string ErrorPrefix = "ERROR: ";
    const string InfoPrefix = "INFO : ";
    const string WarnPrefix = "WARN : ";
    static X509Certificate2 certForCheck = new X509Certificate2();

    // Verify the signature of an XML file against an asymmetric 
    // algorithm and return the result.
    public Boolean VerifyXml(XmlDocument Doc, X509Certificate2 cert)
    {
        // Check arguments.
        if (Doc == null)
            throw new ArgumentException("Doc");
        if (cert == null)
            throw new ArgumentException("Key");

        // Create a new SignedXml object and pass it
        // the XML document class.
        SignedXml signedXml = new SignedXml(Doc);

        // Find the "Signature" node and create a new
        // XmlNodeList object.
        XmlNodeList nodeList = Doc.GetElementsByTagName("Signature");

        // Throw an exception if no signature was found.
        if (nodeList.Count <= 0)
        {
            throw new CryptographicException(ErrorPrefix + "Не найдено поля подпису у файл.");
        }

        // This example only supports one signature for
        // the entire XML document.  Throw an exception 
        // if more than one signature was found.
        if (nodeList.Count >= 2)
        {
            throw new CryptographicException("Verification failed: More that one signature was found for the document.");
        }

        // Load the first <signature> node.  
        signedXml.LoadXml((XmlElement)nodeList[0]);

        // Check the signature and return the result.
        return signedXml.CheckSignature(cert, true);
    }
    static bool CertificateValidationCallback(
         object sender,
         System.Security.Cryptography.X509Certificates.X509Certificate certificate,
         System.Security.Cryptography.X509Certificates.X509Chain chain,
         System.Net.Security.SslPolicyErrors sslPolicyErrors)
    {
        certForCheck = new X509Certificate2(certificate);
        return true;
    }

    protected void Page_Load(object sender, EventArgs e)
    {

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

        var fileData = Encoding.GetEncoding(1251).GetString(data);
        XmlDocument xmlDoc = new XmlDocument();

        xmlDoc.PreserveWhitespace = true;
        try
        {
            xmlDoc.LoadXml(fileData);
        }
        catch (Exception ex)
        {
            tbMessage.Text = ex.Message;
            return;
        }

        tbMessage.Text = string.Format("Файл {0} завантажено.", Path.GetFileName(fileUpload.PostedFile.FileName)) + Environment.NewLine;

        string certNamePrefix = (cbProfix.Checked) ? ("sw") : ("gm");
        string certFilePath = string.Format("{0}{1}.cer", Server.MapPath("/barsroot/App_Data/cert/"), certNamePrefix);
        if (!File.Exists(certFilePath))
        {
            tbMessage.Text += "Не знайдено сертифікату для перевірки підпису [" + certFilePath + "]" + Environment.NewLine;
            return;
        }
        certForCheck = new X509Certificate2(certFilePath);
        bool result = VerifyXml(xmlDoc, certForCheck);

        if (result)
        {
            tbMessage.Text += "Пiдпис на файлi вiрний. (сертифiкат " + certForCheck.SubjectName.Name + ")" + Environment.NewLine;
        }
        else
        {
            tbMessage.Text += "Помилка перевiрки пiдпису. (сертифiкат " + certForCheck.SubjectName.Name + ")" + Environment.NewLine;
            tbMessage.Text += "Подальший іморт данних неможливий" + Environment.NewLine;
            lblResBad.Visible = true;
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

                    SetParameters("p_indoc", DB_TYPE.Clob, fileData, DIRECTION.Input);
                    BeginTransaction();
                    try
                    {
                        int chunkSize = 3999;
                        int stringLength = fileData.Length;
                        for (int i = 0; i < stringLength; i += chunkSize)
                        {
                            if (i + chunkSize > stringLength) chunkSize = stringLength - i;
                            ClearParameters();
                            SetParameters("p_id", DB_TYPE.Decimal, i + 1, DIRECTION.Input);
                            SetParameters("p_doc", DB_TYPE.Clob, fileData.Substring(i, chunkSize), DIRECTION.Input);
                            SQL_NONQUERY("INSERT INTO TMP_LOB(ID,STRDATA) VALUES(:p_id, :p_doc)");
                        }

                        //
                        SQL_NONQUERY("begin monex.GET_FIle(0); end;");
                        lblResOk.Visible = true;
                        tbMessage.Text += "Файл успішно оброблено." + Environment.NewLine;
                    }
                    catch (Exception ex)
                    {
                        string message = ex.Message;
                        if (ex.Message.StartsWith("ORA-20"))
                            message = ex.Message.Substring(10, ex.Message.IndexOf("ORA-", 10) - 10);
                        tbMessage.Text += "Помилка виконання процедури: " + message + Environment.NewLine;
                    }
                    finally
                    {
                        Commit();
                        lblResBad.Visible = !lblResOk.Visible;
                    }
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
            tbMessage.Text += Environment.NewLine;
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