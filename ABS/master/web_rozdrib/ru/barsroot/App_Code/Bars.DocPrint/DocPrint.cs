using System;
using System.Globalization;
using System.IO;
using System.Collections;
using System.Collections.Specialized;
using System.Text;
using System.Data;
using System.Web;
using Oracle.DataAccess.Client;

using Bars.Exception;
using Bars.Oracle;
using Bars.Classes;

namespace Bars.DocPrint
{
    public class cDocPrint
    {
        # region Приватные свойства
        public OracleConnection con;
        //public OracleCommand cmd;

        private string _sDBLink = "";

        private int nLeftMargin = 0;
        private int nRightMargin = 0;
        private int nTextWidth = 80;
        private int nActualWidth = 80;
        private bool printTrnModel = false;

        /// <summary>
        /// 0 -TextLEFT, 1 - TextCenter,  2 - TextRight
        /// </summary>
        private int nCenterMode = 0;
        string Vars;
        string Vals;
        string TicName;
        string Tnam;
        string TT;
        decimal ExtRef;
        long InRef;
        string _strTicketFile;
        StringDictionary TagSub = new StringDictionary();
        # endregion

        # region Публичные методы
        public bool PrintTrnModel
        {
            get { return printTrnModel; }
            set { printTrnModel = value; }
        }


        /// <summary>
        /// Получение уникального имени файла тикета во временной директории
        /// </summary>
        /// <returns>имя файла тикета</returns>
        public static string GetRandomFileName()
        {
            return GetRandomFileName("");
        }
        public static string GetRandomFileName(string Ref)
        {
            Random rnd = new Random();
            string strTempDir = Path.Combine(Environment.GetEnvironmentVariable("TEMP"), HttpContext.Current.Session.SessionID);
            if (!Directory.Exists(strTempDir))
            {
                Directory.CreateDirectory(strTempDir);
            }
            string strTicketFile = Path.Combine(strTempDir,
                                                string.Format("ticket_{0}{1}_{2}.txt",
                                                                Ref,
                                                                DateTime.Now.ToString("dd_MM_yyyy_HH_mm_ss_fffffff"),
                                                                rnd.Next()));
            return strTicketFile;
        }

        public string GetTicketFileName()
        {
            return _strTicketFile;
        }
        /// <summary>
        /// Удаление временного файла тикета
        /// </summary>
        public void DeleteTempFiles()
        {
            try
            {
                System.IO.File.Delete(_strTicketFile);
            }
            catch (System.Exception)
            {	// давим все исключения
            }
        }

        public string GetSwiftMessage(decimal refDoc)
        {
            string result = string.Empty;
            string nl = Environment.NewLine;
            OracleConnection connect = OraConnector.Handler.UserConnection;
            OracleCommand cmd = new OracleCommand();
            cmd.Connection = connect;

            try
            {
                cmd.CommandText = "SELECT swref FROM sw_oper WHERE ref=:ref ORDER BY swref";
                cmd.Parameters.Add("ref", OracleDbType.Decimal, refDoc, ParameterDirection.Input);
                OracleDataReader reader = cmd.ExecuteReader();
                ArrayList swRefs = new ArrayList();
                while (reader.Read())
                    swRefs.Add(Convert.ToString(reader.GetValue(0)));

                foreach (string swRef in swRefs)
                {
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("swref", OracleDbType.Decimal, swRef, ParameterDirection.Input);
                    cmd.CommandText = @"select j.mt, 
                                           j.io_ind,
                                           j.sender,   nvl(b1.name, 'Відсутній в довіднику'), b1.office,
                                           j.receiver, nvl(b2.name, 'Відсутній в довіднику'), b2.office,
                                           (select count(*) from dual 
                                            where exists (select 1 from sw_stmt s where s.mt = j.mt))
                                 from sw_journal j, sw_banks b1, sw_banks b2
                               where j.swref = :swref
                                   and b1.bic(+)  = j.sender
                                   and b2.bic(+)  = j.receiver";
                    reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        string mt = Convert.ToString(reader.GetValue(0));
                        string stmt = Convert.ToString(reader.GetValue(8));
                        result += "".PadRight(60, '-') + nl;
                        result += "Message : MT" + mt + " (" + Convert.ToString(reader.GetValue(1)) + ")" + nl;
                        result += "Sender  : " + Convert.ToString(reader.GetValue(2)) + nl;
                        result += "          " + Convert.ToString(reader.GetValue(3)) + nl;
                        if (!reader.IsDBNull(4))
                            result += "          " + Convert.ToString(reader.GetValue(4)) + nl;
                        result += "Receiver: " + Convert.ToString(reader.GetValue(5)) + nl;
                        result += "          " + Convert.ToString(reader.GetValue(6)) + nl;
                        if (!reader.IsDBNull(7))
                            result += "          " + Convert.ToString(reader.GetValue(7)) + nl;
                        result += "".PadRight(60, '-') + nl;
                        result += "Message Body" + nl;

                        if (stmt == "0")
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("mt", OracleDbType.Varchar2, mt, ParameterDirection.Input);
                            cmd.Parameters.Add("mt", OracleDbType.Varchar2, mt, ParameterDirection.Input);
                            cmd.Parameters.Add("swref", OracleDbType.Decimal, swRef, ParameterDirection.Input);
                            cmd.CommandText = @"select w.tag, w.opt, w.seq, w.n, 
                                                    substr(bars_swift.get_message_fieldname(:mt, w.seq, w.tag, w.opt), 1, 100),
                                                    bars_swift.get_message_fieldvalue(:mt, w.seq, w.tag, w.opt, w.value)
                                                from sw_operw w where w.swref=:swref order by w.n";
                        }
                        else
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("swref", OracleDbType.Decimal, swRef, ParameterDirection.Input);
                            cmd.Parameters.Add("ref", OracleDbType.Decimal, refDoc, ParameterDirection.Input);
                            cmd.CommandText = @"select swrnum into :nStmtNum from sw_oper where swref = :swref and ref = :ref";
                            string swrNum = Convert.ToString(cmd.ExecuteScalar());

                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("mt", OracleDbType.Varchar2, mt, ParameterDirection.Input);
                            cmd.Parameters.Add("mt", OracleDbType.Varchar2, mt, ParameterDirection.Input);
                            cmd.Parameters.Add("swref", OracleDbType.Decimal, swRef, ParameterDirection.Input);
                            cmd.Parameters.Add("swrNum", OracleDbType.Varchar2, swrNum, ParameterDirection.Input);
                            cmd.CommandText = @"select w.tag, w.opt, w.seq, w.n, 
                                                    substr(bars_swift.get_message_fieldname(:mt, w.seq, w.tag, w.opt), 1, 100),
                                                    bars_swift.get_message_fieldvalue(:mt, w.seq, w.tag, w.opt,w.value)
                                                from sw_operw w where w.swref=:nSwRef and w.n = :swrNum
                                                order by w.n";
                        }

                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            string tag = Convert.ToString(reader.GetValue(0));
                            string opt = Convert.ToString(reader.GetValue(1));
                            string field = Convert.ToString(reader.GetValue(4));
                            string val = Convert.ToString(reader.GetValue(5));
                            val = val.Replace("\n", "      ");
                            result += (tag + opt).PadLeft(4) + ": " + field + nl + "      " + val + nl;
                        }
                        result += nl + nl;
                    }
                }

                reader.Close();
                reader.Dispose();
            }
            finally
            {
                cmd.Dispose();
                connect.Close();
                connect.Dispose();
            }

            return result;
        }

        public void DocsReport(string FnQrd, string FnDoc)
        {
            try
            {
                // Читаем Файл шаблона.
                using (StreamReader si = new StreamReader(FnQrd, System.Text.Encoding.GetEncoding(1251)))
                using (StreamWriter so = new StreamWriter(FnDoc, false, System.Text.Encoding.GetEncoding(1251)))
                {
                    String line;
                    string rez;
                    bool pageBreak = HttpContext.Current.Session != null && HttpContext.Current.Session["Print.UsePageBreak"] == "Yes";
                    bool defIF = false;

                    // Читаем файл шаблона и применяем функцию подстановки к каждой строке 
                    while ((line = si.ReadLine()) != null)
                    {
                        if (!line.StartsWith("[REM"))
                        {
                            rez = TransString(line); //.TrimEnd(); //PadRight(nActualWidth);
                            nActualWidth = nTextWidth - nLeftMargin - nRightMargin;

                            if (rez.Length < nActualWidth)
                            {
                                if (nCenterMode == 0) rez = rez.PadRight(nActualWidth);
                                else if (nCenterMode == 1) rez = rez.PadLeft((nActualWidth - rez.Length) / 2);
                                else if (nCenterMode == 2) rez = rez.PadLeft(nActualWidth);
                            }
                            else if (rez.Length < nActualWidth)
                            {
                                rez = rez.PadRight(nActualWidth);
                            }
                            else if (rez.IndexOf(Environment.NewLine) < 0)
                            {
                                rez = rez.Insert(nActualWidth, System.Environment.NewLine);
                            }

                            if (rez.Trim().ToUpper().StartsWith("#IF") && rez.Trim().Length == 3)
                                defIF = true;
                            if (rez.Trim().ToUpper().StartsWith("#ENDIF"))
                                defIF = false;

                            if (!defIF && !rez.Trim().ToUpper().StartsWith("#IF") && !rez.Trim().ToUpper().StartsWith("#ENDIF"))
                            {
                                if (pageBreak)
                                    so.WriteLine(rez);
                                else
                                    so.WriteLine(rez.TrimEnd());
                            }
                        }
                    }
                    OracleCommand cmd = this.con.CreateCommand();

                    // Печать бух.модели
                    if (printTrnModel)
                    {
                        so.WriteLine("");

                        so.WriteLine("   Перелік транзакцій для документа # " + InRef);
                        so.WriteLine("");

                        so.WriteLine("   Тип:   Дата   : Рахунок       :Вал:     Дебет      :     Кредит     :   Еквівалент   :");
                        so.WriteLine("   трн: валютув. :" + "".PadRight(15, ' ') + ":   :" + "".PadRight(16, ' ') + ":" + "".PadRight(16, ' ') + ":" + "".PadRight(16, ' ') + ":");
                        so.WriteLine("   " + "".PadRight(86, '-'));

                        cmd.CommandText = @"SELECT o.tt,o.dk,a.nls,a.kv,t.dig,o.fdat,o.s/t.denom,gl.p_icurval(a.kv, o.s, o.fdat)/100,o.txt,r.nls,r.kv
                                             FROM opldok o, accounts a, tabval$global t, accounts r 
                                             WHERE t.kv=a.kv and a.acc=o.acc and r.acc(+)=a.accc and o.ref=:ref and o.sos is not null
                                             ORDER BY o.fdat, a.kv, o.stmt, o.tt, o.dk";
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.Add("ref", OracleDbType.Decimal, InRef, ParameterDirection.Input);
                        OracleDataReader rdr = cmd.ExecuteReader();
                        cmd.Parameters.Clear();
                        string nlsParent = string.Empty;
                        while (rdr.Read())
                        {
                            so.WriteLine("   " + Convert.ToString(rdr.GetValue(0)).PadLeft(3, ' ') + " " +
                                         rdr.GetDateTime(5).ToString("dd/MM/yyyy") + " " +
                                         Convert.ToString(rdr.GetValue(2)).PadRight(15, ' ') + Convert.ToString(rdr.GetValue(3)).PadLeft(4, ' ') + " " +
                                         ((rdr.GetDecimal(1) > 0) ? ("".PadRight(17) + string.Format("{0:F2}", rdr.GetValue(6)).PadLeft(16, ' ').Replace(".", ",")) : (string.Format("{0:F2}", rdr.GetValue(6)).PadLeft(16, ' ').Replace(".", ",") + "".PadRight(17))) +
                                         string.Format("{0:F2}", rdr.GetValue(7)).PadLeft(17, ' ').Replace(".", ",") + " ");
                            nlsParent = Convert.ToString(rdr.GetValue(9));
                            if (!string.IsNullOrEmpty(nlsParent))
                            {
                                so.WriteLine("".PadRight(15) + "-> " + nlsParent.PadRight(15) + Convert.ToString(rdr.GetValue(10)).PadLeft(4));
                                nlsParent = string.Empty;
                            }

                        }
                        so.WriteLine("   " + "".PadRight(86, '-'));
                        rdr.Close();
                        rdr.Dispose();
                    }
                    // Печать swift реквизитов

                    cmd.CommandText = "select swref from sw_oper where ref=:ref";
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("ref", OracleDbType.Decimal, InRef, ParameterDirection.Input);
                    OracleDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        try
                        {
                            string swMessage = GetSwiftMessage(InRef);
                            if (!string.IsNullOrEmpty(swMessage))
                            {
                                so.WriteLine();
                                so.Write(swMessage);
                            }
                        }
                        catch { }
                    }
                    else
                    {
                        cmd.CommandText = "SELECT substr(trim(value),-3) FROM operw WHERE ref=:ref AND trim(tag)='f'";
                        reader = cmd.ExecuteReader();
                        // SWIFT
                        if (reader.Read())
                        {
                            string smt = Convert.ToString(reader.GetValue(0));
                            string strSender = string.Empty;
                            string strSndrName = string.Empty;
                            string strReceiver = string.Empty;
                            string strRcvrName = string.Empty;
                            cmd.CommandText = "SELECT trim(p.val), NVL(b.name,'Відсутній в довіднику') FROM params p, sw_banks b WHERE p.par='BICCODE' AND trim(p.val)=b.bic(+)";
                            reader = cmd.ExecuteReader();
                            if (reader.Read())
                            {
                                strSender = Convert.ToString(reader.GetValue(0));
                                strSndrName = Convert.ToString(reader.GetValue(1));
                            }

                            so.WriteLine();
                            so.WriteLine();
                            so.WriteLine(string.Empty.PadRight(60, '-'));
                            so.WriteLine("Message : MT" + smt);
                            so.WriteLine("Sender  : " + strSender);
                            so.WriteLine("          " + strSndrName);
                            so.WriteLine("Receiver: " + strReceiver);
                            so.WriteLine("          " + strRcvrName);
                            so.WriteLine("Message Body");

                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("smt", OracleDbType.Varchar2, smt, ParameterDirection.Input);
                            cmd.CommandText = "SELECT tag, opt, num FROM sw_model WHERE mt=:smt";
                            reader = cmd.ExecuteReader();
                            while (reader.Read())
                            {
                                string tag = Convert.ToString(reader.GetValue(0));
                                string opt = Convert.ToString(reader.GetValue(1));
                                string num = Convert.ToString(reader.GetValue(2));
                                string tagW = string.Empty;
                                if (opt == opt.ToLower() && !string.IsNullOrEmpty(opt))
                                {
                                    cmd.Parameters.Clear();
                                    cmd.Parameters.Add("smt", OracleDbType.Varchar2, smt, ParameterDirection.Input);
                                    cmd.Parameters.Add("num", OracleDbType.Decimal, num, ParameterDirection.Input);
                                    cmd.CommandText = "select decode(opt,'-','',opt) from sw_model_opt where mt=:smt and num=:num";
                                    OracleDataReader readerIn = cmd.ExecuteReader();
                                    while (readerIn.Read())
                                    {
                                        opt = Convert.ToString(readerIn.GetValue(0));
                                        tagW = tag + opt;
                                        cmd.Parameters.Clear();
                                        cmd.Parameters.Add("ref", OracleDbType.Decimal, InRef, ParameterDirection.Input);
                                        cmd.Parameters.Add("tag", OracleDbType.Char, tagW, ParameterDirection.Input);
                                        cmd.CommandText = "select trim(value) from operw where ref=:ref and tag=:tag";
                                        string val = Convert.ToString(cmd.ExecuteScalar());
                                        if (!string.IsNullOrEmpty(val))
                                            so.WriteLine("".PadRight(4 - tagW.Length) + tagW + ": " + val);
                                    }
                                    readerIn.Close();
                                    readerIn.Dispose();
                                }
                                else
                                {
                                    tagW = tag + opt;
                                    cmd.Parameters.Clear();
                                    cmd.Parameters.Add("ref", OracleDbType.Decimal, InRef, ParameterDirection.Input);
                                    cmd.Parameters.Add("tag", OracleDbType.Char, tagW, ParameterDirection.Input);
                                    cmd.CommandText = "select trim(value) from operw where ref=:ref and tag=:tag";
                                    string val = Convert.ToString(cmd.ExecuteScalar());
                                    if (!string.IsNullOrEmpty(val))
                                        so.WriteLine("".PadRight(4 - tagW.Length) + tagW + ": " + val);
                                }
                            }
                        }
                        // BIS
                        else
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("ref", OracleDbType.Decimal, InRef, ParameterDirection.Input);
                            cmd.CommandText = "SELECT bis FROM arc_rrp WHERE ref=:ref";
                            reader = cmd.ExecuteReader();
                            if (reader.Read() && reader.GetOracleDecimal(0) > 0)
                            {
                                so.WriteLine();
                                so.WriteLine();
                                cmd.CommandText = @"SELECT b.nazn||decode(b.nazns,33,b.d_rec,'') 
                                                         FROM arc_rrp a, arc_rrp b    
                                                         WHERE a.ref=:ref
                                                           AND a.bis=1 AND a.fn_a=b.fn_a AND a.dat_a=b.dat_a 
                                                           AND a.rec<>b.rec AND a.rec_a-a.bis=b.rec_a-b.bis AND b.bis>0 
                                                         ORDER BY b.bis";
                                reader = cmd.ExecuteReader();
                                while (reader.Read())
                                {
                                    string nazn = Convert.ToString(reader.GetValue(0));
                                    so.WriteLine(nazn);
                                }
                            }
                            else
                            {
                                cmd.CommandText = "select count(*) from operw w, op_field d where w.ref=:ref and w.tag=d.tag and d.fmt='SWT'";
                                reader = cmd.ExecuteReader();
                                if (reader.Read() && reader.GetOracleDecimal(0) > 0)
                                {
                                    so.WriteLine();
                                    so.WriteLine();
                                    cmd.CommandText = @"select '#F'||trim(w.tag)||':'||trim(w.value)||'#'
                                                             from operw w, op_field d
                                                             where w.ref=:ref and w.tag=d.tag and d.fmt='SWT'
                                                             order by d.tag";
                                    reader = cmd.ExecuteReader();
                                    while (reader.Read())
                                    {
                                        so.WriteLine(Convert.ToString(reader.GetValue(0)));
                                    }

                                }
                            }
                        }
                    }
                    reader.Close();
                    reader.Dispose();
                    cmd.Dispose();
                }
            }
            catch (BarsException e)
            {
                throw e;

            }

        }
        public void ParseVars(string Var, string Val)
        {
            string[] VarArray = Var.Split('~');
            string[] ValArray = Val.Split('~');

            int length = (VarArray.Length >= ValArray.Length) ? (ValArray.Length) : (VarArray.Length);

            for (int i = 0; i < length; i++)
            {
                if (!this.TagSub.ContainsKey(VarArray[i]))
                    this.TagSub.Add(VarArray[i], ValArray[i]);
            }

        }
        public string TransString(string si)
        {
            if (si == "") return si;

            ArrayList so = new ArrayList();  // Исходящая строка
            int j;
            int i = 0;

            while (true)
            {
                j = si.IndexOf('[', i);
                if (j < 0) break;
                if (j > i) so.Add(si.Substring(i, j - i));  // текст 
                i = si.IndexOf(']', j);
                if (i < 0) { i = j; break; }
                if (i > j) so.Add(si.Substring(j, ++i - j)); // текст
            }
            if (i < si.Length) so.Add(si.Substring(i));

            string rez = "";
            foreach (string s in so)
            {
                if (s.StartsWith("[")) rez = rez + Tagging(s);
                else
                {
                    if (s.IndexOf((char)27) >= 0)
                    {
                        string st = s;
                        while (st.IndexOf((char)27) >= 0) st = st.Remove(st.IndexOf((char)27), 2);
                        rez = rez + st;
                    }
                    else rez = rez + s;
                }
            }
            return rez;
        }
        private string GetBarsErrMess(string eMessage)
        {
            string s = eMessage;
            if (s.Substring(0, 6) == "ORA-20")
            {
                int i = s.IndexOf("\\");
                if (i >= 0) { s = s.Substring(i); }
                s = s.Substring(0, s.IndexOf("\n"));
            }
            return s;
        }
        /// <summary>
        /// Печать оттиска
        /// </summary>
        /// <param name="vars">переменные</param>
        /// <param name="vals">значения</param>
        /// <param name="fn_ottisk">имя файла-оттиска(без .QRD)</param>
        /// <returns></returns>
        public string PrintOttisk(string vars, string vals, string fn_ottisk)
        {
            this.Vars = vars;
            this.Vals = vals;
            this.TicName = fn_ottisk;
            this._strTicketFile = GetRandomFileName();
            this.ParseVars(this.Vars, this.Vals);
            this.DocsReport(fn_ottisk + ".QRD", _strTicketFile);
            return _strTicketFile;
        }
        public string Tagging(string s)
        {
            string[] tg = null;
            string rez = "";

            if (s.StartsWith("[REF="))
            {
                tg = s.Split(new char[] { ',', ']' });
                string varName = "";
                string varType = "C";
                int varLen = 0;
                int nDec = 0;
                bool bTrimOn = false;

                if (tg.Length > 0)
                {
                    varName = tg[0].Substring(5);
                    varType = tg[1];
                    Int32.TryParse(tg[2].Trim(), out varLen);

                    //varLen = Convert.ToInt32(tg[2].Trim(), 10);
                }
                if (tg.Length > 3)
                {
                    try { nDec = Convert.ToInt32("0" + tg[3], 10); }
                    catch { }
                }
                if (tg.Length > 4 && tg[4] == "TRUE") bTrimOn = true;
                if (TagSub.ContainsKey(varName)) rez = TagSub[varName].PadRight(varLen); else rez = "";
                if (!bTrimOn)
                {
                    if (varType == "C") rez = rez.PadRight(varLen);
                    else if (varType == "T") // бьем число на триады
                    {
                        try
                        {
                            string delims = ",.";
                            int dPos = rez.Contains(",") ? (0) : (1);
                            rez = string.Format("{0:N}", Convert.ToDecimal(rez.Replace(",", ".").Trim())).Replace(",", " ").Replace(delims[1 - dPos], delims[dPos]);
                        }
                        catch { }
                        rez = rez.PadLeft(varLen);
                    }
                    else rez = rez.Trim().PadLeft(varLen);
                }
                else
                    rez = rez.Trim();
                if (rez.Length > varLen)
                    rez = rez.Substring(0, varLen);

                if (rez.Length > 85)
                {
                    string tmpRez = string.Empty;
                    int nlPos = 1, wordLen = 0;
                    foreach (var word in rez.Split(new[] { ' ' }))
                    {
                        if ((tmpRez + word).Length >= nTextWidth * nlPos - wordLen)
                        {
                            tmpRez += Environment.NewLine;
                            wordLen = word.Length;
                            nlPos++;
                        }
                        tmpRez += word + " ";
                    }
                    rez = tmpRez;
                }
                //if (rez.Length > 85) rez = rez.Insert(85, "\n");
                return rez;
            }

            else if (s.StartsWith("[WIDTH="))
            { tg = s.Split(']'); nTextWidth = Convert.ToInt32(tg[0].Substring(7), 10); return ""; }

            else if (s.StartsWith("[ALIGN="))
            {
                tg = s.Split(']');
                if (tg[0].Substring(7).ToUpper() == "LEFT") nCenterMode = 0;
                else if (tg[0].Substring(7).ToUpper() == "CENTER") nCenterMode = 1;
                else if (tg[0].Substring(7).ToUpper() == "RIGHT") nCenterMode = 2; return "";
            }
            else if (s.StartsWith("[RMARGIN="))
            { tg = s.Split(']'); nRightMargin = Convert.ToInt32(tg[0].Substring(9), 10); return ""; }

            else if (s.StartsWith("[LMARGIN="))
            { tg = s.Split(']'); nLeftMargin = Convert.ToInt32(tg[0].Substring(9), 10); return ""; }

            else if (s.StartsWith("[LFEED"))
            { return "/n/r"; }
            else if (s.StartsWith("[ESC") || s.StartsWith("[PCL"))
            {
                // управляющие символы оставляем DRint'у
                return s;
            }

            else return rez;
        }
        public bool DocPrintTest(long Ref)
        {
            OracleCommand cmd = this.con.CreateCommand();

            cmd.CommandType = CommandType.Text;
            cmd.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("basic_info");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "tic.getListAttr" + (this._sDBLink == "" ? "" : "@" + this._sDBLink);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("ref", OracleDbType.Decimal, Ref, ParameterDirection.Input);  //0
            cmd.Parameters.Add("tab", OracleDbType.Varchar2, "OPER", ParameterDirection.Input);  //1
            cmd.Parameters.Add("mode", OracleDbType.Decimal, 0, ParameterDirection.Input);  //2
            cmd.Parameters.Add("name", OracleDbType.Varchar2, 20, this.Tnam, ParameterDirection.InputOutput); //3
            cmd.Parameters.Add("vars", OracleDbType.Varchar2, 20000, this.Vars, ParameterDirection.InputOutput); //4
            cmd.Parameters.Add("vals", OracleDbType.Varchar2, 20000, this.Vals, ParameterDirection.InputOutput); //5
            cmd.Parameters.Add("tt", OracleDbType.Varchar2, 3, this.TT, ParameterDirection.InputOutput); //6
            cmd.Parameters.Add("ext", OracleDbType.Decimal, this.ExtRef, ParameterDirection.InputOutput); //7
            try
            {
                cmd.ExecuteNonQuery();
                this.Vars = cmd.Parameters["vars"].Value.ToString();
                this.Vals = cmd.Parameters["vals"].Value.ToString();
                this.TicName = cmd.Parameters["name"].Value.ToString();
            }
            catch (OracleException e)
            {
                throw new BarsException(" DocPrint: " + GetBarsErrMess(e.Message), e);
            }
            catch (System.Exception e)
            {
                throw e;
            }
            finally
            {
                cmd.Dispose();
            }
            return true;
        }
        # endregion

        # region Конструкторы
        public cDocPrint()
        {
        }
        public cDocPrint(OracleConnection con, long Ref, string TemplPath) :
            this(con, Ref, TemplPath, GetRandomFileName(Ref.ToString()))
        {
        }
        public cDocPrint(OracleConnection con, long Ref, string TemplPath, string FnDoc) :
            this(Ref, TemplPath, FnDoc, "")
        {
        }
        public cDocPrint(long Ref, string TemplPath) :
            this(Ref, TemplPath, GetRandomFileName(Ref.ToString()), "")
        {
        }
        public cDocPrint(long Ref, string TemplPath, string DBLink) :
            this(Ref, TemplPath, GetRandomFileName(Ref.ToString()), DBLink)
        {
        }
        public cDocPrint(OracleConnection con, long Ref, string TemplPath, bool printTrnModel)
        {
            this.InRef = Ref;
            this.printTrnModel = printTrnModel;
            this.con = ((IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass")).GetUserConnection();

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                this.DocPrintTest(Ref);
                this.ParseVars(this.Vars, this.Vals);
                _strTicketFile = GetRandomFileName(Ref.ToString());
                this.DocsReport(TemplPath + TicName + ".QRD", _strTicketFile);
            }
            finally
            {
                if (ConnectionState.Open == con.State)
                    con.Close();
                con.Dispose();

                if (ConnectionState.Open == this.con.State)
                    this.con.Close();
                this.con.Dispose();
            }
        }

        public cDocPrint(long Ref, string TemplPath, string FnDoc, string DBLink)
        {
            this._sDBLink = DBLink;
            this.InRef = Ref;
            this.con = ((IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass")).GetUserConnection();

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                this.DocPrintTest(Ref);
                this.ParseVars(this.Vars, this.Vals);
                _strTicketFile = FnDoc;
                this.DocsReport(TemplPath + TicName + ".QRD", _strTicketFile);
            }
            finally
            {
                if (ConnectionState.Open == con.State)
                    con.Close();
                con.Dispose();
            }
        }

        # endregion
    }
}
