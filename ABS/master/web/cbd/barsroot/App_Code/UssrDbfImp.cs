using System;
using System.Data;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;
using System.Data.Odbc;
using System.Runtime.InteropServices;
using ICSharpCode.SharpZipLib.Zip;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using Bars.Logger;


public class UssrDbfException : Exception
{
    public UssrDbfException(string message) : base(message) { }
}

/// <summary>
/// Типы сообщений
/// </summary>
public enum LogSeverityType
{
    Info,
    Error
}
public enum PathType
{
    Error,
    Done,
    Empty
}
public enum ResultTypes
{
    Error,
    Success,
    Empty
}

public class LogEventArgs : EventArgs
{
    public LogSeverityType SeverityType;
    public readonly string Text;
    public LogEventArgs(string Text, LogSeverityType SeverityType)
    {
        this.SeverityType = SeverityType;
        this.Text = Text;
    }
}
public class FileLoadedEventArgs : EventArgs
{
    public readonly int fileId;
    public readonly string filePath;    
    public readonly string fileName;
    public readonly string logText;
    public readonly ResultTypes resultType;
    public FileLoadedEventArgs(int fileId, string filePath, string fileName, string logText, ResultTypes resultType)
    {
        this.fileId = fileId;
        this.filePath = filePath;
        this.fileName = fileName;
        this.logText = logText;
        this.resultType = resultType;        
    }
}

public delegate void LogEventHandler(object sender, LogEventArgs e);
public delegate void FileLoadedEventHandler(object sender, FileLoadedEventArgs e);

public class UssrDbfImp
{
    public string[] aFileTypes = { "C", "X", "B", "D" };

    public static string sEmptyDir = "empty";
    public static string sErrorDir = "error";
    public static string sDoneDir = "done";
    public string sType2FilesOutDir = "out";

    public event LogEventHandler Log;
    public event EventHandler RowLoaded;
    public event FileLoadedEventHandler FileLoaded;

    public UssrDbfImp()
    {
    }

    private void log(LogEventArgs e)
    {
        if (Log != null)
            Log(this, e);
    }

    [DllImport("kernel32.dll")]
    static extern int GetShortPathName(string longPath, StringBuilder buffer, int bufferSize);
    private string getShortPathName(string path)
    {
        StringBuilder buffer = new StringBuilder(256);
        GetShortPathName(path, buffer, buffer.Capacity);
        return buffer.ToString();
    }

    private string getElapsed(DateTime startDate)
    {
        TimeSpan elapsed = DateTime.Now - startDate;
        string res = " (  часу витрачено: " +
            elapsed.Hours.ToString() + ":" +
            elapsed.Minutes.ToString() + ":" +
            elapsed.Seconds.ToString() + " " +
            elapsed.Milliseconds.ToString() + ")";
        return res;
    }

    private string convertToWin(object source)
    {
        Encoding win1251 = Encoding.GetEncoding(1251);
        byte[] srcBytes = win1251.GetBytes(source.ToString());
        byte[] dstBytes = Encoding.Convert(Encoding.GetEncoding(866), win1251, srcBytes);
        return win1251.GetString(dstBytes);
    }

    public static string GetPath(PathType type, string dbfPath)
    {
        string sDir;
        if (type == PathType.Error) sDir = sErrorDir;
        else if (type == PathType.Done) sDir = sDoneDir;
        else sDir = sEmptyDir;

        string res = Path.GetDirectoryName(dbfPath) +
            Path.DirectorySeparatorChar + sDir + 
            Path.DirectorySeparatorChar + DateTime.Now.ToString("dd-MM-yyyy") +
            Path.DirectorySeparatorChar + Path.GetFileNameWithoutExtension(dbfPath) + 
            DateTime.Now.ToString("_HHmmss") + Path.GetExtension(dbfPath);

        if (!Directory.Exists(Path.GetDirectoryName(res)))
        {
            Directory.CreateDirectory(Path.GetDirectoryName(res));
        }

        return res;
    }

    bool HasColumn(OdbcDataReader rdr, string sColName)
    {
        DataTable dtSchema = rdr.GetSchemaTable();
        bool bResult = false;

        for (int i = 0; i < dtSchema.Rows.Count; i++)
            if (dtSchema.Rows[i]["ColumnName"].ToString().ToUpper() == sColName.ToUpper())
            {
                bResult = true;
                break;
            }

        return bResult;
    }

    private bool IsDateFieldsOk(OdbcDataReader rdr)
    {
        bool bRes = true;
        string[] sFields = { "data_id", "d_pasport", "data_b", "dato" };

        foreach (string sField in sFields)
        {
            bool bHasRow = false;
            foreach (DataRow row in rdr.GetSchemaTable().Rows)
                if (sField.ToLower() == row["ColumnName"].ToString().ToLower())
                {
                    bHasRow = true;
                    if (((Type)row["DataType"]).Name.ToLower() != "datetime") bRes = false;
                    break;
                }
            if (!bHasRow)
            {
                bRes = false;
                break;
            }
        }

        return bRes;
    }
    public bool Import(string dbfPath)
    {

        DateTime startDate = DateTime.Now;
        int totalRows = 1;
        decimal totalSum = 0;
        string curLogText = string.Empty;
        bool isEmpty = false;

        log(new LogEventArgs("\n  -------------------------------------------------------  \n", LogSeverityType.Info));
        log(new LogEventArgs(String.Format("\nІмпорт файлу {0} ... \n", Path.GetFileName(dbfPath)), LogSeverityType.Info));
        
        // идентификатор файла 
        int fileId = 0;

        // имя файла с отсеченной информации о сессии
        string dbfPathWithoutSession = dbfPath.IndexOf("___") == -1 ? dbfPath : dbfPath.Substring(1, dbfPath.IndexOf("___") - 1) + Path.GetExtension(dbfPath);

        // Соединение и старт транзакции
        OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
        if (con.State == ConnectionState.Closed) con.Open();

        OracleTransaction tx = con.BeginTransaction();
        bool txCommited = false;

        try
        {
            // роль
            OracleCommand command = new OracleCommand();
            command.Connection = con;
            command.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_USSR_TECH");
            command.ExecuteNonQuery();

            // трассировка
            //!!!
            //command.Connection = con;
            //command.CommandText = "alter session set sql_trace=true";
            //command.ExecuteNonQuery();

            //command.CommandText = "alter session set timed_statistics=true";
            //command.ExecuteNonQuery();

            // Получение данных dbf файла в DataTable
            DataTable dt = new DataTable(Path.GetFileName(dbfPath));
            OdbcConnection dbfCon = new OdbcConnection("Driver={Centura dBASE 32-bit Driver (*.dbf)}"); dbfCon.Open();
            OdbcCommand dbfCmd = new OdbcCommand("SELECT * FROM " + getShortPathName(Path.GetDirectoryName(dbfPath)) + Path.DirectorySeparatorChar + Path.GetFileName(dbfPath), dbfCon);
            OdbcDataReader rdr = dbfCmd.ExecuteReader();
            try
            {
                

                // Смотрим пустой ли файл
                if (!rdr.Read())
                {
                    dbfCon.Close();

                    curLogText += "Вибрано пустий файл данних\n";
                    log(new LogEventArgs(curLogText, LogSeverityType.Info));
                    
                    // событие обработки файла
                    if (FileLoaded != null) FileLoaded(this, new FileLoadedEventArgs(-1, dbfPath, Path.GetFileName(dbfPath), curLogText, ResultTypes.Empty));

                    isEmpty = true;
                    return false;
                }

                // Проверяем наличие полей типа даты
                if (!IsDateFieldsOk(rdr))
                {
                    dbfCon.Close();

                    curLogText += "Невірна структура файлу данних. Поля дати не знайдені або невірного типу.\n";
                    log(new LogEventArgs(curLogText, LogSeverityType.Info));

                    // событие обработки файла
                    FileLoaded(this, new FileLoadedEventArgs(-1, dbfPath, Path.GetFileName(dbfPath), curLogText, ResultTypes.Error));

                    isEmpty = true;
                    return false;
                }

                // создать заголовок файла
                bool bIsNewStruct = (HasColumn(rdr, "nsc2") && HasColumn(rdr, "sum2"));

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Clear();
                command.Parameters.Add("p_filename", OracleDbType.Varchar2, 12, Path.GetFileName(dbfPathWithoutSession), ParameterDirection.Input);
                command.Parameters.Add("p_filever", OracleDbType.Int32, bIsNewStruct ? 1 : 0, ParameterDirection.Input);
                command.Parameters.Add("p_fileid", OracleDbType.Int32, ParameterDirection.Output);
                command.CommandText = "ussr_imp.create_file_header";
                command.ExecuteNonQuery();

                // получить id заголовка файла
                object res = command.Parameters["p_fileid"].Value;

                if (res != null) fileId = Convert.ToInt32(res.ToString());
                else throw new UssrDbfException("Помилка при створеннi заголовка файлу\n");

                // подготовка к загрузке данных файла
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "ussr_imp.import_dbf_line";

                # region Добавить параметры
                command.Parameters.Clear();
                command.Parameters.Add("rec_num", OracleDbType.Decimal, ParameterDirection.Input);
                command.Parameters.Add("name", OracleDbType.Varchar2, 120, ParameterDirection.Input);
                command.Parameters.Add("f_name", OracleDbType.Varchar2, 20, ParameterDirection.Input);
                command.Parameters.Add("l_name", OracleDbType.Varchar2, 20, ParameterDirection.Input);
                command.Parameters.Add("icod", OracleDbType.Varchar2, 10, ParameterDirection.Input);
                command.Parameters.Add("s_pasport", OracleDbType.Varchar2, 7, ParameterDirection.Input);
                command.Parameters.Add("n_pasport", OracleDbType.Varchar2, 10, ParameterDirection.Input);
                command.Parameters.Add("d_pasport", OracleDbType.Date, ParameterDirection.Input);
                command.Parameters.Add("w_pasport", OracleDbType.Varchar2, 120, ParameterDirection.Input);
                command.Parameters.Add("post_index", OracleDbType.Varchar2, 10, ParameterDirection.Input);
                command.Parameters.Add("rg_adres", OracleDbType.Varchar2, 40, ParameterDirection.Input);
                command.Parameters.Add("a_adres", OracleDbType.Varchar2, 50, ParameterDirection.Input);
                command.Parameters.Add("c_adres", OracleDbType.Varchar2, 50, ParameterDirection.Input);
                command.Parameters.Add("s_adres", OracleDbType.Varchar2, 120, ParameterDirection.Input);
                command.Parameters.Add("b_adres", OracleDbType.Varchar2, 8, ParameterDirection.Input);
                command.Parameters.Add("b_adres_l", OracleDbType.Varchar2, 1, ParameterDirection.Input);
                command.Parameters.Add("r_adres", OracleDbType.Varchar2, 3, ParameterDirection.Input);
                command.Parameters.Add("r_adres_l", OracleDbType.Varchar2, 1, ParameterDirection.Input);
                command.Parameters.Add("data_b", OracleDbType.Date, ParameterDirection.Input);
                command.Parameters.Add("region", OracleDbType.Decimal, 2, ParameterDirection.Input);
                command.Parameters.Add("otdel", OracleDbType.Varchar2, 5, ParameterDirection.Input);
                command.Parameters.Add("filial", OracleDbType.Varchar2, 5, ParameterDirection.Input);
                command.Parameters.Add("vklad", OracleDbType.Varchar2, 40, ParameterDirection.Input);
                command.Parameters.Add("val", OracleDbType.Decimal, 3, ParameterDirection.Input);
                command.Parameters.Add("n_analit", OracleDbType.Varchar2, 19, ParameterDirection.Input);
                command.Parameters.Add("nsc", OracleDbType.Varchar2, 19, ParameterDirection.Input);
                command.Parameters.Add("dato", OracleDbType.Date, ParameterDirection.Input);
                command.Parameters.Add("nom_dog", OracleDbType.Varchar2, 10, ParameterDirection.Input);
                command.Parameters.Add("ost", OracleDbType.Decimal, ParameterDirection.Input);
                command.Parameters.Add("proc", OracleDbType.Decimal, ParameterDirection.Input);
                command.Parameters.Add("sum_proc", OracleDbType.Decimal, ParameterDirection.Input);
                command.Parameters.Add("ost_proc", OracleDbType.Decimal, ParameterDirection.Input);
                command.Parameters.Add("sum", OracleDbType.Decimal, ParameterDirection.Input);
                command.Parameters.Add("dbcode", OracleDbType.Varchar2, 11, ParameterDirection.Input);
                command.Parameters.Add("data_id", OracleDbType.Date, ParameterDirection.Input);
                command.Parameters.Add("total_rol", OracleDbType.Decimal, ParameterDirection.Input);
                command.Parameters.Add("attr", OracleDbType.Decimal, ParameterDirection.Input);
                command.Parameters.Add("nsc2", OracleDbType.Varchar2, 21, ParameterDirection.Input);
                command.Parameters.Add("sum2", OracleDbType.Decimal, ParameterDirection.Input);
                # endregion Добавить параметры

                // Цикл по всем строкам 
                do
                {
                    # region Нумерация полей
                    /*
                0	NAME        Character   120   0
                1	F_NAME      Character   20    0
                2	L_NAME      Character   20    0
                3	ICOD        Character   10    0
                4	DBCOD       Character   11    0
                5	DATA_ID     Date        8     0
                6	S_PASPORT   Character   2     0
                7	N_PASPORT   Character   6     0
                8	D_PASPORT   Date        8     0
                9	W_PASPORT   Character   120   0
                10	POST_INDEX  Character   10    0
                11	RG_ADRES    Character   40    0
                12	A_ADRES     Character   50    0
                13	C_ADRES     Character   50    0
                14	S_ADRES     Character   120   0
                15	B_ADRES     Character   8     0
                16	B_ADRES_L   Character   1     0
                17	R_ADRES     Character   3     0
                18	R_ADRES_L   Character   1     0
                19	DATA_B      Date        8     0
                20	REGION      Character   2     0
                21	OTDEL       Character   5     0
                22	FILIAL      Character   5     0
                23	VKLAD       Character   40    0
                24	VAL         Character   3     0
                25	N_ANALIT    Character   19    0
                26	NSC         Character   19    0
                27	DATO        Date        8     0
                28	NOM_DOG     Character   10    0
                29	ATTR        Character   6     0
                30	OST         Numeric     14    2
                31	PROC        Numeric     6     2
                32	SUM_PROC    Numeric     14    2
                33	OST_PROC    Numeric     14    2
                34	SUM         Numeric     14    2
                35	TOTAL_ROL   Numeric     14    2
                */
                    # endregion Нумерация полей

                    // установить значения параметров
                    command.Parameters["rec_num"].Value = totalRows;
                    command.Parameters["name"].Value = rdr["name"];
                    command.Parameters["f_name"].Value = rdr["f_name"];
                    command.Parameters["l_name"].Value = rdr["l_name"];
                    command.Parameters["icod"].Value = rdr["icod"];
                    command.Parameters["dbcode"].Value = rdr["dbcod"];
                    command.Parameters["data_id"].Value = rdr["data_id"];
                    command.Parameters["s_pasport"].Value = rdr["s_pasport"];
                    command.Parameters["n_pasport"].Value = rdr["n_pasport"];
                    command.Parameters["d_pasport"].Value = rdr["d_pasport"];
                    command.Parameters["w_pasport"].Value = rdr["w_pasport"];
                    command.Parameters["post_index"].Value = rdr["post_index"];
                    command.Parameters["rg_adres"].Value = rdr["rg_adres"];
                    command.Parameters["a_adres"].Value = rdr["a_adres"];
                    command.Parameters["c_adres"].Value = rdr["c_adres"];
                    command.Parameters["s_adres"].Value = rdr["s_adres"];
                    command.Parameters["b_adres"].Value = rdr["b_adres"];
                    command.Parameters["b_adres_l"].Value = rdr["b_adres_l"];
                    command.Parameters["r_adres"].Value = rdr["r_adres"];
                    command.Parameters["r_adres_l"].Value = rdr["r_adres_l"];
                    command.Parameters["data_b"].Value = rdr["data_b"];
                    command.Parameters["region"].Value = rdr["region"];
                    command.Parameters["otdel"].Value = rdr["otdel"];
                    command.Parameters["filial"].Value = rdr["filial"];
                    command.Parameters["vklad"].Value = rdr["vklad"];
                    command.Parameters["val"].Value = rdr["val"];
                    command.Parameters["n_analit"].Value = rdr["n_analit"];
                    command.Parameters["nsc"].Value = rdr["nsc"];
                    command.Parameters["dato"].Value = rdr["dato"];
                    command.Parameters["nom_dog"].Value = rdr["nom_dog"];
                    command.Parameters["attr"].Value = rdr["attr"];
                    command.Parameters["ost"].Value = rdr["ost"];
                    command.Parameters["proc"].Value = rdr["proc"];
                    command.Parameters["sum_proc"].Value = rdr["sum_proc"];
                    command.Parameters["ost_proc"].Value = rdr["ost_proc"];
                    command.Parameters["sum"].Value = rdr["sum"];
                    command.Parameters["total_rol"].Value = rdr["total_rol"];
                    command.Parameters["nsc2"].Value = HasColumn(rdr, "nsc2") ? rdr["nsc2"] : null;
                    command.Parameters["sum2"].Value = HasColumn(rdr, "sum2") ? rdr["sum2"] : null;

                    command.ExecuteNonQuery();

                    //подсчет общей суммы и общего кол-ва строк
                    totalRows += 1;
                    decimal ost_proc = rdr["ost_proc"] == DBNull.Value ? 0 : Convert.ToDecimal(rdr["ost_proc"]);
                    decimal total_rol = rdr["total_rol"] == DBNull.Value ? 0 : Convert.ToDecimal(rdr["total_rol"]);
                    totalSum += (ost_proc - total_rol);
                    
                    if (RowLoaded != null)
                    {
                        RowLoaded(this, new EventArgs());
                    }
                }
                while (rdr.Read());

                //подкорректировать кол-во строк
                totalRows -= 1;
            }
            finally
            {
                // убиваем соединение с ДБФ и ридер
                if (null != dbfCon) dbfCon.Close();
                if (null != rdr) rdr.Close();
            }

            log(new LogEventArgs(String.Format("Досягнено кінець файлу {0} \n", Path.GetFileName(dbfPath)), LogSeverityType.Info));

            // Установка дополнительных атрибутов файла
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Clear();
            command.Parameters.Add("total_rows", OracleDbType.Decimal, totalRows , ParameterDirection.Input);
            command.Parameters.Add("total_sum", OracleDbType.Decimal, totalSum, ParameterDirection.Input);                         
            command.CommandText = "ussr_imp.set_header_attrs";
            command.ExecuteNonQuery();

            // завершение транзакции
            tx.Commit();
            txCommited = true;
            //txCommited = false;

            curLogText += "Файл успiшно оброблено. Iмпортовано " + (totalRows).ToString() + " рядкiв " + getElapsed(startDate) + "\n";
            log(new LogEventArgs(curLogText, LogSeverityType.Info));
        }
        catch (OracleException ex)
        {
            if (ex.Message.IndexOf("USS-00006")>-1) // ошибка импорта ?
            {
                // покажем протокол импорта
                OracleCommand cmd_log = con.CreateCommand();
                cmd_log.Connection = con;
                cmd_log.CommandType = CommandType.Text;
                cmd_log.CommandText = @"select trim(rec_msg)
                                        from ussr_dbf_implog where file_id=:p_file_id order by rec_num";                
                cmd_log.Parameters.Add("p_file_id", OracleDbType.Decimal, fileId, ParameterDirection.Input);
                OracleDataReader log_rdr = cmd_log.ExecuteReader();
                curLogText = "Помилки при імпорті файлу " + Path.GetFileName(dbfPathWithoutSession) + ":\n";
                while (log_rdr.Read())
                {
                    curLogText = curLogText + log_rdr.GetString(0) + "\n";
                }
                log_rdr.Close();
                log_rdr.Dispose();
                log(new LogEventArgs(curLogText, LogSeverityType.Error));
            }
            else
            {
                curLogText = "Помилка iмпорту:\n" + ex.Message;
                log(new LogEventArgs(curLogText, LogSeverityType.Error));
            }
        }
        finally
        {
            // откат транзакции
            if (!txCommited)
            {
                tx.Rollback();
            }
            con.Close();
            con.Dispose();

            // событие обработки файла
            if (!isEmpty && FileLoaded != null)
            {
                FileLoaded(this, new FileLoadedEventArgs(fileId, dbfPath, Path.GetFileName(dbfPathWithoutSession), curLogText, txCommited ? ResultTypes.Success : ResultTypes.Error));
            }
        }

        return txCommited;
    }

    public void deleteFile(int fileId)
    {
        DateTime startDate = DateTime.Now;
        OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
        OracleCommand command = con.CreateCommand();

        if (con.State != ConnectionState.Open)
        {
            con.Open();
        }

        command.CommandType = CommandType.Text;
        command.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_USSR_TECH");
        command.ExecuteNonQuery();

        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.Clear();
        command.Parameters.Add("p_file_id", OracleDbType.Decimal, fileId, ParameterDirection.Input);
        command.CommandText = "ussr_imp.delete_file";

        OracleTransaction tx = con.BeginTransaction();
        bool txCommited = false;
        try
        {
            command.ExecuteNonQuery();

            tx.Commit();
            txCommited = true;
            log(new LogEventArgs("Файл успiшно видалено", LogSeverityType.Info));
        }
        catch (Exception ex)
        {
            log(new LogEventArgs("Помилка при видаленнi файлу:\n" +
                ex.Message + getElapsed(startDate), LogSeverityType.Error));
        }
        finally
        {
            if (!txCommited)
            {
                tx.Rollback();
            }
            con.Close();
            con.Dispose();
        }
    }

    public bool createDeposits(int fileId)
    {
        DateTime startDate = DateTime.Now;
        OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
        OracleCommand command = con.CreateCommand();
        if (con.State != ConnectionState.Open)
            con.Open();


        command.CommandType = CommandType.Text;
        command.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_USSR_TECH");
        command.ExecuteNonQuery();

        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.Clear();
        command.Parameters.Add("file_id", OracleDbType.Decimal, fileId, ParameterDirection.Input);
        command.CommandText = "ussr_imp.create_deposits";

        OracleTransaction tx = con.BeginTransaction();
        bool txCommited = false;
        try
        {
            command.ExecuteNonQuery();

            tx.Commit();
            txCommited = true;
        }
        catch (Exception ex)
        {
            log(new LogEventArgs("Помилка при створеннi вкладу:\n" +
                ex.Message + getElapsed(startDate), LogSeverityType.Error));
        }
        finally
        {
            if (!txCommited)
            {
                tx.Rollback();
            }
            con.Close();
            con.Dispose();
        }

        if (txCommited)
        {
            log(new LogEventArgs("Выконано розгортання портфелю компенсаційних вкладів. " + getElapsed(startDate) + "\n", LogSeverityType.Info));
        }

        return txCommited;
    }
    /// <summary>
    /// Формирование файла типа №2 (Ответ на импорт данных по идент. вкладам)
    /// </summary>
    /// <param name="fileId">Код импортированого файла</param>
    public void importReplay(int fileId, string templateFolderPath, string workingFolderPath)
    {
        DateTime startDate = DateTime.Now;
        string sDirPath = "", sTabName = "", outFileName = "";


        // Соединение
        OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
        if (con.State != ConnectionState.Open)
        {
            con.Open();
        }

        //старт транзакции
        OracleTransaction tx = con.BeginTransaction();
        bool txCommited = false;
        try
        {
            // роль
            OracleCommand command = new OracleCommand();
            command.Connection = con;
            command.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_USSR_TECH");
            command.ExecuteNonQuery();

            // копируем и переименовываем шаблонный файл            
            command.Parameters.Clear();
            command.Parameters.Add("pfileId", OracleDbType.Int32, fileId, ParameterDirection.Input);
            command.CommandText = "select file_name from ussr_dbf_files where id = :pfileId";
            outFileName = Convert.ToString(command.ExecuteScalar());
            outFileName = aFileTypes[1] + outFileName.Substring(1);

            string resFilePath = workingFolderPath + Path.DirectorySeparatorChar + this.sType2FilesOutDir;
            if (!Directory.Exists(resFilePath)) Directory.CreateDirectory(resFilePath);
            resFilePath += Path.DirectorySeparatorChar + "tempfile.dbf";//outFileName;

            File.Copy(templateFolderPath, resFilePath, true);

            // вычитываем данные из базы
            command.Parameters.Clear();
            command.Parameters.Add("pfileId", OracleDbType.Int32, fileId, ParameterDirection.Input);
            command.CommandText = "select * from ussr_dbf_data where file_id = :pfileId";
            OracleDataAdapter adapter = new OracleDataAdapter(command);
            DataTable dtData = new DataTable();
            adapter.Fill(dtData);

            if (dtData.Rows.Count == 0)
            {
                log(new LogEventArgs("Не знайдено імпортованих данних", LogSeverityType.Error));
                return;
            }

            // записываем данные в исходящий файл
            sDirPath = Path.GetDirectoryName(resFilePath) + Path.DirectorySeparatorChar;
            sTabName = Path.GetFileName(resFilePath);

            OleDbConnection dbfCon = new OleDbConnection();
            dbfCon.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Extended Properties=dBASE IV;Data Source=" + sDirPath;
            dbfCon.Open();

            OleDbCommand dbfCom = new OleDbCommand("insert into " + sTabName + "(NAME, F_NAME, L_NAME, ICOD, S_PASPORT, N_PASPORT, D_PASPORT, W_PASPORT, POST_INDEX, RG_ADRES, A_ADRES, C_ADRES, S_ADRES, B_ADRES, B_ADRES_L, R_ADRES, R_ADRES_L, DATA_B, REGION, OTDEL, FILIAL, VKLAD, VAL, N_ANALIT, NSC, DATO, NOM_DOG, OST, [PROC], SUM_PROC, OST_PROC, [SUM], DBCOD, DATA_ID, TOTAL_ROL, DPT_ID) VALUES(@NAME, @F_NAME, @L_NAME, @ICOD, @S_PASPORT, @N_PASPORT, @D_PASPORT, @W_PASPORT, @POST_INDEX, @RG_ADRES, @A_ADRES, @C_ADRES, @S_ADRES, @B_ADRES, @B_ADRES_L, @R_ADRES, @R_ADRES_L, @DATA_B, @REGION, @OTDEL, @FILIAL, @VKLAD, @VAL, @N_ANALIT, @NSC, @DATO, @NOM_DOG, @OST, @PROC, @SUM_PROC, @OST_PROC, @SUM, @DBCOD, @DATA_ID, @TOTAL_ROL, @DPT_ID)", dbfCon);

            dbfCom.Parameters.Clear();
            dbfCom.Parameters.Add("@NAME", OleDbType.VarChar);
            dbfCom.Parameters.Add("@F_NAME", OleDbType.VarChar);
            dbfCom.Parameters.Add("@L_NAME", OleDbType.VarChar);
            dbfCom.Parameters.Add("@ICOD", OleDbType.VarChar);
            dbfCom.Parameters.Add("@S_PASPORT", OleDbType.VarChar);
            dbfCom.Parameters.Add("@N_PASPORT", OleDbType.VarChar);
            dbfCom.Parameters.Add("@D_PASPORT", OleDbType.Date);
            dbfCom.Parameters.Add("@W_PASPORT", OleDbType.VarChar);
            dbfCom.Parameters.Add("@POST_INDEX", OleDbType.VarChar);
            dbfCom.Parameters.Add("@RG_ADRES", OleDbType.VarChar);
            dbfCom.Parameters.Add("@A_ADRES", OleDbType.VarChar);
            dbfCom.Parameters.Add("@C_ADRES", OleDbType.VarChar);
            dbfCom.Parameters.Add("@S_ADRES", OleDbType.VarChar);
            dbfCom.Parameters.Add("@B_ADRES", OleDbType.VarChar);
            dbfCom.Parameters.Add("@B_ADRES_L", OleDbType.VarChar);
            dbfCom.Parameters.Add("@R_ADRES", OleDbType.VarChar);
            dbfCom.Parameters.Add("@R_ADRES_L", OleDbType.VarChar);
            dbfCom.Parameters.Add("@DATA_B", OleDbType.Date);
            dbfCom.Parameters.Add("@REGION", OleDbType.VarChar);
            dbfCom.Parameters.Add("@OTDEL", OleDbType.VarChar);
            dbfCom.Parameters.Add("@FILIAL", OleDbType.VarChar);
            dbfCom.Parameters.Add("@VKLAD", OleDbType.VarChar);
            dbfCom.Parameters.Add("@VAL", OleDbType.VarChar);
            dbfCom.Parameters.Add("@N_ANALIT", OleDbType.VarChar);
            dbfCom.Parameters.Add("@NSC", OleDbType.VarChar);
            dbfCom.Parameters.Add("@DATO", OleDbType.Date);
            dbfCom.Parameters.Add("@NOM_DOG", OleDbType.VarChar);
            dbfCom.Parameters.Add("@OST", OleDbType.Double);
            dbfCom.Parameters.Add("@PROC", OleDbType.Double);
            dbfCom.Parameters.Add("@SUM_PROC", OleDbType.Double);
            dbfCom.Parameters.Add("@OST_PROC", OleDbType.Double);
            dbfCom.Parameters.Add("@SUM", OleDbType.Double);
            dbfCom.Parameters.Add("@DBCODE", OleDbType.VarChar);
            dbfCom.Parameters.Add("@DATA_ID", OleDbType.Date);
            dbfCom.Parameters.Add("@TOTAL_ROL", OleDbType.Double);
            dbfCom.Parameters.Add("@DPT_ID", OleDbType.Decimal);

            foreach (DataRow row in dtData.Rows)
            {
                dbfCom.Parameters["@NAME"].Value = row["NAME"];
                dbfCom.Parameters["@F_NAME"].Value = row["F_NAME"];
                dbfCom.Parameters["@L_NAME"].Value = row["L_NAME"];
                dbfCom.Parameters["@ICOD"].Value = row["ICOD"];
                dbfCom.Parameters["@S_PASPORT"].Value = row["S_PASPORT"];
                dbfCom.Parameters["@N_PASPORT"].Value = row["N_PASPORT"];
                dbfCom.Parameters["@D_PASPORT"].Value = row["D_PASPORT"];
                dbfCom.Parameters["@W_PASPORT"].Value = row["W_PASPORT"];
                dbfCom.Parameters["@POST_INDEX"].Value = row["POST_INDEX"];
                dbfCom.Parameters["@RG_ADRES"].Value = row["RG_ADRES"];
                dbfCom.Parameters["@A_ADRES"].Value = row["A_ADRES"];
                dbfCom.Parameters["@C_ADRES"].Value = row["C_ADRES"];
                dbfCom.Parameters["@S_ADRES"].Value = row["S_ADRES"];
                dbfCom.Parameters["@B_ADRES"].Value = row["B_ADRES"];
                dbfCom.Parameters["@B_ADRES_L"].Value = row["B_ADRES_L"];
                dbfCom.Parameters["@R_ADRES"].Value = row["R_ADRES"];
                dbfCom.Parameters["@R_ADRES_L"].Value = row["R_ADRES_L"];
                dbfCom.Parameters["@DATA_B"].Value = row["DATA_B"];
                dbfCom.Parameters["@REGION"].Value = row["REGION"];
                dbfCom.Parameters["@OTDEL"].Value = row["OTDEL"];
                dbfCom.Parameters["@FILIAL"].Value = row["FILIAL"];
                dbfCom.Parameters["@VKLAD"].Value = row["VKLAD"];
                dbfCom.Parameters["@VAL"].Value = row["VAL"];
                dbfCom.Parameters["@N_ANALIT"].Value = row["N_ANALIT"];
                dbfCom.Parameters["@NSC"].Value = row["NSC"];
                dbfCom.Parameters["@DATO"].Value = row["DATO"];
                dbfCom.Parameters["@NOM_DOG"].Value = row["NOM_DOG"];
                dbfCom.Parameters["@OST"].Value = Convert.ToDouble(row["OST"]);
                dbfCom.Parameters["@PROC"].Value = Convert.ToDouble(row["PROC"]);
                dbfCom.Parameters["@SUM_PROC"].Value = Convert.ToDouble(row["SUM_PROC"]);
                dbfCom.Parameters["@OST_PROC"].Value = Convert.ToDouble(row["OST_PROC"]);
                dbfCom.Parameters["@SUM"].Value = Convert.ToDouble(row["SUM"]);
                dbfCom.Parameters["@DBCODE"].Value = row["DBCODE"];
                dbfCom.Parameters["@DATA_ID"].Value = row["DATA_ID"];
                dbfCom.Parameters["@TOTAL_ROL"].Value = Convert.ToDouble(row["TOTAL_ROL"]);
                if (row["DPT_ID"] != DBNull.Value) dbfCom.Parameters["@DPT_ID"].Value = Convert.ToDecimal(row["DPT_ID"]);
                else dbfCom.Parameters["@DPT_ID"].Value = 0;

                dbfCom.ExecuteNonQuery();
            }

            dbfCon.Close();

            // переименовываем файл
            File.Move(resFilePath, Path.GetDirectoryName(resFilePath) + Path.DirectorySeparatorChar + outFileName);

            // завершение транзакции
            tx.Commit();
            txCommited = true;
        }
        catch (Exception ex)
        {
            log(new LogEventArgs("Помилка при створеннi зворотнього файлу:\n" +
                ex.Message + getElapsed(startDate), LogSeverityType.Error));
        }
        finally
        {
            // откат транзакции
            if (!txCommited)
            {
                tx.Rollback();
            }
            con.Close();
            con.Dispose();
        }

        if (txCommited)
        {
            log(new LogEventArgs("Зворотній файл " + outFileName + " сформовано. " + getElapsed(startDate) + "\n", LogSeverityType.Info));
        }
    }
}
