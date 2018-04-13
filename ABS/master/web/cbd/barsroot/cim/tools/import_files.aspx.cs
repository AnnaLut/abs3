using System;
using System.Collections.Generic;
using System.IO;
using System.Data;
using System.Web;
using barsroot.cim;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using Oracle.DataAccess.Client;
using DotNetDBF;
using System.Text;

public partial class cim_tools_import_files : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title, true);
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btImportF98);
    }
    private string convertToWin(object source)
    {
        return Convert.ToString(source).Replace('ў', 'і').Replace('Ў', 'І').Replace('•', 'ї').Replace('Ї', 'Є').Replace('°', 'Ї').Replace('∙', '_').Trim();
    }

    protected void btImportF98_Click(object sender, EventArgs e)
    {
        Master.WriteMessage(lbInfo, string.Empty, MessageType.Info);

        if (fuF98.HasFile)
        {
            try
            {
                string tempDir = Path.Combine(Path.GetTempPath(), "F98");
                if (!Directory.Exists(tempDir))
                    Directory.CreateDirectory(tempDir);
                string tempFile = Path.Combine(tempDir, Path.GetFileName(fuF98.FileName));
                if (File.Exists(tempFile))
                    File.Delete(tempFile);
                fuF98.SaveAs(tempFile);

                Master.WriteMessage(lbInfo, "Розпочата обробка файлу, зачекайте ...", MessageType.Info);

                DBFReader dr = new DBFReader(tempFile);
                dr.CharEncoding = Encoding.GetEncoding(866);

                if (dr.RecordCount > 0)
                {
                    OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
                    try
                    {
                        if (con.State != ConnectionState.Open)
                            con.Open();
                        OracleCommand command = new OracleCommand();
                        command.Connection = con;
                        command.CommandText = "delete from cim_f98";
                        command.ExecuteNonQuery();

                        OracleDataAdapter da = new OracleDataAdapter("select * from cim_f98", con);
                        OracleCommandBuilder cb = new OracleCommandBuilder(da);
                        DataTable odt = new DataTable();
                        da.Fill(odt);

                        for (int i = 0; i < dr.RecordCount; i++)
                        {
                            List<object> row = new List<object>(dr.NextRecord());
                            if (row[1] == null) continue;
                            for (int j = 0; j < row.Count; j++)
                            {
                                if (row[j] != null && row[j].GetType() == typeof(string))
                                    row[j] = convertToWin(row[j]); 
                                    
                            }

                            DataRow newrow = odt.NewRow();
                            newrow.ItemArray = row.ToArray();
                            odt.Rows.Add(newrow);

                            /*command.CommandText = "insert into cim_f98 (np,dt,ek_pok,ko,mfo,nkb,ku,prb,k030,v_sank,ko_1,r1_1,r2_1,k020,datapod,nompod,djerpod,nakaz,datanak,nomnak,datpodsk,nompodsk,djerpods,datnaksk,nomnaksk,sanksia1,srsank11,srsank12,r4,r030,t071,k040,bankin,adrin,data_m) " +
                            "values (:np,:dt,:ek_pok,:ko,:mfo,:nkb,:ku,:prb,:k030,:v_sank,:ko_1,:r1_1,:r2_1,:k020,:datapod,:nompod,:djerpod,:nakaz,:datanak,:nomnak,:datpodsk,:nompodsk,:djerpods,:datnaksk,:nomnaksk,:sanksia1,:srsank11,:srsank12,:r4,:r030,:t071,:k040,:bankin,:adrin,:data_m)";
                            command.Parameters.Clear();
                            command.Parameters.Add("np", OracleDbType.Varchar2, row[0], ParameterDirection.Input);
                            command.Parameters.Add("dt", OracleDbType.Date, row[1], ParameterDirection.Input);
                            command.Parameters.Add("ek_pok", OracleDbType.Varchar2, row[2], ParameterDirection.Input);
                            command.Parameters.Add("ko", OracleDbType.Varchar2, row[3], ParameterDirection.Input);
                            command.Parameters.Add("mfo", OracleDbType.Varchar2, row[4], ParameterDirection.Input);
                            command.Parameters.Add("nkb", OracleDbType.Varchar2, row[5], ParameterDirection.Input);
                            command.Parameters.Add("ku", OracleDbType.Varchar2, row[6], ParameterDirection.Input);
                            command.Parameters.Add("prb", OracleDbType.Varchar2, row[7], ParameterDirection.Input);
                            command.Parameters.Add("k030", OracleDbType.Decimal, row[8], ParameterDirection.Input);
                            command.Parameters.Add("v_sank", OracleDbType.Decimal, row[9], ParameterDirection.Input);
                            command.Parameters.Add("ko_1", OracleDbType.Varchar2, row[10], ParameterDirection.Input);
                            command.Parameters.Add("r1_1", OracleDbType.Varchar2, convertToWin(row[11]), ParameterDirection.Input);
                            command.Parameters.Add("r2_1", OracleDbType.Varchar2, convertToWin(row[12]), ParameterDirection.Input);
                            command.Parameters.Add("k020", OracleDbType.Varchar2, row[13], ParameterDirection.Input);
                            command.Parameters.Add("datapod", OracleDbType.Date, row[14], ParameterDirection.Input);
                            command.Parameters.Add("nompod", OracleDbType.Varchar2, row[15], ParameterDirection.Input);
                            command.Parameters.Add("djerpod", OracleDbType.Varchar2, convertToWin(row[16]), ParameterDirection.Input);
                            command.Parameters.Add("nakaz", OracleDbType.Varchar2, convertToWin(row[17]), ParameterDirection.Input);
                            command.Parameters.Add("datanak", OracleDbType.Date, row[18], ParameterDirection.Input);
                            command.Parameters.Add("nomnak", OracleDbType.Varchar2, row[19], ParameterDirection.Input);
                            command.Parameters.Add("datpodsk", OracleDbType.Date, row[20], ParameterDirection.Input);
                            command.Parameters.Add("nompodsk", OracleDbType.Varchar2, row[21], ParameterDirection.Input);
                            command.Parameters.Add("djerpods", OracleDbType.Varchar2, row[22], ParameterDirection.Input);
                            command.Parameters.Add("datnaksk", OracleDbType.Date, row[23], ParameterDirection.Input);
                            command.Parameters.Add("nomnaksk", OracleDbType.Varchar2, row[24], ParameterDirection.Input);
                            command.Parameters.Add("sanksia1", OracleDbType.Varchar2, convertToWin(row[25]), ParameterDirection.Input);
                            command.Parameters.Add("srsank11", OracleDbType.Date, row[26], ParameterDirection.Input);
                            command.Parameters.Add("srsank12", OracleDbType.Date, row[27], ParameterDirection.Input);
                            command.Parameters.Add("r4", OracleDbType.Varchar2, convertToWin(row[28]), ParameterDirection.Input);
                            command.Parameters.Add("r030", OracleDbType.Varchar2, row[29], ParameterDirection.Input);
                            command.Parameters.Add("t071", OracleDbType.Decimal, row[30], ParameterDirection.Input);
                            command.Parameters.Add("k040", OracleDbType.Varchar2, convertToWin(row[31]), ParameterDirection.Input);
                            command.Parameters.Add("bankin", OracleDbType.Varchar2, convertToWin(row[32]), ParameterDirection.Input);
                            command.Parameters.Add("adrin", OracleDbType.Varchar2, convertToWin(row[33]), ParameterDirection.Input);
                            command.Parameters.Add("data_m", OracleDbType.Date, row[34], ParameterDirection.Input);
                            command.ExecuteNonQuery();*/
                        }
                        da.Update(odt);

                        da.Dispose();
                        command.Dispose();
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                        dr.Close();
                    }
                }
                Master.WriteMessage(lbInfo, "Файл успішно завантажено! Оброблено " + dr.RecordCount + " стрічок", MessageType.Success);
                /*DataTable dt = CreateDataFromDbf(Path.GetFileNameWithoutExtension(tempFile), Path.GetDirectoryName(tempFile));
                File.Delete(tempFile);

                if (dt.Rows.Count == 0)
                {
                    Master.WriteMessage(lbInfo, "Пустий файл даних!", MessageType.Error);
                    return;
                }

                OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
                try
                {
                    if (con.State != ConnectionState.Open)
                        con.Open();
                    OracleCommand command = new OracleCommand();
                    command.Connection = con;
                    command.CommandText = "delete from cim_f98";
                    command.ExecuteNonQuery();

                    OracleDataAdapter da = new OracleDataAdapter("select * from cim_f98", con);
                    OracleCommandBuilder cb = new OracleCommandBuilder(da);
                    DataTable odt = dt.Clone();
                    da.Fill(odt);
                    Response.Write("<BR>");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        DataRow row = dt.Rows[i];
                        DataRow newrow = odt.NewRow();


                        //for (int j = 0; j < row.ItemArray.Length; j++)
                        // {
                        //   object obj = row.ItemArray[j];
                        //if (typeof(obj) == typeof(string))
                        //row.ItemArray[j] = CimManager.StrDosToWin(Convert.ToString(obj));
                        //}
                        newrow.ItemArray = row.ItemArray;
                        Response.Write(newrow.ItemArray[11]);


                        odt.Rows.Add(newrow);
                    }

                    Encoding encoder = Encoding.UTF8;

                    for (int i = 0; i < odt.Columns.Count; i++)
                    {
                        if (odt.Columns[i].DataType == typeof(string))
                            for (int j = 0; j < odt.Rows.Count; j++)
                            {
                                string oldStr = odt.Rows[j][i].ToString();
                                //odt.Rows[j][i] = Encoding.GetEncoding(1251).GetString(encoder.GetBytes(oldStr)); ///CimManager.StrDosToWin(oldStr);
                                //odt.Rows[j][i] = convertToWin(oldStr); 
                            }
                    }




                    da.Update(odt);

                    da.Dispose();
                 */
            }
            catch (Exception ex)
            {
                Master.WriteMessage(lbInfo, "Помилка обробки файлу [" + ex.Message + "]", MessageType.Error);
                return;
            }
            /*
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                if (dt.Columns[i].DataType == typeof(string))
                    for (int j = 0; j < dt.Rows.Count; j++)
                    {
                        string oldStr = dt.Rows[j][i].ToString();
                        dt.Rows[j][i] = oldStr.Replace('ў', 'і').Replace('Ў', 'І').Replace('•', 'ї').Replace('Ї', 'Є').Replace('°', 'Ї').Replace('•', '_');
                    }
            }*/


        }
        else
        {
            Master.WriteMessage(lbInfo, "Виберіть файл для імпорту!", MessageType.Error);
        }
    }
}