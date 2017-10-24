using System;
using System.Text;
using System.IO;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Data;
using System.Globalization;

public partial class sberutls_import_vip : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btnLoad_Click(object sender, EventArgs e)
    {
        divMsg.InnerText = String.Empty;
        divMsgOk.InnerText = String.Empty;

        String mfo;
        String rnk;
        String flag;
        String text;
        String dat_begin;
        String dat_end;
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

        string aLine = null;
        StringReader strReader = new StringReader(InputBuffer);
        int i = 0;
        CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
        ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
        ci.DateTimeFormat.DateSeparator = ".";
        bool stop = true;




        while (stop)
        {
            aLine = strReader.ReadLine();





            if (aLine != null)
            {
                if (i == 0)
                {
                    i = 1;
                    continue;

                }

                string[] words = aLine.Split('\t');

                mfo = Convert.ToString(words[0]);
                rnk = Convert.ToString(words[1]);
                flag = Convert.ToString(words[2]);
                text = Convert.ToString(words[3]);
                dat_begin = Convert.ToString(words[4]);
                dat_end = Convert.ToString(words[5]);

                OracleConnection con = OraConnector.Handler.UserConnection;
               try

                {
                   

                    OracleCommand cmd = con.CreateCommand();
                    cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "load_vip";
                    cmd.Parameters.Add("P_MFO", OracleDbType.Varchar2, mfo.Trim(), ParameterDirection.Input);
                    cmd.Parameters.Add("P_RNK", OracleDbType.Varchar2, rnk.Trim(), ParameterDirection.Input);
                    cmd.Parameters.Add("P_VIP", OracleDbType.Varchar2, flag.Trim(), ParameterDirection.Input);
                    cmd.Parameters.Add("P_KVIP", OracleDbType.Varchar2, text.Trim(), ParameterDirection.Input);
                    cmd.Parameters.Add("P_DATBEG", OracleDbType.Date, Convert.ToDateTime(dat_begin, ci), ParameterDirection.Input);
                    cmd.Parameters.Add("P_DATEND", OracleDbType.Date, Convert.ToDateTime(dat_end, ci), ParameterDirection.Input);
                    cmd.Parameters.Add("P_RETURN", OracleDbType.Varchar2, 4000, Result, ParameterDirection.Output);
                    cmd.Parameters.Add("p_COMMENTS", OracleDbType.Varchar2, "", ParameterDirection.Input);

                    cmd.ExecuteNonQuery();

                    Result = Convert.ToString(cmd.Parameters["P_RETURN"].Value);                    

                }
                finally
                {
                    con.Close();
                }


            }
            else
            {
                stop = false;
                continue;
            }
        }
        if ((String.IsNullOrEmpty(Result))|| Result =="null")
        {
            divMsgOk.InnerText = "Імпорт виконано без помилок";
        }
        else
        {
            divMsg.InnerText = Result;
        }
    }
}