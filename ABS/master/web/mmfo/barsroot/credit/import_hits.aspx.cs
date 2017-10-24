using System;
using System.IO;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.Text;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sberutls_import_ispro : Bars.BarsPage
{
    public string kf = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {


        try
        {

            InitOraConnection();

            SQL_Reader_Exec(@"select sys_context('bars_context','user_mfo') kf from dual");
            if (SQL_Reader_Read())
            {
                ArrayList reader = SQL_Reader_GetValues();
                kf = Convert.ToString(reader[0]);
            }


        }
        finally
        {
            SQL_Reader_Close();
            DisposeOraConnection();
        }



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



        string EncodeFile = String.Empty;
        string EncodeData = String.Empty;



        try
        {

            InitOraConnection();

            string tabname = "TMP_BANK_EMPLOYEE_" + kf;


            ClearParameters();
            SetParameters("data", DB_TYPE.Blob, data, DIRECTION.Input);
            SetParameters("tabname", DB_TYPE.Varchar2,  tabname, DIRECTION.InputOutput);
            SetParameters("type", DB_TYPE.Int32, 1, DIRECTION.Input);//Перестворюємо таблицю 
            SetParameters("EncodeFile", DB_TYPE.Varchar2, "WIN", DIRECTION.Input);
            SetParameters("EncodeData", DB_TYPE.Varchar2, "WIN", DIRECTION.Input);
            SQL_NONQUERY(@"begin
                            bars_dbf.load_dbf(:data, 
                                                :tabname, 
                                                :type, 
                                                :EncodeFile, 
                                                :EncodeData);
                           end;");
            divMsgOk.InnerText = "Завантажено файл '" + fileUpload.FileName + "'";


           // dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
           // String SelectCommand = @"select NMK, OKPO, SER, NUMDOC, null as PL from TMP_BANK_EMPLOYEE_" + kf;

          //  dsMain.SelectCommand = SelectCommand;
          //  dsMain.DataBind();
           // gvMain.DataBind();


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

    protected void btPay_Click(object sender, EventArgs e)
    {
        try
        {
            InitOraConnection();

            SQL_NONQUERY(@"declare n int; begin BARS.bank_employee(n); end;");

            dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            String SelectCommand = @"select NMK, OKPO,SER, NUMDOC,  PL from TMP_BANK_EMPLOYEE_PROT";

            dsMain.SelectCommand = SelectCommand;
            dsMain.DataBind();
            gvMain.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Увага", "alert('Встановлення признаку виконано успішно!');", true);
        }
        finally
        {
            DisposeOraConnection();
        }
    }
}