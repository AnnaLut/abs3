using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Globalization;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.Services;
using Bars.Application;
using Bars.Classes;
using Bars.Configuration;
using cbirep;
using BarsWeb.Infrastructure.Repository.DI.Implementation;

namespace Bars.WebServices
{
    public class WebServices : Bars.BarsWebService
    {
        [DllImport("WINBARS2.DLL", EntryPoint = "GetChecksumDigit")]
        public static extern char GetChecksumDigit(string mfo, string acc, decimal formula);
        override public void PrimaryCheckAccess() { }
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        public WebServices()
        {
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
            InitializeComponent();
        }
        /*Основние веб-методы.*/

        //Банковская дата
        [WebMethod(EnableSession = true)]
        public string GetBankDate()
        {
            string result = "";
            try
            {
                InitOraConnection(Context);
                SetRole("basic_info");
                result = SQL_SELECT_scalar("SELECT TO_CHAR(bankdate,'DD/MM/YYYY') from dual").ToString();
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

        //Закрыть счет
        [WebMethod(EnableSession = true)]
        public string CloseAccount(decimal acc, int prompts, int? reason)
        {
            string result = "Рахунок ";
            try
            {
                InitOraConnection(Context);
                SetRole("wr_custlist");
                DateTime bankdate = Convert.ToDateTime(SQL_SELECT_scalar("select bankdate from dual"), cinfo);
                SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                object[] reader = SQL_SELECT_reader("SELECT ostc,ostb,ostf,dapp,dazs,daos,kv,nls FROM accounts WHERE acc=:acc");
                result += reader.GetValue(7) + "(" + reader.GetValue(6) + ") ";
                if (Convert.ToDecimal(reader.GetValue(0).ToString()) != 0)
                {
                    result += "ненульовий залишок(Ф).";
                    return result;
                }
                if (Convert.ToDecimal(reader.GetValue(1).ToString()) != 0)
                {
                    result += "ненульовий залишок(П).";
                    return result;
                }
                if (Convert.ToDecimal(reader.GetValue(2).ToString()) != 0)
                {
                    result += "ненульовий залишок(Б).";
                    return result;
                }
                if (reader.GetValue(3) != null)
                {
                    if (Convert.ToDateTime(reader.GetValue(3), cinfo) == bankdate)
                    {
                        result += "має обороти.";
                        return result;
                    }
                }
                if (reader.GetValue(4) != null)
                {
                    if (Convert.ToDateTime(reader.GetValue(4), cinfo) != DateTime.MinValue)
                    {
                        result += "вже закритий.";
                        return result;
                    }
                }
                if (reader.GetValue(5) != null)
                {
                    if (Convert.ToDateTime(reader.GetValue(5), cinfo) > bankdate)
                    {
                        result += "не можна закрити датою, меншою дати відкриття.";
                        return result;
                    }
                }
                if (reader.GetValue(3) != null)
                {
                    if (Convert.ToDateTime(reader.GetValue(3), cinfo) > bankdate)
                    {
                        result += "не можна закрити датою, меншою дати останнього руху по рахунку - " + Convert.ToDateTime(reader.GetValue(3)).ToShortDateString() + ".";
                        return result;
                    }
                }
                SetParameters("acc2", DB_TYPE.Decimal, acc, DIRECTION.Input);
                DataSet ds = SQL_SELECT_dataset("SELECT i.acra,i.acr_dat,i.stp_dat,a.ostc,a.ostb,a.ostf,a.dapp,a.nls FROM accounts a, int_accn i WHERE i.acra = a.acc AND a.dazs is NULL and i.acc=:acc AND i.acra<>:acc2");
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string result2 = "Рахунок нарахування %% " + ds.Tables[0].Rows[i][7].ToString() + " ";
                    if (Convert.ToDecimal(ds.Tables[0].Rows[i][3].ToString()) != 0)
                    {
                        result2 += "ненульовий залишок(Ф).";
                        return result2;
                    }
                    if (Convert.ToDecimal(ds.Tables[0].Rows[i][4].ToString()) != 0)
                    {
                        result2 += "ненульовий залишок(П).";
                        return result2;
                    }
                    if (Convert.ToDecimal(ds.Tables[0].Rows[i][5].ToString()) != 0)
                    {
                        result2 += "ненульовий залишок(В).";
                        return result2;
                    }
                    if (ds.Tables[0].Rows[i][6] != DBNull.Value)
                    {
                        if (Convert.ToDateTime(ds.Tables[0].Rows[i][6], cinfo) == bankdate)
                        {
                            result2 += "має обороти.";
                            return result2;
                        }
                    }
                    if (prompts < 1)
                    {
                        if ((ds.Tables[0].Rows[i][2] != DBNull.Value && ds.Tables[0].Rows[i][1] != DBNull.Value && ds.Tables[0].Rows[i][2] != DBNull.Value && Convert.ToDateTime(ds.Tables[0].Rows[i][2]) > Convert.ToDateTime(ds.Tables[0].Rows[i][1], cinfo))
                           ||
                           (ds.Tables[0].Rows[i][1] != DBNull.Value && ds.Tables[0].Rows[i][2] == DBNull.Value && bankdate > Convert.ToDateTime(ds.Tables[0].Rows[i][1], cinfo)))
                        {
                            result2 += ": можливо недонараховані %%!<BR>Продовжити закриття рахунку?$$PROMPT$$1";
                            return result2;
                        }
                    }
                    if (prompts < 2)
                    {
                        if (ds.Tables[0].Rows[i][6] != DBNull.Value && ds.Tables[0].Rows[i][1] != DBNull.Value)
                        {
                            if (Convert.ToDateTime(ds.Tables[0].Rows[i][6], cinfo) > Convert.ToDateTime(ds.Tables[0].Rows[i][1], cinfo))
                            {
                                result2 += "може ще бути задіяно!<BR>Продовжити закриття рахунку?$$PROMPT$$2";
                                return result2;
                            }
                        }
                    }
                    if (prompts < 3)
                    {
                        ClearParameters();
                        SetParameters("acrA", DB_TYPE.Decimal, ds.Tables[0].Rows[i][0].ToString(), DIRECTION.Input);
                        int perCount = Convert.ToInt32(SQL_SELECT_scalar("select count(*) from int_accn where acra = :acrA"));
                        if (perCount > 1)
                        {
                            result2 += "використовується для декількох рахунків!<BR>Продовжити закриття рахунку?$$PROMPT$$3";
                            return result2;
                        }
                    }

                    ClearParameters();
                    SetParameters("bdat", DB_TYPE.Date, bankdate, DIRECTION.Input);
                    SetParameters("acrA", DB_TYPE.Decimal, ds.Tables[0].Rows[i][0].ToString(), DIRECTION.Input);
                    if (SQL_NONQUERY("UPDATE accounts SET dazs=:bdat WHERE acc=:acrA") == 0)
                        return result2 += "закрити неможливо.";
                    ClearParameters();
                    SetParameters("bdat1", DB_TYPE.Date, bankdate, DIRECTION.Input);
                    SetParameters("bdat2", DB_TYPE.Date, bankdate, DIRECTION.Input);
                    SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                    SetParameters("acrA", DB_TYPE.Decimal, ds.Tables[0].Rows[i][0].ToString(), DIRECTION.Input);
                    if (SQL_NONQUERY("UPDATE int_accn SET stp_dat=:bdat1, acr_dat=:bdat2 WHERE acc=:acc and acra=:acrA") == 0)
                        return result2 += "закрити неможливо.";
                }
                ClearParameters();
                SetParameters("bdat", DB_TYPE.Date, bankdate, DIRECTION.Input);
                SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                SQL_NONQUERY("UPDATE accounts SET dazs=:bdat WHERE acc=:acc");

                if (reason != null)
                {
                    ClearParameters();
                    SetParameters("nAcc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                    SetParameters("nParam", DB_TYPE.Varchar2, "DPAOTYPE", DIRECTION.Input);
                    SetParameters("nOperType", DB_TYPE.Decimal, reason, DIRECTION.Input);
                    SQL_PROCEDURE("accreg.setAccountwParam");
                }
                return result += "закрито!";
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        //Маска счета
        [WebMethod(EnableSession = true)]
        public string[] GetKeyAccount(string mfo, string nls)
        {
            return KeyAccount(mfo, nls);
        }

        //Tools
        //Получить структуру счета
        private Hashtable GetAccountStructure()
        {
            Hashtable tab = new Hashtable();
            try
            {
                string acc_struct = "LBBBBK999999999";
                decimal bAlign = 0; //выравнивать слева FALSE или справа TRUE  
                int MLen = 0; //max длина счета
                int BPos = 0; //поз балансового счета
                int BLen = 0; //длина балансового счета
                int KPos = 0; //позиция контрольного разряда
                InitOraConnection(Context);
                SetRole("basic_info");
                string new_acc_struct = Convert.ToString(SQL_SELECT_scalar("SELECT VAL FROM PARAMS WHERE PAR='ACCSTRUC'"));
                if (new_acc_struct != "") acc_struct = new_acc_struct;
                bAlign = (acc_struct.Substring(0, 1) == "R") ? (1) : (0);
                MLen = acc_struct.Length - 1;
                BPos = acc_struct.IndexOf('B');
                KPos = acc_struct.IndexOf('K');
                BLen = acc_struct.LastIndexOf('B') - BPos + 1;
                if (bAlign == 1)
                {
                    BPos = MLen + 1 - BPos;
                    KPos = MLen + 1 - KPos;
                }
                tab["Align"] = bAlign;
                tab["MLen"] = MLen;
                tab["BPos"] = BPos;
                tab["BLen"] = BLen;
                tab["KPos"] = KPos;
            }
            finally
            {
                DisposeOraConnection();
            }
            return tab;
        }
        //Рассчитать КР счета и подставить его обратно
        private string[] KeyAccount(string sMfo, string sAcc)
        {
            string[] result = new string[2];
            sMfo = sMfo.Trim();
            sAcc = sAcc.Trim();
            if (sAcc.Length == 0) return result;
            try { Convert.ToUInt64(sAcc); }
            catch { return result; }
            if (sMfo.Length == 9)
            {
                sMfo = "00" + sMfo.Substring(6, 3) + "0";
            }
            Hashtable tab = GetAccountStructure();
            decimal nFormula = (decimal)tab["Align"];
            int KPos = (int)tab["KPos"];
            int BPos = (int)tab["BPos"];
            int BLen = (int)tab["BLen"];
            string sCtrlDigit = GetChecksumDigit(sMfo, sAcc, nFormula).ToString();
            string newAcc = string.Empty;
            string newNbs = string.Empty;
            if (nFormula == 1)
            {
                newAcc = sAcc.Substring(0, sAcc.Length - KPos) + sCtrlDigit + sAcc.Substring(KPos - 1);
                string temp = newAcc.Insert(0, "000000000".Substring(0, BLen));
                newNbs = temp.Substring(temp.Length - BPos - 1).Substring(0, BLen);
                if (newAcc.Length < BPos)
                    newAcc = newNbs + newAcc.Substring(newAcc.Length - BPos + BLen - 1);
            }
            else
            {
                if (sAcc.Length < KPos)
                {
                    newAcc = sAcc + sCtrlDigit;
                    if (newAcc.Length < BPos + BLen)
                        newNbs = newAcc;
                    else newNbs = newAcc.Substring(BPos - 1, BLen);
                }
                else
                {
                    sAcc = sAcc.Remove(KPos - 1, 1);
                    newAcc = sAcc.Insert(KPos - 1, sCtrlDigit);
                    newNbs = newAcc.Substring(BPos - 1, BLen);
                }
            }
            result[0] = newAcc;
            result[1] = newNbs;
            return result;
        }
        // Заполнение таблицы-справочника
        [WebMethod(EnableSession = true)]
        public object[] GetManualTable(string[] data)
        {
            try
            {
                InitOraConnection(Context);
                string Role = data[12];
                if (Role == "") Role = "basic_info";
                string TableName = data[11];
                string Fileds = data[10];
                string SqlTail = data[9];
                string ID_Col;
                string VAL_Col;
                SetRole(Role);
                ID_Col = SQL_SELECT_scalar("SELECT trim(C.COLNAME) FROM META_COLUMNS C, META_TABLES T WHERE C.TABID = T.TABID and T.TABNAME = '" + TableName.ToUpper().ToUpper() + "' and C.SHOWRETVAL = 1").ToString();
                if (ID_Col == null) throw new ApplicationException("Ошибка при вычитке из META_COLUMNS");

                VAL_Col = SQL_SELECT_scalar("SELECT trim(C.COLNAME) FROM META_COLUMNS C, META_TABLES T WHERE C.TABID = T.TABID and T.TABNAME = '" + TableName.ToUpper().ToUpper() + "' and C.INSTNSSEMANTIC = 1").ToString();
                if (VAL_Col == null) throw new ApplicationException("Ошибка при вычитке из META_COLUMNS");

                if (Fileds != "")
                {
                    ID_Col = Fileds.Split(';')[0].Replace("*", "' '");
                    if (Fileds.IndexOf(";") != -1)
                        VAL_Col = Fileds.Split(';')[1].Replace("*", "' '"); ;
                }

                data[0] = data[0].Replace("$ID", ID_Col).Replace("$NAME", VAL_Col);

                return BindTableWithFilter(ID_Col + " ID,REPLACE(" + VAL_Col + ",'''','`') NAME", TableName, SqlTail, ID_Col, data);
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public object[] GetMetaTable(string[] data)
        {
            string Filter = data[0].Trim().ToUpper();
            string TblMetaName = data[17].ToUpper();
            string TblName = data[9].ToUpper();
            if (string.IsNullOrEmpty(TblMetaName))
                TblMetaName = TblName;
            string PK_Field = data[10].ToUpper();
            string SK_Field = data[11].ToUpper();
            string SQL_Tail = data[12].Trim();

            SQL_Tail = SQL_Tail.Replace("__prime__", "'"); // заменяем __prime__ на '
            SQL_Tail = SQL_Tail.Replace("__bktOp__", "("); // заменяем __bktOp__ на (
            SQL_Tail = SQL_Tail.Replace("__bktCl__", ")"); // заменяем __bktCl__ на )
            SQL_Tail = SQL_Tail.Replace("__lt__", "<"); // заменяем __lt__ на <
            SQL_Tail = SQL_Tail.Replace("__gt__", ">"); // заменяем __gt__ на >

            string Role = data[13];
            if (Role == string.Empty)
                Role = "BASIC_INFO";
            string Fileds = data[14];
            string Param = data[15];
            int ColName = ("" == data[16].Trim()) ? (0) : (Convert.ToInt32(data[16]));
            string Pop = "SELECT  ";
            DataTable dt_head = new DataTable("HEADER");
            DataTable dt_tabname = new DataTable("TABNAME");
            dt_head.Columns.Add("head");
            dt_tabname.Columns.Add("name");
            try
            {
                InitOraConnection(Context);
                SetRole(Role);
                SetParameters("TblName", DB_TYPE.Varchar2, TblMetaName, DIRECTION.Input);
                string sql = @"SELECT t.tabid, c.colid, c.showpos, trim(c.colname), c.semantic, c.coltype, nvl(c.showwidth,1), c.showmaxchar, 
									   c.showretval, c.instnssemantic, c.extrnval, c.showformat ,t.semantic
									   FROM meta_tables t, meta_columns c 
									   WHERE t.tabid = c.tabid AND t.tabname=:TblName";
                sql += " AND ( c.showin_ro=1 OR c.showretval=1 ";
                if (SK_Field == "")
                    sql += "OR c.instnssemantic=1)";
                else
                {
                    SetParameters("SK_Field", DB_TYPE.Varchar2, SK_Field, DIRECTION.Input);
                    sql += "OR TRIM( c.colname ) = :SK_Field)";
                }
                sql += " ORDER BY c.showpos";

                string PopValuesSet = "";
                int index = 3, pos = 0, col_count = 0;
                string colname = "";
                string[] colnames = new string[20];
                Hashtable cols_id = new Hashtable();

                SQL_Reader_Exec(sql);
                while (SQL_Reader_Read())
                {
                    if (col_count == 9) break;
                    if (ColName != 2 && ColName != 0 && col_count >= ColName) break;
                    if (ColName == 2)
                    {
                        if (SQL_Reader_GetValues()[8].ToString() != "1" && SQL_Reader_GetValues()[9].ToString() != "1")
                            continue;
                    }
                    if (PopValuesSet != "") PopValuesSet += " , ";
                    else
                    {
                        DataRow row = dt_tabname.NewRow();
                        row["name"] = SQL_Reader_GetValues()[12].ToString();
                        dt_tabname.Rows.Add(row);
                    }
                    if (SQL_Reader_GetValues()[8].ToString() == "1" && PK_Field == "")
                    {
                        pos = 1;
                        colname = "COL1";
                    }
                    else if (SQL_Reader_GetValues()[9].ToString() == "1" && SK_Field == "")
                    {
                        pos = 2;
                        if (colnames[pos - 1] != null)
                        {
                            pos = index;
                            colname = "COL" + index++;
                        }
                        else
                            colname = "COL2";
                    }
                    else if (PK_Field != "" && SQL_Reader_GetValues()[3].ToString().ToUpper() == PK_Field)
                    {
                        colname = "COL1";
                        pos = 1;
                    }
                    else if (SK_Field != "" && SQL_Reader_GetValues()[3].ToString().ToUpper() == SK_Field)
                    {
                        colname = "COL2";
                        pos = 2;
                    }
                    
                    else
                    {
                        pos = index;
                        colname = "COL" + index++;
                    }

                    colnames[pos - 1] = SQL_Reader_GetValues()[4].ToString().Replace("~", " ");

                    if (SQL_Reader_GetValues()[5].ToString().ToUpper() == "D")
                        PopValuesSet += "TO_CHAR(" + TblName + "." + SQL_Reader_GetValues()[3].ToString() + ",'DD/MM/YYYY') " + colname;
                    else if (SQL_Reader_GetValues()[5].ToString().ToUpper() == "C")
                        PopValuesSet += "REPLACE(" + TblName + "." + SQL_Reader_GetValues()[3].ToString() + ",'''','`') " + colname;
                    else
                        PopValuesSet += TblName + "." + SQL_Reader_GetValues()[3].ToString() + " " + colname;
                    cols_id[colname] = TblName + "." + SQL_Reader_GetValues()[3].ToString();
                    col_count++;
                }
                SQL_Reader_Close();
                if (col_count == 1)
                {
                    if (PopValuesSet.IndexOf("COL1") < 0)
                        PopValuesSet = PopValuesSet.Replace("COL2", "COL1");
                }

                if (Fileds != "")
                {
                    string str = PopValuesSet;
                    for (int i = 1; i < str.Split(' ').Length; i++)
                    {
                        if (str.Split(' ')[i].Trim() == "COL1")
                        {
                            if (Fileds.Split(';')[0] != "")
                                PopValuesSet = PopValuesSet.Replace(str.Split(' ')[i - 1], Fileds.Split(';')[0].Replace("*", "' '"));
                        }
                        else if (str.Split(' ')[i].Trim() == "COL2")
                        {
                            if (Fileds.IndexOf(";") != -1)
                                PopValuesSet = PopValuesSet.Replace(str.Split(' ')[i - 1], Fileds.Split(';')[1].Replace("*", "' '"));
                        }
                    }
                }

                for (int i = 0; i < col_count; i++)
                {
                    DataRow row = dt_head.NewRow();
                    row["HEAD"] = colnames[i];
                    dt_head.Rows.Add(row);
                }
                string defOrder = string.Empty;
                Pop += PopValuesSet + " FROM " + TblName;

                if (!string.IsNullOrEmpty(SQL_Tail))
                {
                    if (SQL_Tail.ToLower().Contains("order by"))
                    {
                        int ind = SQL_Tail.ToLower().IndexOf("order by");
                        defOrder = SQL_Tail.Substring(ind);
                        if (ind > 0)
                            SQL_Tail = SQL_Tail.Substring(0, ind - 1);
                        else
                            SQL_Tail = string.Empty;
                    }
                    if (!string.IsNullOrEmpty(SQL_Tail))
                    {
                        if (SQL_Tail.Trim().StartsWith("WHERE"))
                            Pop += " " + SQL_Tail;
                        else
                            Pop += " WHERE " + SQL_Tail;
                    }
                }

                if (Filter != "")
                {
                    //todo:виправити питання вказане в коментарії нижче
                    //в одному запросі може бути не більше 7 слів розділених пробілом
                    const string pattern = @"\s:\S*\[((\S*\s*)(\S*\s*)(\S*\s*)(\S*\s*)(\S*\s*)(\S*\s*)(\S*\s*))\]";
                    Filter = Regex.Replace(Filter, pattern, " '$1'");

                    for (int i = 1; i < cols_id.Count + 1; i++)
                    {
                        Filter = Filter.Replace("COL" + i, cols_id["COL" + i].ToString());
                    }
                    if (SQL_Tail == "")
                    {
                        Filter = " WHERE " + Filter.Substring(4);
                    }
                    Pop += " " + Filter;
                }

                if (Pop.ToLower().IndexOf("order by") < 0)
                {
                    if (data[3] != "")
                        Pop += " ORDER BY " + data[3];
                    else if (!string.IsNullOrEmpty(defOrder))
                        Pop += " " + defOrder;
                    else
                        Pop += " ORDER BY 1";
                }
                else
                    if (data[3] != "")
                        Pop = Pop.Substring(0, Pop.ToLower().IndexOf("order by") + 9) + data[3];

                DataSet ds = new DataSet();
                int startpos = Convert.ToInt32(data[4]);
                int pageSize = Convert.ToInt32(data[5]);
                ClearParameters();
                SetParameters("sql_str", DB_TYPE.Varchar2, Pop, DIRECTION.Input);
                if (Param != "")
                    SetParameters("param", DB_TYPE.Varchar2, Param, DIRECTION.Input);
                else
                    SetParameters("param", DB_TYPE.Varchar2, null, DIRECTION.Input);
                ds = SQL_PROC_REFCURSOR("exec_refcursor", startpos, pageSize);
                ds.Tables.Add(dt_head);
                ds.Tables.Add(dt_tabname);
                int count = pageSize + startpos + 1;
                if (ds.Tables[0].Rows.Count < pageSize)
                    count = ds.Tables[0].Rows.Count + startpos;
                return new object[] { ds.GetXml(), count };
            }
            catch (System.Exception e)
            {
                throw e;
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public object[] GetMetaTable_Req(string[] data)
        {
            string[] reqsList = data[9].Split(new string[] { "[split]" }, StringSplitOptions.None); 
            string[] reqsValues = data[11].Split(new string[] { "[split]" }, StringSplitOptions.None); 

            string ReqName = reqsList[0];
            string ReqValue = reqsValues[0];
            string Role = data[10];
            string Filter = data[0];

            DataTable dt_head = new DataTable("HEADER");
            DataTable dt_tabname = new DataTable("TABNAME");
            dt_head.Columns.Add("head");
            dt_tabname.Columns.Add("name");
            try
            {
                InitOraConnection(Context);
                SetRole(Role);
                SetParameters("tag_name", DB_TYPE.Char, ReqName, DIRECTION.Input);
                ArrayList list = SQL_reader("select browser,name from op_field where tag=:tag_name");
                string tag_browser = Convert.ToString(list[0]).Trim();
                if (tag_browser.StartsWith("TagBrowse"))
                {
                    tag_browser = tag_browser.Remove(0, 11);
                    tag_browser = tag_browser.Remove(tag_browser.Length - 1, 1);
                    tag_browser = tag_browser.Trim();
                    tag_browser = tag_browser.Remove(tag_browser.Length - 1, 1);
                    tag_browser = System.Text.RegularExpressions.Regex.Replace(
                        tag_browser, @"\ *(\|\|)*\ *dfNazn\ *(\|\|)*\ *", ReqValue);
                    for (int j = 1; j < reqsList.Length; j++)
                    {
                        tag_browser = System.Text.RegularExpressions.Regex.Replace(
                            tag_browser, @"\ *(\|\|)*\ *" + reqsList[j] + @"\ *(\|\|)*\ *", reqsValues[j]);
                    }
                    tag_browser = tag_browser.Replace("\"", "");
                }
                else
                    tag_browser = string.Empty;

                if (data[3] != "" && tag_browser.ToLower().IndexOf("order by") < 0)
                    tag_browser += " ORDER BY " + data[3].Replace("COL", "");

                DataRow row = dt_tabname.NewRow();
                row["name"] = Convert.ToString(list[1]);
                dt_tabname.Rows.Add(row);

                row = dt_head.NewRow();
                row["HEAD"] = "Код";
                dt_head.Rows.Add(row);

                row = dt_head.NewRow();
                row["HEAD"] = "Текст";
                dt_head.Rows.Add(row);

                DataSet ds = new DataSet();
                int startpos = Convert.ToInt32(data[4]);
                int pageSize = Convert.ToInt32(data[5]);

                if (Filter != "")
                {
                    string result = string.Empty;
                    int index = tag_browser.IndexOf(",");
                    string col1 = tag_browser.Substring(7, index - 7).Trim();
                    string col2 = tag_browser.Substring(index + 1, tag_browser.ToUpper().IndexOf("FROM") - index - 1).Trim();

                    string str_tmp = "";
                    for (int i = 1; i < Filter.Split(' ').Length; i++)
                    {
                        str_tmp = Filter.Split(' ')[i];
                        if (str_tmp.Trim().Length != 0 && str_tmp[0] == ':')
                        {
                            Filter = Filter.Replace(str_tmp, "'" + str_tmp.Substring(str_tmp.IndexOf("[") + 1, str_tmp.IndexOf("]") - str_tmp.IndexOf("[") - 1) + "'");
                        }
                    }
                    Filter = Filter.Replace("COL1", col1);
                    Filter = Filter.Replace("COL2", col2);

                    if (tag_browser.ToUpper().IndexOf("WHERE") < 0)

                        Filter = " WHERE " + Filter.Substring(Filter.ToUpper().IndexOf("AND") + 3);
                    if (tag_browser.ToUpper().IndexOf("ORDER BY") > 0)
                        tag_browser = tag_browser.Insert(tag_browser.ToUpper().IndexOf("ORDER BY"), " " + Filter + " ");
                    else
                        tag_browser += " " + Filter;
                }


                ClearParameters();
                SetParameters("sql_str", DB_TYPE.Varchar2, tag_browser, DIRECTION.Input);
                SetParameters("param", DB_TYPE.Varchar2, null, DIRECTION.Input);
                ds = SQL_PROC_REFCURSOR("exec_refcursor", startpos, pageSize);

                ds.Tables[0].Columns[0].ColumnName = "COL1";
                ds.Tables[0].Columns[1].ColumnName = "COL2";
                ds.Tables.Add(dt_head);
                ds.Tables.Add(dt_tabname);
                int count = pageSize + startpos + 1;
                if (ds.Tables[0].Rows.Count < pageSize)
                    count = ds.Tables[0].Rows.Count + startpos;
                return new object[] { ds.GetXml().Replace("'", "`"), count };
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public object[] GetMetaTable_Base(string[] data)
        {
            string Filter = data[0].Trim().ToUpper();
            string Type = data[9].Trim();
            string Role = data[10];
            string nls = data[11].Trim();
            string mfo = data[12].Trim();
            string kv = data[13];
            string tt = data[14];
            string filter = data[15].Replace("*", "%").Replace("?", "_");
            string[] cols = new string[5];
            DataTable dt_head = new DataTable("HEADER");
            DataTable dt_tabname = new DataTable("TABNAME");
            dt_head.Columns.Add("head");
            dt_tabname.Columns.Add("name");
            try
            {
                InitOraConnection(Context);
                string xps_tts = GetGlobalParam("XPS_TTS", "basic_info");
                string ob22 = GetGlobalParam("OB22", "basic_info");
                string ob22Tail = string.Empty;
                if ("1" == ob22)
                    ob22Tail = " AND ( p.ob22 IS NULL or EXISTS ( SELECT 1 FROM specparam_int i WHERE s.acc=i.acc AND p.ob22=i.ob22 ))";
                string col = "1";
                if (xps_tts == "Y")
                    col = "nvl(x, 1)";
                SetRole(Role);
                string sql = string.Empty;
                if (Type != "-1")
                {
                    cols[0] = "NLS";
                    cols[1] = "KV";
                    cols[2] = "NMS";
                    cols[3] = "OKPO";
                    cols[4] = "NMK";

                    string query = "select " + col + " FROM ps_tts WHERE tt='" + tt + "' and dk=" + Type;
                    ClearParameters();
                    SetParameters("sql_str", DB_TYPE.Varchar2, query, DIRECTION.Input);
                    SetParameters("param", DB_TYPE.Varchar2, null, DIRECTION.Input);
                    DataSet res = SQL_PROC_REFCURSOR("exec_refcursor", 0, 1);
                    string x = "";
                    if (res.Tables[0].Rows.Count > 0)
                        x = res.Tables[0].Rows[0][0].ToString();

                    sql = "select s.nls COL1,s.kv COL2,REPLACE(REPLACE(s.NMS,'''','`'),'\\','/') COL3, k.okpo COL4, REPLACE(k.NMK,'''','`') COL5  from ";
                    if (Type == "0" && mfo != string.Empty)
                    {
                        sql += "saldod s";
                    }
                    else if (Type == "1" && mfo != string.Empty)
                    {
                        sql += "saldok s";
                    }
                    else if (Type == "" && mfo != string.Empty)
                    {
                        sql += "saldo ";
                    }
                    sql += ", customer k,cust_acc a WHERE s.DAZS is null and s.tip<>'VP' and a.rnk=k.rnk AND s.acc=a.acc AND s.dazs IS NULL ";
                    if (x != "")
                        sql += " AND " + ((x == "1") ? ("") : ("NOT")) + @" EXISTS (
                                    SELECT p.nbs FROM ps_tts p
                                     WHERE p.tt='" + tt + "' and p.dk=" + Type + @"
                                      and ( LTRIM(RTRIM(p.nbs)) =  SUBSTR(s.nbs,1,1) or
                                           LTRIM(RTRIM(p.nbs)) =  SUBSTR(s.nbs,1,2) or
                                           LTRIM(RTRIM(p.nbs)) =  SUBSTR(s.nbs,1,3) or p.nbs=s.nbs)" + ob22Tail + ")";
                    if (!string.IsNullOrEmpty(filter))
                        sql += " AND upper(nms) like '%" + filter.ToUpper() + "%'";
                    DataRow row = dt_tabname.NewRow(); row["name"] = "Лицевые счета"; dt_tabname.Rows.Add(row);
                    row = dt_head.NewRow(); row["HEAD"] = "Номер счета"; dt_head.Rows.Add(row);
                    row = dt_head.NewRow(); row["HEAD"] = "Валюта"; dt_head.Rows.Add(row);
                    row = dt_head.NewRow(); row["HEAD"] = "Наименование счета"; dt_head.Rows.Add(row);
                    row = dt_head.NewRow(); row["HEAD"] = "ОКПО"; dt_head.Rows.Add(row);
                    row = dt_head.NewRow(); row["HEAD"] = "Клиент"; dt_head.Rows.Add(row);
                }
                else
                {
                    cols[0] = "MFO";
                    cols[1] = "NLS";
                    cols[2] = "NAME";
                    cols[3] = "OKPO";
                    cols[4] = "KV";
                    sql = "select mfo COL1,nls COL2, REPLACE(name,'''','`') COL3,okpo COL4, kv COL5 from alien WHERE id = user_id or id is null";
                    if (mfo != string.Empty)
                        sql += " and mfo='" + mfo + "'";
                    if (!string.IsNullOrEmpty(filter))
                        sql += " AND upper(name) like '%" + filter.ToUpper() + "%'";


                    DataRow row = dt_tabname.NewRow(); row["name"] = "Контрагенты"; dt_tabname.Rows.Add(row);
                    row = dt_head.NewRow(); row["HEAD"] = "Мфо"; dt_head.Rows.Add(row);
                    row = dt_head.NewRow(); row["HEAD"] = "Номер счета"; dt_head.Rows.Add(row);
                    row = dt_head.NewRow(); row["HEAD"] = "Наименование счета"; dt_head.Rows.Add(row);
                    row = dt_head.NewRow(); row["HEAD"] = "ОКПО"; dt_head.Rows.Add(row);
                    row = dt_head.NewRow(); row["HEAD"] = "Код валюты"; dt_head.Rows.Add(row);
                }
                if (nls != string.Empty)
                {
                    nls = nls.Replace("*", "%");
                    if (sql.IndexOf("WHERE") == -1)
                        sql += " WHERE nls like '" + nls + "'";
                    else
                        sql += " and nls like '" + nls + "'";
                }

                if (kv != string.Empty)
                {
                    if (sql.IndexOf("WHERE") == -1)
                        sql += " WHERE KV=" + kv;
                    else
                        sql += " AND KV=" + kv;
                }

                if (Filter != "")
                {
                    string str_tmp = "";
                    for (int i = 1; i < Filter.Split(' ').Length; i++)
                    {
                        str_tmp = Filter.Split(' ')[i];
                        if (str_tmp.Trim().Length != 0 && str_tmp[0] == ':')
                        {
                            Filter = Filter.Replace(str_tmp, "'" + str_tmp.Substring(str_tmp.IndexOf("[") + 1, str_tmp.IndexOf("]") - str_tmp.IndexOf("[") - 1) + "'");
                        }
                    }

                    Filter = Filter.Replace("COL1", cols[0]);
                    Filter = Filter.Replace("COL2", cols[1]);
                    Filter = Filter.Replace("COL3", cols[2]);

                    if (sql.IndexOf("WHERE") == -1)
                    {
                        Filter = " WHERE " + Filter.Substring(4);
                    }
                    sql += " " + Filter;
                }
                if (data[3] != "")
                    sql += " ORDER BY " + data[3];


                DataSet ds = new DataSet();
                int startpos = Convert.ToInt32(data[4]);
                int pageSize = Convert.ToInt32(data[5]);

                //Logger.DBLogger.Error("GetMetaTable_Base:::" + sql);

                ClearParameters();
                SetParameters("sql_str", DB_TYPE.Varchar2, sql, DIRECTION.Input);
                SetParameters("param", DB_TYPE.Varchar2, null, DIRECTION.Input);
                ds = SQL_PROC_REFCURSOR("exec_refcursor", startpos, pageSize);
                ds.Tables.Add(dt_head);
                ds.Tables.Add(dt_tabname);
                int count = pageSize + startpos + 1;
                if (ds.Tables[0].Rows.Count < pageSize)
                    count = ds.Tables[0].Rows.Count + startpos;
                return new object[] { ds.GetXml(), count };
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        //Вставка пользовательського фильтра
        [WebMethod(EnableSession = true)]
        public int SetFilter(string fName, string tabid, string where, string tables)
        {
            int result = 0;
            try
            {
                InitOraConnection();
                SetRole("wr_filter");

                SetParameters("tabid", DB_TYPE.Decimal, tabid, DIRECTION.Input);
                SetParameters("fname", DB_TYPE.Varchar2, fName, DIRECTION.Input);
                SetParameters("fr", DB_TYPE.Varchar2, tables, DIRECTION.Input);
                SetParameters("wh", DB_TYPE.Varchar2, where, DIRECTION.Input);
                result = SQL_NONQUERY(@"INSERT INTO dyn_filter (filter_id, tabid, userid, semantic, from_clause, where_clause)
							            VALUES (0, :tabid, user_id, :fname, :fr, :wh)");
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }
        //Удаление пользовательського фильтра
        [WebMethod(EnableSession = true)]
        public int DelFilter(string id)
        {
            int result = 0;
            try
            {
                InitOraConnection();
                SetRole("wr_filter");

                SetParameters("id", DB_TYPE.Decimal, id, DIRECTION.Input);
                result = SQL_NONQUERY("delete from dyn_filter where filter_id=:id");
            }
            finally
            {
                DisposeOraConnection();
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public void PushMessage(string UserLogin, string Message, string TypeId)
        {
            CometClientProcessor.PushData(UserLogin, Message);
        }

        [WebMethod(EnableSession = true)]
        public void GenerateReport(decimal queryId,string userName,decimal userId)
        {
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture(ConfigurationSettings.AppSettings.Get("Localization.UICulture"));
            //аторизуємо користувача для роботи з HttpContext;
            CustomIdentity userIdentity = new CustomIdentity(userName, 1, true, false, userName, "", "");
            CustomPrincipal principal = new CustomPrincipal(userIdentity, new ArrayList());
            HttpContext.Current.User = principal;
            var repository = new AccountRepository(new AppModel());
            repository.LoginUser(userId);

            //робота із звітом
            using (var report = new CreateReport(queryId, OraConnector.Handler.IOraConnection.GetUserConnectionString()))
            {
                try
                {
                    if (report.Results.STATUS_ID != "STARTCREATEDFILE" && report.Results.STATUS_ID != "CREATEDFILE")
                    {
                        report.SetStatus("STARTCREATEDFILE", "");
                        report.Prepared();
                        report.SaveToBase();
                    }
                }
                catch (System.Exception e)
                {
                    report.SetStatus("ERROR", "Помилка формування файла: " + e.Message + (e.InnerException == null ? "" : " (" + e.InnerException.Message + ")"));
                }
            }
            //убиваємо авторизаційні дані
            repository.LogOutUser();
        }

        #region Component Designer generated code
        private IContainer components = null;
        private void InitializeComponent()
        {
        }
        protected override void Dispose(bool disposing)
        {
            if (disposing && components != null)
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #endregion
    }
}
