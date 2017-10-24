using System;
using System.IO;
using System.Text;

public partial class swi_imp_bic : Bars.BarsPage
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

        if (!extension.Equals(".xml"))
        {
            divMsg.InnerText = "Файл має розширення не *.XML";
            return;
        }
        byte[] data = new byte[fileUpload.PostedFile.ContentLength];
        fileUpload.PostedFile.InputStream.Read(data, 0, fileUpload.PostedFile.ContentLength);
        fileUpload.PostedFile.InputStream.Close();

        var fileData = Encoding.GetEncoding(1251).GetString(data);

        try
        {
            InitOraConnection();
            ClearParameters();
            SetParameters("file_name", DB_TYPE.Varchar2, fileUpload.FileName, DIRECTION.Input);
            SetParameters("data", DB_TYPE.Clob, fileData, DIRECTION.Input);
            SetParameters("file_name2", DB_TYPE.Varchar2, fileUpload.FileName, DIRECTION.Input);
            SetParameters("file_name3", DB_TYPE.Varchar2, fileUpload.FileName, DIRECTION.Input);
            SQL_NONQUERY(@"begin
                            insert into imp_file(file_name, file_clob) values(:file_name,:data);
                            IMP_XML_SWIFT_BIC(:file_name2,0);
                            delete from imp_file where file_name= :file_name3;
                           end;");
            divMsgOk.InnerText = "Імпорт виконано без помилок!";
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