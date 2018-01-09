using System;
using System.Data;
using System.IO;
using System.Data.OleDb;
using System.Data.Odbc;
using System.Xml;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Collections;
using System.Collections.Generic;
using System.Text;

public class DBFFile
{
    private string FirstFileName;
    private string AppPath;
    //------------------------------
    private FileInfo Obj;
    private MOperErr Errs;
    public DataTable TableData;
    public string CheckSum;
    public string IntTT = "NM1";
    public string ExtTT = "NM2";
    public string InfExtTT = "NMI";
    public string InfIntTT = "NMU";
    public string InfDebTT = "NMD";
    //------------------------------
    public bool isStructOk;
    public bool isCheckSumOk;
    public bool isConvertedToNewScheme;
    public bool isCheckContentsOk;

    private void RebuildDBF(string fileName)
    {
        using (FileStream fs = new FileStream(fileName, FileMode.Open, FileAccess.ReadWrite))
        {
            fs.Seek(4, SeekOrigin.Begin);
            //Количество записей в таблице 4
            int RecordsCount = fs.ReadByte();
            //Размер заголовка в байтах 8
            fs.Seek(8, SeekOrigin.Begin);
            int HeaderSize = fs.ReadByte();
            //Размер записи в байтах 10
            fs.Seek(10, SeekOrigin.Begin);
            int RecordSize = fs.ReadByte();

            fs.Seek(32, SeekOrigin.Begin);
            int colsSize = 0;
            for (int i = 0; i < 16; i++)
            {
                fs.Seek(32 + 32 * i + 16, SeekOrigin.Begin);
                colsSize += fs.ReadByte();
            }
            fs.Seek(32 + 512 + 1, SeekOrigin.Begin);

            for (int j = 0; j < RecordsCount; j++)
            {
                fs.Seek(colsSize * j, SeekOrigin.Current);
                int delFlag = fs.ReadByte();
                if (delFlag == 0)
                {
                    fs.Seek(-1, SeekOrigin.Current);
                    fs.WriteByte(32);
                }
            }
        }
    }

    /// <summary>
    /// Конструктор класса файла MOPER
    /// </summary>
    /// <param name="file">Заплодженый файл</param>
    /// <param name="appPath">Путь к приложению (нужен для вычитки файла структуры)</param>
    public DBFFile(FileInfo file, string appPath, string firstFileName)
	{
        // путь к приложению
        this.AppPath = appPath;
        // запоминаем первоначальное имя файла
        this.FirstFileName = firstFileName;
        // создаем рабочий объект
        Obj = file;

        byte fileType = 0; // 0 - xml, 1 - dbf
        string ext = Obj.Extension.ToLower();
        if (ext == ".dbf")
            fileType = 1;

        // инициализируем объект ошибок
        Errs = new MOperErr();

        TableData = new DataTable();
        TableData.TableName = "DataRow";
        // Берем данные файла dbf
        if (fileType == 1)
        {
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = "Provider=VFPOLEDB.1;Data Source=" + Obj.FullName.Replace(Obj.Name, "");

            con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Extended Properties=dBASE IV;Data Source=" + Obj.FullName.Replace(Obj.Name, "");
            con.Open();
            OleDbDataAdapter adr = new OleDbDataAdapter("SELECT * FROM " + Path.GetFileNameWithoutExtension(Obj.Name), con);

            try { adr.Fill(TableData); }
            catch (Exception ex)
            {
                RebuildDBF(Obj.FullName);
                adr.Fill(TableData);
            }
            finally { con.Close(); }
            for (int i = 0; i < TableData.Columns.Count; i++)
            {
                if (TableData.Columns[i].DataType == typeof(string))
                    for (int j = 0; j < TableData.Rows.Count; j++)
                    {
                        string oldStr = TableData.Rows[j][i].ToString();
                        TableData.Rows[j][i] = oldStr.Replace('ў', 'і').Replace('Ў', 'І').Replace('•', 'ї').Replace('Ї', 'Є').Replace('°', 'Ї').Replace('∙', '_');
                    }
            }
        }
        else // Берем данные файла xml
        {
            TableData.ReadXmlSchema(appPath + "\\Xml\\MOperShema.xml");
            TableData.ReadXml(Obj.FullName);    
        }
    }

    // ==========================================================================
    //                      Системные проверки
    // ==========================================================================
    public MOperErr SystemCheck()
    {        
        // проверка структуры dbf файла
        isStructOk = StructCheck();
        
        // проверка контрольной суммы файла
        isCheckSumOk = CheckSumCheck();

        return Errs;
    }
    /// <summary>
    /// Проверка структуры DBF файла
    /// </summary>
    private bool StructCheck()
    {
        bool isValid = true;

        XmlDocument xmlSruct = new XmlDocument();
        xmlSruct.Load(this.AppPath + "\\Xml\\MOperStruct.xml");

        XmlNodeList xmlFields = xmlSruct.GetElementsByTagName("FIELD");

        for (int i = 0; i < xmlFields.Count; i++)
        {
            string NAME = xmlFields[i].ChildNodes[0].InnerText;
            string TYPE = xmlFields[i].ChildNodes[1].InnerText;
            int MAX = Convert.ToInt32(xmlFields[i].ChildNodes[2].InnerText);

            string[] DEFVALS = new string[xmlFields[i].ChildNodes[3].ChildNodes.Count + 1];
            if (xmlFields[i].ChildNodes[3].ChildNodes.Count == 0) DEFVALS = null;
            else
            {
                for (int j = 0; j < xmlFields[i].ChildNodes[3].ChildNodes.Count; j++)
                    DEFVALS[j] = xmlFields[i].ChildNodes[3].ChildNodes[j].InnerText;
                DEFVALS[xmlFields[i].ChildNodes[3].ChildNodes.Count] = "";
            }

            if (!CheckField(NAME, TYPE, 2, DEFVALS)) isValid = false;
        }
        return isValid;
    }
    /// <summary>
    /// Проверка полей файла
    /// </summary>
    /// <param name="name">Имя поля</param>
    /// <param name="type">Тип поля (N, C, D)</param>
    /// <param name="length">Максимальная длина</param>
    /// <param name="defVals">Перечень допустимых значений</param>
    private bool CheckField(string name, string type, int length, string[] defVals)
    {
        // проверяем наличие колонки
        if (this.TableData.Columns.IndexOf(name) == -1)
        {
            Errs.SetErr(Resources.moper.GlobalResource.Msg_VIshodnomFaileNeNaidenoPole + " " + name);
            return false;
        }

        // проверяем тип колонки
        string colType = this.TableData.Columns[name].DataType.FullName;
        switch (type)
        {
            case "N": if (colType != "System.Double" && colType != "System.Decimal")
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_VIshodnomFailePole + " " + name + " " + Resources.moper.GlobalResource.Msg_DolgnoImetTipN);
                    return false;
                }
                break;
            case "C": if (colType != "System.String")
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_VIshodnomFailePole + " " + name + " " + Resources.moper.GlobalResource.Msg_DolgnoImetTipC);
                    return false;
                }
                break;
            case "D": if (colType != "System.DateTime")
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_VIshodnomFailePole + " " + name + " " + Resources.moper.GlobalResource.Msg_DolgnoImetTipD);
                    return false;
                }
                break;
            default:
                Errs.SetErr(Resources.moper.GlobalResource.Msg_VIshodnomFailePole + " " + name + " " + Resources.moper.GlobalResource.Msg_ImeetNeizvesnyiTip);
                return false;
                break;
        }

        // проверяем размер данных
        if (this.TableData.Columns[name].MaxLength > length) return false;

        // проверяем наличие дефолтных значений
        if (defVals != null)
        {
            bool res = true;
            for (int i = 0; i < this.TableData.Rows.Count; i++)
            {
                bool isDef = false;
                string val = Convert.ToString(this.TableData.Rows[i].ItemArray[this.TableData.Columns.IndexOf(name)]).ToUpper().Trim();

                for (int j = 0; j < defVals.Length; j++)
                    if (defVals[j].ToUpper().Trim() == val) isDef = true;

                if (!isDef) res = false;
            }

            if (!res)
            {
                Errs.SetErr(Resources.moper.GlobalResource.Msg_VIshodnomFailePole + " " + name + " " + Resources.moper.GlobalResource.Msg_NeSovpadaetSDefoltZnacheniami);
                return false;
            }
        }

        return true;
    }
    /// <summary>
    /// Проверка контрольной суммы файла (не оплачен ли он раньше)
    /// </summary>
    /// <returns></returns>
    private bool CheckSumCheck()
    {
        CRC crc = new CRC(this.Obj.FullName, this.FirstFileName);
        this.CheckSum = crc.GetCrc();

        int isOldCheckSum = 0;
        string OldFileName = "";
        string OldFileDate = "";

        OracleConnection con = OraConnector.Handler.UserConnection;
        OracleCommand cmd = new OracleCommand();
        cmd.Connection = con;
        try
        {
            cmd.CommandText = "SET ROLE WR_MOPER";
            cmd.ExecuteNonQuery();

            cmd.Parameters.Clear();
            cmd.Parameters.Add("psum", OracleDbType.Varchar2, this.CheckSum, ParameterDirection.Input);
            cmd.CommandText = "SELECT count(*) FROM MOPER_ACCERTED_FILES WHERE FSUM = :psum";
            isOldCheckSum = Convert.ToInt32(cmd.ExecuteScalar());

            if (isOldCheckSum > 0)
            {
                cmd.Parameters.Clear();
                cmd.Parameters.Add("psum", OracleDbType.Varchar2, this.CheckSum, ParameterDirection.Input);
                cmd.CommandText = "SELECT FNAME FROM MOPER_ACCERTED_FILES WHERE FSUM = :psum";
                OldFileName = Convert.ToString(cmd.ExecuteScalar());

                cmd.Parameters.Clear();
                cmd.Parameters.Add("psum", OracleDbType.Varchar2, this.CheckSum, ParameterDirection.Input);
                cmd.CommandText = "SELECT to_char(ACCDAT, 'dd.MM.yyyy') FROM MOPER_ACCERTED_FILES WHERE FSUM = :psum";
                OldFileDate = Convert.ToString(cmd.ExecuteScalar());
            }
        }
        finally
        {
            con.Close();
        }

        if (Convert.ToBoolean(isOldCheckSum)) Errs.SetErr(Resources.moper.GlobalResource.Msg_Fail + " " + OldFileName + " " + Resources.moper.GlobalResource.Msg_BylOplachen + " " + OldFileDate);

        return (Convert.ToBoolean(isOldCheckSum)) ? (false) : (true);
    }

    // ==========================================================================
    // Конвертация данных в необходимый формат и формирование недостающих данных
    // ==========================================================================
    /// <summary>
    /// Конвертация данных в необходимый формат и формирование недостающих данных
    /// </summary>
    /// <returns></returns>
    public MOperErr ConvertDataToNewScheme()
    {
        DataTable NewTableData = new DataTable();

        // формируем поля таблицы по заданому XML
        XmlDocument NewStruct = new XmlDocument();
        NewStruct.Load(this.AppPath + "\\Xml\\NewMOperStruct.xml");
        for (int j = 0; j < NewStruct.GetElementsByTagName("FIELD").Count; j++)
        {
            string cName = NewStruct.GetElementsByTagName("FIELD")[j].ChildNodes[0].InnerText;

            Type cType;
            switch (NewStruct.GetElementsByTagName("FIELD")[j].ChildNodes[1].InnerText)
            {
                case "N": cType = typeof(Int32); break;
                case "C": cType = typeof(String); break;
                case "D": cType = typeof(DateTime); break;
                case "F": cType = typeof(Double); break;
                default: cType = typeof(String); break;
            }

            NewTableData.Columns.Add(cName, cType);
        }

        // заполняем данные
        OracleConnection con = OraConnector.Handler.UserConnection;
        OracleCommand cmd = new OracleCommand("SET ROLE WR_MOPER", con);
        try
        {
            cmd.ExecuteNonQuery();

            // теперь по каждому документу
            for (int i = 0; i < this.TableData.Rows.Count; i++)
            {
                DataRow row = NewTableData.NewRow();

                // референс
                cmd.Parameters.Clear();
                cmd.Parameters.Add("pref", OracleDbType.Decimal, ParameterDirection.Output);
                cmd.CommandText = "gl.ref";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
                row["REF"] = Convert.ToDecimal(cmd.Parameters["pref"].Value.ToString());

                // Вычитываем из БД наше МФО
                cmd.Parameters.Clear();
                cmd.CommandText = "SELECT f_ourmfo FROM dual";
                cmd.CommandType = CommandType.Text;
                row["MFOA"] = Convert.ToString(cmd.ExecuteScalar());

                // Счет А
                row["NLSA"] = Convert.ToString(TableData.Rows[i]["NLSA"]);

                // МФО банка корреспондента
                row["MFOB"] = Convert.ToString(TableData.Rows[i]["MFOB"]);

                // Счет Б
                row["NLSB"] = Convert.ToString(TableData.Rows[i]["NLSB"]);

                // Признак дебета\кредита 0 - дебет, 1 - кредит
                row["DK"] = Convert.ToInt32(TableData.Rows[i]["DK"]);

                // Символ кас. плана
                row["SK"] = Convert.ToInt32(TableData.Rows[i]["SK"]);

                // Валюта
                row["KV"] = Convert.ToInt32(TableData.Rows[i]["KV"]);

                // Сумма в гривнах
                row["S"] = (double)Convert.ToDecimal(TableData.Rows[i]["S"])/100;

                // вид банковской операции
                row["VOB"] = Convert.ToInt32(TableData.Rows[i]["VOB"]);
                if (1 != (int)row["VOB"] && 2 != (int)row["VOB"] && 6 != (int)row["VOB"] && 33 != (int)row["VOB"] && 81 != (int)row["VOB"])
                {
                    cmd.Parameters.Clear();
                    cmd.CommandText = @"SELECT NVL( min(to_number(VAL)),1 ) FROM PARAMS WHERE PAR = 'VOB2SEP'";
                    row["VOB"] = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // № документа
                row["ND"] = Convert.ToString(TableData.Rows[i]["ND"]);

                // Дата документа
                row["DATD"] = (TableData.Rows[i]["DA"] == DBNull.Value) ? (DateTime.Now) : (Convert.ToDateTime(TableData.Rows[i]["DA"]));

                // Дата валютирования
                row["VDAT"] = (TableData.Rows[i]["DAPU"] == DBNull.Value) ? (((DateTime)row["DATD"]).Add(DateTime.Now.TimeOfDay)) : (Convert.ToDateTime(TableData.Rows[i]["DAPU"]));

                // Плательщик
                row["NAMEA"] = Convert.ToString(TableData.Rows[i]["PLATE"]);

                // Получатель
                row["NAMEB"] = Convert.ToString(TableData.Rows[i]["KORR"]);

                // Назначение платежа
                row["NAZN"] = Convert.ToString(TableData.Rows[i]["NAZN"]);

                // ОКПО А
                row["OKPOA"] = Convert.ToString(TableData.Rows[i]["KOKA"]);

                // ОКПО Б
                row["OKPOB"] = Convert.ToString(TableData.Rows[i]["KOKB"]);

                // Код операциониста
                cmd.Parameters.Clear();
                cmd.CommandText = @"SELECT docsign.getIdOper() FROM dual";
                row["KISP"] = Convert.ToString(cmd.ExecuteScalar());

                // ----- Блок коррекции данных -----
                // документ внутрибанк/межбанк
                row["NM"] = ((string)row["MFOA"] == (string)row["MFOB"]) ? (1) : (2);

                // тип операции
                switch ((int)row["NM"])
                {
                    // внутрибанковская операция
                    case 1: row["TT"] = this.IntTT;
                        // информационный внутр
                        if ((int)row["DK"] > 1) row["TT"] = this.InfIntTT;
                        break;
                    // межбанковская операция
                    case 2: 
                        row["TT"] = this.ExtTT;
                        // информационный дебет
                        if ((int)row["DK"] == 0) row["TT"] = this.InfDebTT;
                        // информационный внешний
                        if ((int)row["DK"] > 1) row["TT"] = this.InfExtTT;
                        break;

                    default: row["TT"] = this.ExtTT;
                        break;
                }
                //!!!!!!Есть вариант создать справочник операций и брать из него!!!!!!!

                cmd.Parameters.Clear();
                cmd.Parameters.Add("ptt", OracleDbType.Varchar2, (string)row["TT"], ParameterDirection.Input);
                cmd.CommandText = "SELECT flags||fli||flv FROM TTS WHERE TT = :ptt";
                string flags = Convert.ToString(cmd.ExecuteScalar());
                // флаги
                row["FLI"] = flags.Substring(64, 1);
                row["INPUTSIGNFLAG"] = flags.Substring(1, 1);
                row["NOMINAL"] = flags.Substring(57, 1);
                row["PRTY"] = (flags.Substring(12, 1) == "0")?("0"):("1");

                // формируем буффер СЭП
                row["SEPBUF"] = GetSepBuf(row);

                // формируем внутренний буффер
                row["INTBUF"] = Data_Asc_Hex(GetIntBuf(row));
                
                NewTableData.Rows.Add(row);
            }
        }
        finally
        {
            con.Close();
        }

        this.TableData = NewTableData;
        this.isConvertedToNewScheme = true;

        return Errs;
    }

    // ==========================================================================
    //                      Проверка содержимого
    // ==========================================================================
    /// <summary>
    /// Проверка содержимого
    /// </summary>
    /// <returns>true - содержимое корректно, false - нет)</returns>
    public MOperErr ContentsCheck()
    {
        this.isCheckContentsOk = true;

        OracleConnection con = OraConnector.Handler.UserConnection;
        OracleCommand cmd = new OracleCommand("SET ROLE WR_MOPER", con);
        try
        {
            cmd.ExecuteNonQuery();

            for (int i = 0; i < this.TableData.Rows.Count; i++)
            {
                DataRow row = this.TableData.Rows[i];

                // Проверка ОКПО
                if (((string)row["OKPOA"]).Length == 9 || ((string)row["OKPOA"]).Length == 10 || (string)row["OKPOA"] == "99999" || (string)row["OKPOA"] == "000000000") { /*ОКПО не проверяеться*/ }
                else if (((string)row["OKPOA"]).Length == 8 && (string)row["OKPOA"] == CheckOKPO((string)row["OKPOA"])) { /*ОКПО впорядке*/ }
                else
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_OchibkiVOkpoA);
                    this.isCheckContentsOk = false;
                }

                if (((string)row["OKPOB"]).Length == 9 || ((string)row["OKPOB"]).Length == 10 || (string)row["OKPOB"] == "99999" || (string)row["OKPOB"] == "000000000") { /*ОКПО не проверяеться*/ }
                else if (((string)row["OKPOB"]).Length == 8 && (string)row["OKPOB"] == CheckOKPO((string)row["OKPOB"])) { /*ОКПО впорядке*/ }
                else
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_OchibkiVOkpoB);
                    this.isCheckContentsOk = false;
                }
                // Проверка на дату (+- 10 от банковской)
                cmd.Parameters.Clear();
                cmd.CommandText = "SELECT to_char(web_utl.get_bankdate,'DD.MM.YYYY') FROM dual";
                System.Globalization.CultureInfo cinfo = System.Globalization.CultureInfo.CreateSpecificCulture("en-GB");
	    		cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                DateTime bdate = Convert.ToDateTime(cmd.ExecuteScalar(),cinfo);
                DateTime vdate = Convert.ToDateTime(row["VDAT"]);
                TimeSpan diff = bdate - vdate;
                if (Math.Abs(diff.Days) > 10)
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_DateNotValid);
                    this.isCheckContentsOk = false;
                }

                // проверка МФО и счетов
                cmd.Parameters.Clear();
                cmd.Parameters.Add("sMfoB", OracleDbType.Varchar2, (string)row["MFOB"], ParameterDirection.Input);
                cmd.CommandText = "SELECT sab FROM banks WHERE mfo=:sMfoB";
                string sSab = Convert.ToString(cmd.ExecuteScalar());
                if ("" == sSab)
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_OchibkaMfo);
                    this.isCheckContentsOk = false;
                }

                // проверяе счет А
                if (((string)row["NLSA"]).Length < 5 || (string)row["NLSA"] != CheckNLSByMFO((string)row["MFOA"], (string)row["NLSA"]))
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_NevernyiSchetA);
                    this.isCheckContentsOk = false;
                }
                // на доступность
                string ErrA = CheckAccountAccess((string)row["MFOA"], (string)row["NLSA"], (int)row["DK"], con);
                if (ErrA != null)
                {
                    Errs.SetErr(ErrA);
                    this.isCheckContentsOk = false;
                }

                // проверяем счет Б
                // !!! throw new Exception("(string)row[NLSB]=" + row["NLSB"].ToString() + " CheckNLSByMFO((string)row[MFOB], (string)row[NLSB])="+CheckNLSByMFO((string)row["MFOB"], (string)row["NLSB"]));
                if (((string)row["NLSB"]).Length < 5 || (string)row["NLSB"] != CheckNLSByMFO((string)row["MFOB"], (string)row["NLSB"]))
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_NevernyiSchetB);
                    this.isCheckContentsOk = false;
                }
                // на доступность если DK=0 то передаем 1, если 1 то передаем 0, если другое, то не меняем
                string ErrB = CheckAccountAccess((string)row["MFOB"], (string)row["NLSB"], ((int)row["DK"] == 0) ? (1) : (((int)row["DK"] == 1) ? (0) : ((int)row["DK"])), con);
                if (ErrB != null)
                {
                    Errs.SetErr(ErrB);
                    this.isCheckContentsOk = false;
                }

                if ((int)row["NM"] != 1)
                {
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("sMfoB", OracleDbType.Varchar2, (string)row["MFOB"], ParameterDirection.Input);
                    cmd.Parameters.Add("sSab", OracleDbType.Varchar2, sSab, ParameterDirection.Input);
                    cmd.Parameters.Add("sNlsB", OracleDbType.Varchar2, (string)row["NLSB"], ParameterDirection.Input);
                    cmd.CommandText = "SELECT nbs FROM nosep WHERE kod=decode(Substr(:sMfoB,1,1),'8',3, decode(Substr(:sSab,3,1),'H',1,2)) and :sNlsB like nbs || '%'";
                    if ("" != Convert.ToString(cmd.ExecuteScalar()))
                    {
                        Errs.SetErr(Resources.moper.GlobalResource.Msg_NedopustimyiBalansovyiSchet);
                        this.isCheckContentsOk = false;
                    }
                }

                // Проверка др. реквизитов
                if (((string)row["NAMEA"]).Length < 3 || ((string)row["NAMEA"]).Substring(0, 1) == " " || !CheckSymbolsInString((string)row["NAMEA"]))
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_OchibkaVRekvizitePlatelschik);
                    this.isCheckContentsOk = false;
                }
                if (((string)row["NAMEB"]).Length < 3 || ((string)row["NAMEB"]).Substring(0, 1) == " " || !CheckSymbolsInString((string)row["NAMEB"]))
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_OchibkaVRekvizitePolochatel);
                    this.isCheckContentsOk = false;
                }
                if (((string)row["NAZN"]).Length < 3 || ((string)row["NAZN"]).Substring(0, 1) == " " || !CheckSymbolsInString((string)row["NAZN"]))
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_OchibkaVRekviziteNaznachenie);
                    this.isCheckContentsOk = false;
                }

                // проверка суммы на 0
                if ((double)row["S"] == 0)
                {
                    Errs.SetErr(Resources.moper.GlobalResource.Msg_FailSodergitDokumentNaSumu0 + " (NLSA : " + (string)row["NLSA"] + ", NLSB : " + (string)row["NLSB"] + ")");
                    this.isCheckContentsOk = false;
                }
            }
        }
        finally
        {
            con.Close();
        }

        return Errs;
    }
    /// <summary>
    /// Проверка счета на доступность
    /// </summary>
    /// <param name="MFO">МФО проверяемого счета</param>
    /// <param name="NLS">Проверяемый счет</param>
    /// <param name="DK">Дебет\кредит</param>
    /// <param name="Con">Соединение с БД</param>
    /// <returns>null - счет доступен, иначе текст ошибки </returns>
    private string CheckAccountAccess(string MFO, string NLS, int DK, OracleConnection Con) 
    {
        string ErrMsg = null;

        OracleCommand com = new OracleCommand("SET ROLE WR_MOPER", Con);
        com.ExecuteNonQuery();

        com.Parameters.Clear();
        com.Parameters.Add("pmfo", OracleDbType.Varchar2, MFO, ParameterDirection.Input);
        com.Parameters.Add("pnls", OracleDbType.Varchar2, NLS, ParameterDirection.Input);

        switch (DK)
        {
            case 0 :
                com.CommandText = "SELECT decode(f_ourmfo, :pmfo, (SELECT count(*) FROM SALDOK WHERE NLS = :pnls and KV = 980), 1) FROM dual";
                ErrMsg = Resources.moper.GlobalResource.Msg_Schet + " " + NLS + " " + Resources.moper.GlobalResource.Msg_NedostupenDliaKredita;
                break;
            case 1 :
                com.CommandText = "SELECT decode(f_ourmfo, :pmfo, (SELECT count(*) FROM SALDOD WHERE NLS = :pnls and KV = 980), 1) FROM dual";
                ErrMsg = Resources.moper.GlobalResource.Msg_Schet + " " + NLS + " " + Resources.moper.GlobalResource.Msg_NedostupenDliaDebeta;
                break;
            default :
                com.CommandText = "SELECT decode(f_ourmfo, :pmfo, (SELECT count(*) FROM SALDO WHERE NLS = :pnls and KV = 980), 1) FROM dual";
                ErrMsg = Resources.moper.GlobalResource.Msg_Schet + " " + NLS + " " + Resources.moper.GlobalResource.Msg_NedostupenZakhyt;
                break;
        }

        if (Convert.ToBoolean(com.ExecuteScalar())) ErrMsg = null;
        return ErrMsg;
      }    
    /// <summary>
    /// Проверка ОКПО
    /// </summary>
    /// <param name="OKPO">Проверяемое ОКПО</param>
    /// <returns>Проверенное ОКПО (с правильным контрольным разрядом)</returns>
    private string CheckOKPO(string OKPO)
    {
        string  sNewOKPO = "";          // новое ОКПО
        string  sMask = "";
        int     nLength = OKPO.Length;  // кол-во символов в ОКПО
        int     nSum;
        int     nCtrlNum;               // контрольный разряд 

        if (8 != nLength) return OKPO;

        // проверка на наличие недопустимых симвлов 
        try { decimal nCode = Convert.ToDecimal(OKPO); }
        catch { /*не численное значение ОКПО*/ return sNewOKPO; }

        // задаем маску
        if (OKPO.CompareTo("30000000") < 0 || OKPO.CompareTo("60000000") > 0)
            sMask = "1234567";
        else
            sMask = "7123456";

        // подсчет контрольного разряда
        nSum = 0;
        for (int i = 0; i < 7; i++)
        {
            int nCodeLeft = Convert.ToInt16(OKPO.Substring(i, 1));
            int nCodeRight = Convert.ToInt16(sMask.Substring(i, 1));
            nSum += nCodeLeft * nCodeRight;
        }

        nCtrlNum = nSum % 11;
        if (10 == nCtrlNum)	        // вроди как все тоже, но другие маски
        {	// задаем маску
            if (OKPO.CompareTo("30000000") < 0 || OKPO.CompareTo("60000000") > 0)
                sMask = "3456789";
            else
                sMask = "9345678";

            // подсчет контрольного разряда
            nSum = 0;
            for (int i = 0; i < 7; i++)
            {
                int nCodeLeft = Convert.ToInt16(OKPO.Substring(i, 1));
                int nCodeRight = Convert.ToInt16(sMask.Substring(i, 1));
                nSum += nCodeLeft * nCodeRight;
            }

            nCtrlNum = nSum % 11;
            if (10 == nCtrlNum) nCtrlNum = 0;
        }

        // формируем новое ОКПО
        sNewOKPO = OKPO.Substring(0, 7) + nCtrlNum.ToString();

        return sNewOKPO;
    }
    /// <summary>
    /// Проверка счета по МФО
    /// </summary>
    /// <param name="MFO">МФО для проверки</param>
    /// <param name="NLS">Проверяемый счет</param>
    /// <returns>Проверенный счет (с правильным контрольным разрядом)</returns>
    private string CheckNLSByMFO(string MFO, string NLS)
    {
        string sNewNLS = NLS.Substring(0, 4) + "0" + NLS.Substring(5);
        string m1 = "137130";
        string m2 = "37137137137137";
        int j = 0;
        for (int i = 0; i < MFO.Length; i++)
        { j = j + Convert.ToInt16(MFO.Substring(i, 1)) * Convert.ToInt16(m1.Substring(i, 1)); }

        for (int i = 0; i < sNewNLS.Length; i++)
        { j = j + Convert.ToInt16(sNewNLS.Substring(i, 1)) * Convert.ToInt16(m2.Substring(i, 1)); }

        return sNewNLS.Substring(0, 4) +
               Convert.ToString((((j + sNewNLS.Length) * 7) % 10)) +
               sNewNLS.Substring(5);
    }
    /// <summary>
    /// Проверка строки на отсутсвие недопустимых символов
    /// </summary>
    /// <param name="MFO">Проверяемая строка</param>
    /// <returns>true - в строке нет недопустимых символов, false - есть</returns>
    private bool CheckSymbolsInString(string Str) 
    {
        bool bRet = true;
        // массив недопустимых символов
        char[] msSimv = new char[32];
        for (int i = 0; i < 31; i++)
        {
            msSimv[i] = Convert.ToChar(i);
        }
        msSimv[31] = Convert.ToChar(255);
        // проверка        
        for (int i = 0; i < Str.Length; i++)
        {
            for (int j = 0; j < msSimv.Length; j++)
            {
                if (Str[i] == msSimv[j])
                {
                    bRet = false;
                    break;
                }
            }
            if (!bRet) break;
        }
        return bRet;
    }

    // ==========================================================================
    //                      Формирование данных
    // ==========================================================================
    /// <summary>
    /// Формирует СЕП буффер по полям документа
    /// </summary>
    /// <param name="row">Ряд данных для формирования</param>
    private string GetSepBuf(DataRow row)
    {
        string buf = "";

        buf += Convert.ToString(row["MFOA"]).PadLeft(9);
        buf += Convert.ToString(row["NLSA"]).PadLeft(14);
        buf += Convert.ToString(row["MFOB"]).PadLeft(9);
        buf += Convert.ToString(row["NLSB"]).PadLeft(14);
        buf += Convert.ToString(row["DK"]);
        buf += Convert.ToString(Convert.ToDouble(row["S"])*100).PadLeft(16);
        buf += Convert.ToString(row["VOB"]).PadLeft(2);
        buf += Convert.ToString(row["ND"]).PadRight(10);
        buf += Convert.ToString(row["KV"]).PadLeft(3);
        buf += Convert.ToDateTime(row["DATD"]).ToString("yyMMdd");
        buf += Convert.ToDateTime(row["VDAT"]).ToString("yyMMdd");
        buf += Convert.ToString(row["NAMEA"]).PadRight(38);
        buf += Convert.ToString(row["NAMEB"]).PadRight(38);
        buf += Convert.ToString(row["NAZN"]).PadRight(160);
        buf += " ".PadRight(60);//?????
        buf += " ".PadRight(3);//?????
        buf += "10";//?????
        buf += Convert.ToString(row["OKPOA"]).PadLeft(14);
        buf += Convert.ToString(row["OKPOB"]).PadLeft(14);
        buf += Convert.ToString(row["REF"]).PadLeft(9);
        buf += Convert.ToString(row["KISP"]).PadRight(6);
        buf += " 0";//?????
        buf += " ".PadLeft(8);

        return buf.Replace(" ", "&nbsp;");
    }
    /// <summary>
    /// Формирует буффер для внутреней подписи по полям документа
    /// </summary>
    /// <param name="row">Ряд данных для формирования</param>
    private string GetIntBuf(DataRow row)
    {
        string buf = "";
        string BankType = "unknown";
        Int64 BankMfo = 0;

        OracleConnection con = OraConnector.Handler.UserConnection;
        OracleCommand cmd = new OracleCommand("SET ROLE WR_MOPER", con);
        try
        {
            cmd.ExecuteNonQuery();

            cmd.CommandText = "SELECT f_ourmfo FROM dual";
            BankMfo = Convert.ToInt64(cmd.ExecuteScalar());
        }
        finally
        {
            con.Close();
        }

        switch(BankMfo)
        {
            case 300001 : BankType = "NBU"; break;
            case 300465 : BankType = "OSC"; break;
            case 300205 : BankType = "UPB"; break;
        }

        switch(BankType)
        {
			case "UPB" :
                buf += Convert.ToString(row["ND"]).PadRight(10);
                buf += Convert.ToDateTime(row["DATD"]).ToString("yyMMdd");
                buf += Convert.ToString(row["VOB"]).PadLeft(6);
                buf += Convert.ToString(row["DK"]);
                buf += Convert.ToString(row["MFOA"]).PadLeft(9);
                buf += Convert.ToString(row["NLSA"]).PadLeft(14);
                buf += Convert.ToString("980"/*!!!row["KV"]!!!*/).PadLeft(3);
                buf += Convert.ToString(Convert.ToDouble(row["S"]) * 100).PadLeft(16);
                buf += Convert.ToString(row["MFOB"]).PadLeft(9);
                buf += Convert.ToString(row["NLSB"]).PadLeft(14);
                buf += Convert.ToString("980"/*!!!row["KV"]!!!*/).PadLeft(3);
                buf += Convert.ToString(" ").PadLeft(16);
                buf += Convert.ToString(row["NAZN"]).PadRight(160);
                
                break;

            default	:
                buf += Convert.ToString(row["ND"]).PadRight(10);
                buf += Convert.ToDateTime(row["DATD"]).ToString("yyMMdd");
                buf += Convert.ToString(row["DK"]);
                buf += Convert.ToString(row["MFOA"]).PadLeft(9);
                buf += Convert.ToString(row["NLSA"]).PadLeft(14);
                buf += Convert.ToString("980"/*!!!row["KV"]!!!*/).PadLeft(3);
                buf += Convert.ToString(Convert.ToDouble(row["S"]) * 100).PadLeft(16);
                buf += Convert.ToString(row["MFOB"]).PadLeft(9);
                buf += Convert.ToString(row["NLSB"]).PadLeft(14);
                buf += Convert.ToString("980"/*!!!row["KV"]!!!*/).PadLeft(3);
                buf += Convert.ToString(Convert.ToDouble(row["S"]) * 100).PadLeft(16);
                
                break;			 
        }

        return buf;
    }
    /// <summary>
    /// Конвертация строки в Хексовое представление
    /// </summary>
    /// <param name="Data">Строка для конвертации</param>
    /// <returns>Хексовое представление строки</returns>
    private string Data_Asc_Hex(string Data)
    {
        string sHex = "";
        byte[] bData = System.Text.ASCIIEncoding.Default.GetBytes(Data);

        for (int i = 0; i < bData.Length; i++)
            sHex += bData[i].ToString("X");
        
        return sHex;
    }
    /// <summary>
    /// Переводит строку из одной кодировки в другую
    /// </summary>
    /// <param name="value">Строка</param>
    /// <param name="src">Первоначальная кодировка</param>
    /// <param name="trg">Результирующая кодировка</param>
    private string ConvertEncoding(string value, Encoding src, Encoding trg)
    {
        byte[] srcBytes = trg.GetBytes(value);
        byte[] dstBytes = Encoding.Convert(src, trg, srcBytes);
        
        return trg.GetString(dstBytes);
    }
}
