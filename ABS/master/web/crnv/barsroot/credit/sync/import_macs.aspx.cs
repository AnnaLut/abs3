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
using System.Drawing;

using Bars.Classes;
using ibank.core;

using System.IO;
using System.Xml;
using System.Xml.Schema;
using System.Text;

public partial class credit_sync_import_macs : Bars.BarsPage
{
    # region Приватные свойства
    // Validation Error Message
    static string ErrorMessage = "";
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void btUpload_Click(object sender, EventArgs e)
    {
        if (fu.HasFile)
        {
            // проверяем расширение файла
            String FileExt = fu.PostedFile.FileName.Substring(fu.PostedFile.FileName.LastIndexOf(".") + 1);

            // проверяем что файл XML
            if (FileExt.ToUpper() != "XML")
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "file_not_xml", String.Format("alert('{0}');", "Выбран не XML файл!"), true);
                return;
            }

            // проверяем файл на соответсвие схеме
            String XMLText = new StreamReader(fu.FileContent).ReadToEnd();
            String XSDPath = Server.MapPath("/barsroot/credit/sync/sbpmacs_schema.xsd");

            ErrorMessage = String.Empty;
            String ValidationResult = Validate(XMLText, XSDPath);

            if (!String.IsNullOrEmpty(ValidationResult))
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "validation_errors", String.Format("alert('{0}');", "Ошибки проверки синтаксиса файла: " + ValidationResult.Replace("'", "")), true);
                return;
            }

            // загружаем в БД и отображаем протокол
            Decimal? ErrorCode;
            String Protocol;

            BbConnection con = new BbConnection();
            Common cmn = new Common(con);
            try
            {
                cmn.wu.IMPORT_SBPMACS(XMLText, out ErrorCode, out Protocol);
            }
            finally
            {
                con.CloseConnection();
            }

            lProtocol.Text = Protocol;
            pnlImpProtocol.ForeColor = (ErrorCode.HasValue ? Color.Red : Color.Black);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "file_not_selected", String.Format("alert('{0}');", "Файл не выбран!"), true);
            return;
        }
    }

    public static void ValidationHandler(object sender,
                                         ValidationEventArgs args)
    {
        ErrorMessage += args.Message + "; ";
    }
    # endregion

    # region Приватные методы
    public String Validate(string XMLText, string XSDPath)
    {
        String Res = String.Empty;

        try
        {
            // Declare local objects
            XmlTextReader tr = null;
            XmlSchemaCollection xsc = null;
            XmlValidatingReader vr = null;

            // Text reader object
            tr = new XmlTextReader(XSDPath);
            xsc = new XmlSchemaCollection();
            xsc.Add(null, tr);

            // XML validator object
            vr = new XmlValidatingReader(XMLText,
                         XmlNodeType.Document, null);
            vr.Schemas.Add(xsc);

            // Add validation event handler
            vr.ValidationType = ValidationType.Schema;
            vr.ValidationEventHandler +=
                     new ValidationEventHandler(ValidationHandler);

            // Validate XML data
            while (vr.Read()) ;
            vr.Close();

            // XML validation results (empty if OK)
            Res = ErrorMessage;
        }
        catch (Exception error)
        {
            Res = error.Message;
        }

        return Res;
    }
    # endregion


}