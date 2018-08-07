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

public partial class tools_Load_tikets_cp : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request["REF"]))
        {
            Tb_ref.Text = Request["REF"];

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                cmd.ExecuteNonQuery();
                cmd.Parameters.Add("ref_", OracleDbType.Varchar2, Tb_ref.Text, ParameterDirection.Input);
                cmd.CommandText = (@"select ref, ticket from v_stickets where ref =  :ref_ ");
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    TB_ticets.Text = rdr["TICKET"] == DBNull.Value ? (String)null : (String)rdr["TICKET"];
                    TB_ticets.Enabled = true;
                    TB_ticets.ReadOnly = true;
                    Bt_save.Enabled = true;
                }
                else
                {
                    TB_ticets.Enabled = true;
                    TB_ticets.ReadOnly = true;
                    TB_ticets.Text = "Не вдалось знайти тікет в архіві.";
                    Bt_save.Enabled = false;
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
    protected void saveToFolders(object sender, ImageClickEventArgs e)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "select to_char(ref), STIKET from v_stickets where ref =  :ref_";
            cmd.Parameters.Add("ref_", OracleDbType.Varchar2, Tb_ref.Text, ParameterDirection.Input);

            OracleDataReader oraRdr = cmd.ExecuteReader();
            if (oraRdr.Read())
            {
                using (OracleBlob blob = oraRdr.GetOracleBlob(1))
                {
                    string fileName = oraRdr.GetString(0);
                    fileName += ".txt";
                    if (blob.IsNull)
                    {
                        //res.Message = "Не знайденно друкованої форми по документу ref=" + docRef + " в таблиці імпортованих з corp2!";
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
            cmd.Dispose();
            oraRdr.Close();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
}