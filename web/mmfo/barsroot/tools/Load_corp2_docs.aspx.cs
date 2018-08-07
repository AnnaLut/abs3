using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Globalization;
using System.Data;
using System.IO;

public partial class tools_Load_corp2_docs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


    }

    private void ShowError(String ErrorText)
    {
        //Response.Write("!" + ErrorText + "!");
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText.Replace("\n", "").Replace("\r", "") + "');", true);
    }

    protected void saveToFolders(object sender, EventArgs e)
    {
        using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
        using (OracleCommand cmd = con.CreateCommand())
        {
            cmd.CommandText = "  select 'card_tt' arx_name, f_zay_rtf_rar (:dat1, :dat2) from dual";
            cmd.Parameters.Add("dat1", OracleDbType.Date, DAT1.Value, ParameterDirection.Input);
            cmd.Parameters.Add("dat2", OracleDbType.Date, DAT2.Value, ParameterDirection.Input);

            using (OracleDataReader oraRdr = cmd.ExecuteReader())
            {
                if (oraRdr.Read())
                {
                    using (OracleBlob blob = oraRdr.GetOracleBlob(1))
                    {
                        string fileName = oraRdr.GetString(0);
                        fileName += ".rar";
                        if (blob.IsNull)
                        {
                            ShowError("Не знайденно документів на задану дату в Corp2!");
                        }
                        else
                        {
                            string tempFileName = Path.GetTempFileName();
                            Byte[] byteArr = new Byte[blob.Length];
                            blob.Read(byteArr, 0, Convert.ToInt32(blob.Length));
                            using (FileStream fs = new FileStream(tempFileName, FileMode.Append, FileAccess.Write))
                            {
                                fs.Write(byteArr, 0, byteArr.Length);
                            }
                            try
                            {
                                Response.ClearContent();
                                Response.ClearHeaders();
                                Response.AppendHeader("content-disposition", "attachment;filename=" + fileName);
                                Response.ContentType = "application/octet-stream";
                                Response.WriteFile(tempFileName, true);
                                Response.Flush();
                                Response.End();
                            }
                            finally
                            {
                                if (File.Exists(tempFileName))
                                    File.Delete(tempFileName);
                            }
                        }
                    }
                }
            }
        }
    }
}