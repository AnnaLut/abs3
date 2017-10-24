using System;
using System.Text;
using System.IO;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Data;
using System.Data.OleDb;

public partial class sberutls_import_spr_mon : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string GetTemporaryDirectory()
    {
        
        string tempDirectory = Path.Combine(Path.GetTempPath(), "spr_mon");
        if(!Directory.Exists(tempDirectory))
        { 
        Directory.CreateDirectory(tempDirectory);
        }
        return tempDirectory;
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

        GetTemporaryDirectory();

        //string full_path = Path.Combine(Path.Combine(Path.GetTempPath(), Session.SessionID), "spr_mon.db");

        string full_path = Path.Combine(GetTemporaryDirectory(), "spr_mon.db");
        fileUpload.SaveAs(full_path);

        string path = GetTemporaryDirectory();


    OleDbConnection _connection = new OleDbConnection();
        StringBuilder ConnectionString = new StringBuilder("");
        ConnectionString.Append(@"Provider=Microsoft.Jet.OLEDB.4.0;");
        ConnectionString.Append(@"Extended Properties=Paradox 7.x;");
        ConnectionString.Append(@"Data Source="+ path +";");
        ConnectionString.Append(@"Mode=1;");
        _connection.ConnectionString = ConnectionString.ToString();
        InitOraConnection();
        try {
            _connection.Open();
            OleDbDataAdapter da = new OleDbDataAdapter("SELECT * FROM Spr_mon.db;", _connection);
            DataTable dt = new DataTable();
            da.Fill(dt);
            
            
           // Видаляємо все з довідника
            SQL_NONQUERY(@"begin
                            delete from spr_mon;
                             end;");
            //Порядково вставляємо
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string kod_money = Convert.ToString(dt.Rows[i].ItemArray[0]);
                string name_money = Convert.ToString(dt.Rows[i].ItemArray[1]);
                string name_metal = Convert.ToString(dt.Rows[i].ItemArray[2]);
                string nominal = Convert.ToString(dt.Rows[i].ItemArray[3]);
                string price = Convert.ToString(dt.Rows[i].ItemArray[4]);
                string pr_kupon  = Convert.ToString(dt.Rows[i].ItemArray[5]);
                string pr_no = Convert.ToString(dt.Rows[i].ItemArray[6]);

                ClearParameters();
                SetParameters("KOD_MONEY", DB_TYPE.Varchar2, kod_money, DIRECTION.Input);
                SetParameters("NAMEMONEY", DB_TYPE.Varchar2, name_money, DIRECTION.Input);
                SetParameters("NAMEMETAL", DB_TYPE.Varchar2, name_metal, DIRECTION.Input);
                SetParameters("NOMINAL", DB_TYPE.Varchar2, nominal, DIRECTION.Input);
                SetParameters("PRICE", DB_TYPE.Varchar2, price, DIRECTION.Input);
                SetParameters("PR_KUPON", DB_TYPE.Varchar2, pr_kupon, DIRECTION.Input);
                SetParameters("PR_NO", DB_TYPE.Varchar2, pr_no, DIRECTION.Input);
                SQL_NONQUERY(@"begin
                               insert into spr_mon(KOD_MONEY, NAMEMONEY, NAMEMETAL, NOMINAL, PRICE, PR_KUPON,  PR_NO) 
                                values(:KOD_MONEY, :NAMEMONEY, :NAMEMETAL, :NOMINAL, :PRICE, :PR_KUPON,  :PR_NO);
                                end;");

                divMsgOk.InnerText = "Імпорт виконано без помилок";

            }
            da.Dispose();
        }

        catch (Exception ex)
        {
            divMsg.InnerText="Можливо не вірна структура, або не встановлено BDE на сервері("+ex.Message+")";
        }
       

        finally
        {
            
           
            _connection.Close();
            DisposeOraConnection();
            File.Delete(full_path);
         //  Directory.Delete(path, true);
        }

    }
}