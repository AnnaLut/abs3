using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using barsroot.cim;
using Oracle.DataAccess.Client;
using Ionic.Zip;
using System.Text;
using System.Collections.Generic;
using System.Linq;

public partial class corp2_export_docs : System.Web.UI.Page
{
    protected void MainScriptManager_AsyncPostBackError(object sender, AsyncPostBackErrorEventArgs e)
    {
        Exception ex = e.Exception;
        if (ex is System.Reflection.TargetInvocationException)
            ex = ex.InnerException;
        decimal? rec_id = 0;
        Session[barsroot.cim.Constants.StateKeys.LastError] = ErrorHelper.AnalyzeException(ex, ref rec_id);
        Session[barsroot.cim.Constants.StateKeys.LastErrorRecID] = rec_id;
    }
    public void WriteMessage(Control ctrl, string message, MessageType type)
    {
        System.Drawing.Color color = System.Drawing.Color.Green;
        switch (type)
        {
            case MessageType.Error: color = System.Drawing.Color.Red; break;
            case MessageType.Warning: color = System.Drawing.Color.Yellow; break;
            case MessageType.Info: color = System.Drawing.Color.Black; break;
            case MessageType.Success: color = System.Drawing.Color.Green; break;
        }

        if (ctrl is Label)
        {
            Label lbl = ctrl as Label;
            lbl.Text = message;
            lbl.ForeColor = color;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tbFinishDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            tbStartDate.Text = DateTime.Now.AddDays(-7).ToString("dd/MM/yyyy");
        }
    }
    /// <summary>
    /// Get string in RTF representation
    /// </summary>
    /// <param name="s"></param>
    /// <returns></returns>
    static string us(string s)
    {
        var sb = new StringBuilder();
        var bytes = Encoding.GetEncoding(1251).GetBytes(s);
        for (int i = 0; i < s.Length; i++)
        {
            char c = s[i];
            if (c <= 0x7f)
                sb.Append(c);
            else
                sb.Append("\\u" + Convert.ToUInt32(c) + "\\'" + bytes[i].ToString("x2"));
        }
        return sb.ToString();
    }
    protected void btExport_Click(object sender, EventArgs e)
    {
        WriteMessage(lbInfo, "Розпочато формування файлів, зачекайте ...", MessageType.Info);
        using (OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection)
        {
            using (OracleCommand command = new OracleCommand())
            {
                command.Connection = con;
                command.CommandText = "select 'card_'||tt||'('||ref||').rtf', doc_desc, ref from bars.v_corp2_docs v  where v.kv != 980 and v.pdat between :startDate and :finishDate + 1";
                command.Parameters.Add("startDate", OracleDbType.Date, DateTime.ParseExact(tbStartDate.Text, "dd/MM/yyyy", null), ParameterDirection.Input);
                command.Parameters.Add("finishDate", OracleDbType.Date, DateTime.ParseExact(tbFinishDate.Text, "dd/MM/yyyy", null), ParameterDirection.Input);
                if (!string.IsNullOrEmpty(tbRef.Text.Trim()))
                {
                    command.CommandText += " and ref=:ref";
                    command.Parameters.Add("ref", OracleDbType.Decimal, decimal.Parse(tbRef.Text.Trim()), ParameterDirection.Input);
                }
                if (!string.IsNullOrEmpty(tbKv.Text.Trim()))
                {
                    command.CommandText += " and kv=:kv";
                    command.Parameters.Add("kv", OracleDbType.Int32, int.Parse(tbKv.Text.Trim()), ParameterDirection.Input);
                }
                if (!string.IsNullOrEmpty(tbUserId.Text.Trim()))
                {
                    command.CommandText += " and userid=:userid";
                    command.Parameters.Add("userid", OracleDbType.Decimal, decimal.Parse(tbUserId.Text.Trim()), ParameterDirection.Input);
                }
                if (!string.IsNullOrEmpty(tbNls.Text.Trim()))
                {
                    command.CommandText += " and nlsa=:nlsa";
                    command.Parameters.Add("nlsa", OracleDbType.Varchar2, tbNls.Text.Trim(), ParameterDirection.Input);
                }

                var zip = new ZipFile();
                var enc = Encoding.GetEncoding(1251);
                using (var rdr = command.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        string fileName = rdr.GetOracleString(0).Value;
                        byte[] data = rdr.GetOracleBlob(1).Value;
                        var content = enc.GetString(data);
                        var docRef = rdr.GetOracleDecimal(2).Value;
                        try
                        {
                            string parReceiveDate = "          ";
                            string parReceiveTime = "";
                            string parReceivePerson = "";
                            string parMfo = "";
                            string parBranchName = "";
                            string parBranchCode = "";

                            command.Parameters.Clear();
                            command.CommandText = "select to_char(dat, 'DD.MM.YYYY'), to_char(dat, 'HH24:MI'), s.fio  from bars.oper_visa o, staff$base s where o.userid=s.id and o.ref=:ref and o.status=1 and o.groupid in (5, 25) order by o.groupid";
                            command.Parameters.Add("ref", OracleDbType.Decimal, docRef, ParameterDirection.Input);
                            OracleDataReader rdrDetail = null;
                            using (rdrDetail = command.ExecuteReader())
                            {
                                if (rdrDetail.Read())
                                {
                                    parReceiveDate = string.Format("{0}р.", rdrDetail.GetString(0));
                                    parReceiveTime = rdrDetail.GetString(1);
                                    parReceivePerson = rdrDetail.GetString(2);
                                }
                            }

                            command.CommandText = "select o.kf, b.branch, b.name from bars.oper o, bars.branch b where o.ref=:ref and '/' || o.kf || '/' = b.branch";
                            using (rdrDetail = command.ExecuteReader())
                            {
                                if (rdrDetail.Read())
                                {
                                    parMfo = rdrDetail.GetString(0);
                                    parBranchCode = rdrDetail.GetString(1);
                                    parBranchName = rdrDetail.GetString(2);
                                    if (parBranchName.StartsWith("10001/0001"))
                                        parBranchName = " " + parBranchName;
                                }
                            }

                            string parCiDate = "          ";
                            string parCiTime = "";
                            string parCiPerson = "";
                            string parCiMfo = "";
                            string parCiBranchCode = "";
                            string parCiBranchName = "";
                            command.CommandText = "select to_char(dat, 'DD.MM.YYYY'), to_char(dat, 'HH24:MI'), s.fio, substr(s.branch, 2, 6), b.branch, b.name  from bars.oper_visa o, staff$base s, branch b where o.userid=s.id and  s.branch=b.branch and o.ref=:ref and o.status in (1,2) and o.groupid in (7, 37) order by o.groupid";
                            using (rdrDetail = command.ExecuteReader())
                            {
                                if (rdrDetail.Read())
                                {
                                    parCiDate = string.Format("{0}р.", rdrDetail.GetString(0));
                                    parCiTime = rdrDetail.GetString(1);
                                    parCiPerson = rdrDetail.GetString(2);
                                    parCiMfo = ", код " + rdrDetail.GetString(3);
                                    parCiBranchCode = rdrDetail.GetString(4);
                                    parCiBranchName = rdrDetail.GetString(5);
                                }
                            }
                            string parEDate = "          ";
                            string parETime = "";
                            string parEPerson = "";
                            string parEMfo = "";
                            string parEBranchCode = "";
                            string parEBranchName = "";
                            command.CommandText = "select to_char(dat, 'DD.MM.YYYY'), to_char(dat, 'HH24:MI'), s.fio, nvl(substr(s.branch, 2, 6), o.kf), b.branch, b.name  from bars.oper_visa o, staff$base s, branch b where o.userid=s.id and  s.branch=b.branch and o.ref=:ref and o.status=2 order by dat";
                            using (rdrDetail = command.ExecuteReader())
                            {
                                if (rdrDetail.Read())
                                {
                                    parEDate = string.Format("{0}р.", rdrDetail.GetString(0));
                                    parETime = rdrDetail.GetString(1);
                                    parEPerson = rdrDetail.GetString(2);
                                    parEMfo = ", код " + rdrDetail.GetString(3);
                                    parEBranchCode = rdrDetail.GetString(4);
                                    parEBranchName = rdrDetail.GetString(5);
                                }
                            }
                            //
                            /*parCiBranchName = "223344";
                            parCiPerson = "Черкас Мирослава Михайлівна 112233";
                            parEPerson = "Черкас Мирослава Михайлівна 112233";
                            parEDate = "21.09.2016р.";
                            parCiDate = "21.09.2016р.";
                            parETime = "16:42";
                            parCiTime = "16:42";
                            parCiMfo = ", код 300465";
                            parEMfo = ", код 300465";
                            parEBranchName = "xxxxxxxxxxxxxxx";
                            parCiBranchName = "yyyyyyyyyyyyyyy";
                            parBranchName = "OУ  Філія-Дніпропетровське обласне управління АТ \"Ощадбанк\"";*/
                            //
                            string[] bottomLines = new[]
                                {
                                    us("ВІДМІТКИ БАНКУ"),
                                    "\\b " + us("Валютний контроль:"),
                                    us("Дата " + parCiDate + ".Час " + parCiTime),
                                    us(parCiPerson),
                                    us(parBranchName),
                                    "\\b " + us("АТ «Ощадбанк»") + " \\b0 " + us(parCiMfo),
                                    "\\b " + us("Відмітка про виконання:"),
                                    us("Дата " + parEDate + ".Час " + parETime),
                                    us(parEPerson),
                                    "\\b " + us("АТ «Ощадбанк»" + "\\b0 " + us(parEMfo)),
                                    us(parBranchName),
                                    ""
                                };
                            string lastStr = "\\par }";
                            var parts = content.Split(new string[] { "{\\pard" }, StringSplitOptions.None);
                            List<string> itemsList = parts.ToList<string>();
                            if (!content.Contains(@"\pvpg\phpg\posx6861\posy15327\"))
                            {
                                var insPos = itemsList.Count;
                                var line = @"\pvpg\phpg\posx6861\posyXXXXX\absw4200\absh-240\fi0 \ltrpar\ql\tx360\tx720\tx1080\tx1440\tx1800\tx2160\tx2520\tx2880\tx3240\tx3600\tx3960{\ltrch\f0 \b0\i0\ul0\strike0\fs17 \cf1 \uc1}\par }";
                                int startYPos = 15250;

                                if (content.Contains("posy14771"))
                                    line = line.Replace("absw4200", "absw3900");
                                itemsList.Insert(insPos - 4, line.Replace("posyXXXXX", "posy" + startYPos));
                                itemsList.Insert(insPos - 3, line.Replace("posyXXXXX", "posy" + (startYPos + 200)));
                                itemsList.Insert(insPos - 2, line.Replace("posyXXXXX", "posy" + (startYPos + 400)).Replace("absh-240", "absh-440"));
                                itemsList.Insert(insPos - 1, line.Replace("posyXXXXX", "posy" + (startYPos + 600)).Replace("absh-240", "absh-440"));
                            }
                            parts = itemsList.ToArray();
                            int bottomCounter = 0;
                            for (int i = 0; i < parts.Length; i++)
                            {
                                if (parts[i].Contains("0410001"))
                                {
                                    string delimLine = @"\par \fi0 \ltrpar\ql\tx360\tx720\tx1080\tx1440\tx1800\tx2160\tx2520\tx2880{\ltrch\f0 \b0\i0\ul0\strike0\fs15 \cf1 \uc1";
                                    if (parts[i].Contains(@"\b0\i0\ul0\strike0\fs17"))
                                        delimLine = @"\par \fi0 \ltrpar\ql\tx360\tx720\tx1080\tx1440\tx1800\tx2160\tx2520\tx2880{\ltrch\f0 \b0\i0\ul0\strike0\fs17 \cf1 \uc1";
                                    var blockParts = parts[i].Split(new string[] { delimLine }, StringSplitOptions.None);
                                    var list = new List<string>();
                                    list.Add(blockParts[0]);

                                    list.Add("\\b" + us("Прийнято СДО :") + "}");
                                    list.Add("\\b" + us("ЕЦП перевірено") + "}");
                                    list.Add("\\b" + us("Дата ") + "\\b0 " + us(parReceiveDate) + " \\b " + us("Час ") + "\\b0 " + us(parReceiveTime) + "}");
                                    list.Add(us(parReceivePerson) + "}");
                                    list.Add(us("АТ «Ощадбанк»,код " + parMfo) + "}");
                                    list.Add(us(parBranchName) + "}" + lastStr);

                                    parts[i] = string.Join(delimLine, list.ToArray()).Replace("fs15", "fs14");
                                }
                                else if (parts[i].Contains("posx6981") || parts[i].Contains("posx6861"))
                                {
                                    if (!parts[i].Contains("posx6861\\posy2291") && !parts[i].Contains("posx6861\\posy1887"))
                                    {
                                        var line = bottomLines[bottomCounter++];
                                        parts[i] = parts[i].Substring(0, parts[i].IndexOf("\\uc1") + 4).Replace("posx6861", "posx6981") + line + "}" + lastStr;
                                        if (bottomCounter == 5)
                                        {
                                            parts[i] = parts[i].Replace("absh-240", "absh-440");
                                        }
                                        parts[i] = parts[i].Replace("posy14847", "posy15050").Replace("posy14531", "posy14751").Replace("posy14771", "posy15011");
                                    }
                                }
                                parts[i] = parts[i].
                                    Replace("posy807", "posy390").
                                    Replace("posy567", "posy390").
                                    Replace("posy687", "posy400").
                                    Replace("posy971", "posy400").
                                    Replace("absh-1080", "absh-2080").Replace("absh-1230", "absh-2080").Replace("absh-1320", "absh-2080").
                                    Replace("shptop15567", "shptop16307").
                                    Replace("shpbottom15567", "shpbottom16307").
                                    Replace("shpbottom15568", "shpbottom16307").
                                    Replace("shptop15251", "shptop16307").
                                    Replace("shpbottom15251", "shpbottom16307").
                                    Replace("shpbottom15252", "shpbottom16307");
                            }

                            content = string.Join("{\\pard", parts);
                            //
                        }
                        catch (Exception ex)
                        {
                            fileName += "_orig";
                        }

                        data = enc.GetBytes(content);
                        zip.AddEntry(fileName, data);
                    }
                }
                
                if (zip.Entries.Count > 0)
                {
                    var stream = new MemoryStream();
                    zip.Save(stream);
                    stream.Seek(0, SeekOrigin.Begin);

                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.Charset = "windows-1251";
                    Response.AppendHeader("content-disposition",
                        string.Format("attachment;filename=export{0}_{1}.zip", tbStartDate.Text.Replace("/", ""),
                            tbFinishDate.Text.Replace("/", "")));
                    Response.ContentType = "application/octet-stream";
                    Response.BinaryWrite(stream.ToArray());
                    Response.Flush();
                    Response.End();
                }
                else
                {
                    WriteMessage(lbInfo, "Не знайденно документів за вказаними параметрами", MessageType.Error);
                }
            }
        }
    }
}