using System;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Web;

namespace bars.sberimport
{
    public static class StringEx
    {
        public static string Trim(string str)
        {
            return str.Trim(' ', (char)0, (char)1, (char)2, (char)3, (char)4, (char)5, (char)6,
                  (char)7, (char)8, (char)9, (char)10, (char)11, (char)12, (char)13,
                  (char)14, (char)15, (char)16, (char)17, (char)18, (char)19, (char)20,
                  (char)21, (char)22, (char)23, (char)24, (char)25, (char)26, (char)27, (char)28,
                  (char)29, (char)30, (char)31);
        }
    }


    public class TAttribute
    {
        public String Name;
        public String Value;
    }


    public class TToken
    {
        public int Pos;
        public int Len;
        public String Name = String.Empty;
        public Boolean Mandatory;
        public String Tp = String.Empty;
    }

    public class TConfig
    {
        public List<TToken> HeaderFields = new List<TToken>(8);
        public List<TToken> DataFields = new List<TToken>(36);
        public String SenderId = String.Empty;
        public String OurMFO = String.Empty;
        public String StructType = String.Empty;
    }

    public class TSettingsItem
    {
        public String StructType = "";
        public String ParamName = String.Empty;
        public String ParamValue = String.Empty;
    }

    public abstract class xml_base
    {
        public const int X_ERROR = -1;
        public const int X_OK = 0;

        public abstract String version();// { return String.Empty; }
        public abstract String semantic();// { return String.Empty; }
        public abstract String description();// { return String.Empty; }
        public abstract String libsConfig();// { return String.Empty; }
        public abstract String libsType();// { return String.Empty; }

        public xml_base()
        {
        }

        public static string split(string input, char schar, int s)
        {
            string result;
            int[] c;
            int b;
            int t;
            int o;
            s -= 1;
            t = 0;
            c = new int[input.Length];
            for (b = 0; b < c.GetUpperBound(0); b++)
            {
                c[b + 1] = input.IndexOf(schar, c[b] + 1);
                if ((c[b + 1] < c[b]) || (s < t))
                {
                    break;
                }
                else
                {
                    t++;
                }
            }
            o = c[s + 1] - c[s] - 1;
            if (o < 0)
            {
                o = input.Length;
            }
            result = input.Substring(c[s] + 1 - 1, o);
            return result;
        }

        public List<TSettingsItem> LoadSettingsFile(String StructType, String SettingsFile)
        {
            TSettingsItem sl;
            string fname = String.Format("{0}\\{1}.ini", HttpContext.Current.Server.MapPath("~/ExternalBin"), SettingsFile);
            if (!File.Exists(fname))
            {
                return null;
            }
            else
            {
                List<String> Lines = getStringList(fname);
                List<TSettingsItem> list = new List<TSettingsItem>(Lines.Count);
                foreach (String lst in Lines)
                {
                    sl = new TSettingsItem();
                    sl.StructType = StructType;
                    List<String> lPar = new List<string>(Regex.Split(lst, "="));
                    sl.ParamName = lPar[0];
                    sl.ParamValue = lPar[1];
                    list.Add(sl);
                }
                return list;
            }

        }

        public void setNodeValue(XmlElement parentnode, String nodeName, String value)
        {
            XmlElement node = (parentnode.OwnerDocument as XmlDocument).CreateElement(nodeName);
            if (value != null && StringEx.Trim(value) != "") node.InnerText = value;
            parentnode.AppendChild(node);
        }

        public void setAttributeValue(XmlElement parentnode, String nodeName, String value)
        {
            XmlAttribute node = (parentnode.OwnerDocument as XmlDocument).CreateAttribute(nodeName);
            if (value != null) node.InnerText = value;
            parentnode.Attributes.Append(node);
        }

        public void CheckStrings(String Name, String S)
        {

            Int64 amount = 0;
            //длина счета
            if (Name == "PayeeAccount" || Name == "PayerAccount")
            {
                if (StringEx.Trim(S).Length < 5)
                {
                    throw new Exception("Номер лицевого счета должен быть больше 5 символов");
                }
            }
            //длина наименования клиента
            if (Name == "PayeeName" || Name == "PayerName")
            {
                if (StringEx.Trim(S).Length > 0 && StringEx.Trim(S).Length < 3)
                {
                    throw new Exception("Наименование получателя и плательщика должно быть больше 3-х символов");
                }
            }
            //диапазон значений поля DK
            if (Name == "DK" && S.Length > 0)
            {
                if (!(S[0] == '0' || S[0] == '1' || S[0] == '2' || S[0] == '3'))
                {
                    throw new Exception("Признак дебет/кредит должен быть в диапазоне 0..3");
                }
            }
            if (Name == "Amount1")
            {
                if (Int64.TryParse(S, out amount))
                {
                    if (amount > 99999999999999)
                    {
                        throw new Exception("Сумма документа выходит за диапазон 99 999 999 999 999");
                    }
                }
            }
        }

        protected Boolean isCash(String ACC)
        {
            return (ACC.Substring(0, 4) == "1001" ||
                    ACC.Substring(0, 4) == "1002" ||
                    ACC.Substring(0, 4) == "1003" ||
                    ACC.Substring(0, 4) == "1004");
        }

        protected String getCashVOB(String PayerACC, String PayeeACC, String DK, String transactionType = "")
        {
            String Result = String.Empty;
            //вычисляем ВОБ
            //для транзакции с кодом "I02" должен использоваться шаблон 56 а не 21 - BRSMAIN-2577
            if (transactionType != "I02")
            {
                if (((isCash(PayerACC) && DK == "1") || (isCash(PayeeACC) && DK == "0")))
                {
                    Result = "21";
                }
                else
                {
                    if ((isCash(PayeeACC) && DK == "1") || (isCash(PayerACC) && DK == "0"))
                    {
                        Result = "22";
                    }
                }
            }
            return Result;
        }

        protected List<TAttribute> GetAttrs(TConfig Config, String SepAttrs)
        {
            String LastError = String.Empty;
            List<TAttribute> Result = new List<TAttribute>();
            try
            {
                List<String> lines = new List<string>(Regex.Split(SepAttrs, "#"));
                //разбить на составляющие
                if (lines.Count > 0)
                {
                    //заполнить массив
                    foreach (String line in lines)
                    {
                        if (StringEx.Trim(line) != "")
                        {
                            TAttribute a = new TAttribute();
                            a.Name = line.Substring(0, 1);
                            a.Value = line.Substring(1, line.Length - 1);

                            //особая обработка для доп реквизитов, начинающихся на ! 
                            if (a.Name.Trim() == "!" &&
                               a.Value.Trim() != String.Empty &&
                               a.Value.Contains(";"))
                            {
                                a.Name = a.Value.Substring(0, a.Value.IndexOf(';'));
                                a.Value = a.Value.Substring(a.Value.IndexOf(';') + 1);
                            }
                            //особая обработка для доп реквизитов, начинающихся на ~ 
                            if (a.Name.Trim() == "~" &&
                               a.Value.Trim() != String.Empty &&
                               a.Value.Contains(";"))
                            {
                                a.Name = a.Value.Substring(0, a.Value.IndexOf(';'));
                                a.Value = a.Value.Substring(a.Value.IndexOf(';') + 1);
                            }
                            Result.Add(a);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LastError = "CNV-5: Ошибка чтения дополнительных реквизитов\n" +
                            ex.Message + "\n" +
                  "Line: " + SepAttrs;
                throw new Exception(LastError);
            }
            return Result;
        }

        protected static string StrDosToWin(string source)
        {
            const string WinCharSet = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЪЫЭЮЯІЇЄабвгдеёжзийклмнопрстуфхцчшщьъыэюяіїє№Ґґ";
            const string NbuDosSet = "ЂЃ‚ѓ„…р†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—™њљ›ќћџцшф ЎўЈ¤Ґс¦§Ё©Є«¬­®Їабвгдежзиймклнопчщхьту";
            string res = String.Empty;
            for (int i = 0; i < source.Length; i++)
            {
                int offset = NbuDosSet.IndexOf(source[i]);
                res += offset >= 0 ? WinCharSet[offset] : source[i];
            }
            return res;
            /*return StrDosToWinX(source);*/
        }

        protected String brsTrim(String val)
        {
            String res = String.Empty;
            int p = val.Length;
            Boolean isRes = false;
            for (int i = val.Length - 1; (i >= 0 && !isRes); i--)
            {
                if (val[i] != ' ')
                {
                    isRes = !isRes;

                }
                else
                {
                    p = i;
                }
            }
            return val.Substring(0, p);
        }

        protected List<String> getStringList(String filepath)
        {
            FileStream f = new FileStream(filepath, FileMode.Open, FileAccess.Read);
            byte[] buff = new byte[f.Length];
            f.Read(buff, 0, buff.Length);
            String buffer = Encoding.GetEncoding(1251).GetString(buff);
            List<String> Lines = new List<string>(Regex.Split(buffer, "\r\n"));
            return Lines;
        }

        protected abstract TConfig LoadConfigFile(String ConfigFile);

        protected abstract String getField(TConfig Config, String Line, String Name);

        public abstract int ConvertBufferEx(String configFile,
                                String settingsFile,
                                String inputFileName,
                                String inputBuffer,
                                out String outputBuffer,
                                out String resMsg);
    }

}