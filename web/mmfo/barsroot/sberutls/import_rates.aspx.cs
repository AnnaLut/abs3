using System;
using System.Text;
using System.IO;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Data;
using System.Globalization;

public partial class sberutls_import_rates : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btnLoad_Click(object sender, EventArgs e)
    {
        divMsg.InnerText = String.Empty;
        divMsgOk.InnerText = String.Empty;

        String Result = String.Empty;

        if (fileUpload.PostedFile.FileName == String.Empty || fileUpload.PostedFile.ContentLength == 0)
        {
            divMsg.InnerText = "Файл не вибрано";
            return;
        }
        byte[] data = new byte[fileUpload.PostedFile.ContentLength];
        fileUpload.PostedFile.InputStream.Read(data, 0, fileUpload.PostedFile.ContentLength);
        fileUpload.PostedFile.InputStream.Close();
        String InputBuffer = Encoding.GetEncoding(1251).GetString(data);

        OracleConnection con = OraConnector.Handler.UserConnection;
        try

        {
            //Debug row...
            if (fileUpload.FileName.Length>100)
                {
                  divMsg.InnerText = "Довжина файлу більше 100 символів!";
                  return;
                }

            OracleCommand cmd = con.CreateCommand();
            cmd.Parameters.Clear();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars.rates.load_file";
            cmd.Parameters.Add("P_FILENAME", OracleDbType.Varchar2, fileUpload.FileName, ParameterDirection.Input);
            cmd.Parameters.Add("P_FILE_BODY", OracleDbType.Clob, InputBuffer, ParameterDirection.Input);
            cmd.Parameters.Add("P_RETURN", OracleDbType.Varchar2, 4000, Result, ParameterDirection.Output);


            cmd.ExecuteNonQuery();

           Result = Convert.ToString(cmd.Parameters["P_RETURN"].Value);

        }
        finally
        {
            con.Close();
            con.Dispose();
        }


        if ((String.IsNullOrEmpty(Result)) || Result == "null")
        {
            divMsgOk.InnerText = "Імпорт виконано без помилок";
        }
        else
        {
            divMsg.InnerText = Result;
        }
    }
}