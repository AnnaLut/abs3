using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Xml;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Web;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Runtime.InteropServices;

namespace bars.sberimport
{
    public class xml_a : xml_base
    {
        public override String version() { return "1.2(C#)"; }
        public override String semantic() { return "A_FILE1||A_FILE2||A_FILE3||A_FILE4"; }
        public override String description() { return "Локальнi задачі філій || Комунальні платежі || Зарплатнi файли || Файли інкасації"; }
        public override String libsConfig() { return "file_a1.config||file_a2.config||file_a3.config||file_a4.config"; }
        public override String libsType() { return "1||2||3||4"; }

        protected override TConfig LoadConfigFile(String ConfigFile)
        {
            int i = 0;
            int n = 0;
            String LastError = String.Empty;
            TConfig conf = new TConfig();
            try
            {
                List<String> Lines = getStringList(ConfigFile);
                List<TSettingsItem> list = new List<TSettingsItem>(Lines.Count);
                foreach (String lst in Lines)
                {
                    String strVal = lst.IndexOf("//") >= 0 ? lst.Remove(lst.IndexOf("//")) : lst;
                    if (String.IsNullOrEmpty(StringEx.Trim(strVal)))
                    {
                        continue;
                    }
                    i += 1;
                    List<String> lPar_do = new List<string>(Regex.Split(StringEx.Trim(strVal), " ", RegexOptions.ExplicitCapture));
                    List<String> lPar = new List<string>();
                    foreach (String str in lPar_do)
                        if (!String.IsNullOrEmpty(StringEx.Trim(str)))
                        {
                            lPar.Add(StringEx.Trim(str));
                        }
                    {
                    }
                    if (lPar.Count == 5)
                    {
                        TToken t = new TToken();
                        t.Pos = Convert.ToInt32(StringEx.Trim(lPar[0]));
                        t.Len = Convert.ToInt32(StringEx.Trim(lPar[1]));
                        t.Mandatory = StringEx.Trim(lPar[2]) == "1";
                        t.Tp = StringEx.Trim(lPar[3]);
                        t.Name = StringEx.Trim(lPar[4].Replace("'", ""));
                        n = n + 1;
                        //строки с первой по девятую - заголовок
                        if (n >= 1 && n <= 9)
                        {
                            conf.HeaderFields.Insert(n - 1, t);
                            //conf.HeaderFields[n] = t;
                        }
                        //строки с 10 по 46 - тело
                        if (n >= 10 && n <= 46)
                        {
                            conf.DataFields.Insert(n - 10, t);
                            //conf.DataFields[n - 9] = t;
                        }
                    }
                    //SenderId
                    if (lPar.Count == 1 && i == 1)
                    {
                        conf.SenderId = StringEx.Trim(lPar[0]);
                    }
                    //OurMFO
                    if (lPar.Count == 1 && i == 2)
                    {
                        conf.OurMFO = StringEx.Trim(lPar[0]);
                    }
                    //StructType
                    if (lPar.Count == 1 && i == 3)
                    {
                        conf.StructType = StringEx.Trim(lPar[0]);
                    }

                }
                //параметры должны быть указаны
                if (conf.SenderId == "" || conf.OurMFO == "" || conf.StructType == "")
                {
                    throw new Exception("Не заполнены конфигурационные параметры (SenderId, MFO, StructType)");
                }
                return conf;
            }
            catch (Exception ex)
            {
                LastError = "CNV-4: Ошибка чтения конфигурационного файла \n" + ex.Message;
                throw new Exception(LastError);
            }
        }

        protected override String getField(TConfig Config, String Line, String Name)
        {
            int i = 0;
            String LastError = String.Empty;
            String sRes = String.Empty;
            try
            {
                for (i = 0; (i < Config.DataFields.Count && sRes == String.Empty); i++)
                {
                    if (Config.DataFields[i].Name == Name)
                    {
                        //значение
                        String v = (Line.Length >= ((Config.DataFields[i].Pos - 1) + Config.DataFields[i].Len) ?
                            brsTrim(Line.Substring(Config.DataFields[i].Pos - 1, Config.DataFields[i].Len)) : "");


                        CheckStrings(Name, v);
                        //если поле обязательное - применим проверки
                        if (Config.DataFields[i].Mandatory)
                        {
                            //обработка пустого значения
                            if (v.Length == 0)
                            {
                                throw new Exception("Не заполнено обязательное поле");
                            }
                        }
                        //если не пустое
                        if (v.Length > 0)
                        {
                            //обработка типов
                            if (Config.DataFields[i].Tp == "N")
                            {
                                sRes = Convert.ToString(Convert.ToInt64(v));
                            }
                            else if (Config.DataFields[i].Tp == "D")
                            {
                                sRes = DateTime.ParseExact(v, "yyMMdd", null).ToString("yyyy-MM-dd", null);
                            }
                            else if (Config.DataFields[i].Tp == "DT")
                            {
                                sRes = DateTime.ParseExact(v, "yyMMddhhmm", null).ToString("yyyy-MM-dd:hhmm", null);
                            }
                            else
                            {
                                sRes = v;//XmlEncodeChars(v);
                            }
                        }
                        //в противном случае вернем как есть
                        else
                        {
                            sRes = v;// XmlEncodeChars(v);
                        }

                    }
                }
                return sRes;
            }
            catch (Exception ex)
            {
                LastError = "CNV-2: Ошибка чтения строки\n" +
                            ex.Message + "\n" +
                            "Имя поля:" + Name + "\n" +
                            "Позиция: " + Config.DataFields[i].Pos;
                throw new Exception(LastError);
            }
        }
 
        public override int ConvertBufferEx(String configFile,
                                   String settingsFile,
                                   String inputFileName,
                                   String inputBuffer,
                                   out String outputBuffer,
                                   out String resMsg)
        {
            int n = 0;
            String dummy = String.Empty;
            String t = String.Empty;
            String tm = String.Empty;
            Boolean IsServiceLinesFound = false;
            String LastError = String.Empty;

            TConfig C = LoadConfigFile(configFile);
            List<TSettingsItem> Settings = LoadSettingsFile(C.StructType, settingsFile);
            XmlDocument doc = new XmlDocument();
            XmlDeclaration decl = doc.CreateXmlDeclaration("1.0", "windows-1251", "yes");
            doc.InsertBefore(decl, doc.DocumentElement);

            string DetailsDelimiter = "#C";
            int MaxBisCnt = 99;

            try
            {
                List<String> F = new List<string>(Regex.Split(inputBuffer, "\n"));

                if (F.Count >= 2)
                {
                    IsServiceLinesFound = (StringEx.Trim(F[0]) != "" || StringEx.Trim(F[1].Substring(1, 2)).Length != 2) ? false : true;
                }
                XmlElement msg = doc.CreateElement("PaymentMessage");
                XmlElement header = doc.CreateElement("Header");
                setNodeValue(header, "MessageID", inputFileName);
                setNodeValue(header, "MessageType", "PMNT");
                setNodeValue(header, "MessageTimestamp", null);
                setNodeValue(header, "SenderID", null);
                setNodeValue(header, "ReceiverID", null);
                //body
                XmlElement body = doc.CreateElement("Body");
                //счетчик строк без БИС
                n = 1;
                //начать пропустив служебную строку и строку заголовка
                int k = (IsServiceLinesFound ? 2 : 0);
                //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                while (k < F.Count)
                {
                    int BisCnt = 0;
                    Int64 SK = 0;
                    int tmpint = 0;

                    //рядок з даними
                    String Line = F[k];

                    if (StringEx.Trim(Line) == String.Empty)
                    {
                        k += 1;
                        continue;
                    }
                    String SLineNumber = getField(C, Line, "LineNumber");


                    //доп. реквизиты
                    List<TAttribute> Attrs = GetAttrs(C, getField(C, Line, "AddAtributes"));

                    //получить кол-во строчек для БИС
                    foreach (TAttribute Attr in Attrs)
                    {
                        if (Attr.Name == "B")
                        {
                            BisCnt = Convert.ToInt32(Attr.Value);
                            Attr.Name = "";
                            Attr.Value = "";
                        }
                    }

                    //Назначение платежа
                    String Details = StrDosToWin(getField(C, Line, "Details")).Trim();

                    //если не указана строчка с доп. реквизитом #B - пропустить
                    // нулевые документы с реквизитом #C
                    if (BisCnt == 0 &&
                        StringEx.Trim(Details).Substring(0, 2).ToUpper() == "#C" &&
                        getField(C, Line, "Amount1") == "0")
                    {
                        k += 1;
                        continue;
                    }
                    if (BisCnt > MaxBisCnt)
                    {
                        throw new Exception(string.Format("Перевищено ліміт кількості БІР в {0} рядків.", MaxBisCnt));
                    }

                    String tmp = String.Empty;
                    //Дочитать назначение платежа, и вставить доп. реквизитами CNN}
                    for (int j = 2; j <= BisCnt; j++)
                    {
                        //SetLength(Attrs, Length(Attrs) + 1);
                        TAttribute a = new TAttribute();
                        a.Name = "C" + (Convert.ToString(j - 1).Length > 1 ? Convert.ToString(j - 1) : "0" + Convert.ToString(j - 1));
                        //убрал StrDosToWin (перекодируется ниже)
                        tmp = (getField(C, F[k + j - 1], "Details"));
                        if (tmp.IndexOf(DetailsDelimiter) != 0)
                        {
                             throw new Exception(string.Format("Невірний формат БІР {0}. Відсутній початковий символ {1}.", k, DetailsDelimiter));
                            }
                        //обрезать решетки
                        a.Value = tmp.Substring(2, tmp.Length - 3).Trim();
                        Attrs.Add(a);
                    }

                    //пропустить обработанные строки
                    if (BisCnt != 0)
                    {
                        k = k + BisCnt - 1;
                    }


                    XmlElement pmnt = doc.CreateElement("PMNT");
                    setAttributeValue(pmnt, "SIGN", getField(C, Line, "SIGN"));
                    setAttributeValue(pmnt, "KEY", getField(C, Line, "KEY"));
                    XmlElement paymentBody = doc.CreateElement("Body_PMNT");
                    XmlElement payment = doc.CreateElement("Payment");
                    setAttributeValue(payment, "LineNumber", Convert.ToString(n));

                    //номер и дата документа
                    setNodeValue(payment, "DocNumber", getField(C, Line, "DocNumber"));
                    setNodeValue(payment, "DocDate", getField(C, Line, "DocDate"));
                    paymentBody.AppendChild(payment);
                    pmnt.AppendChild(paymentBody);
                    body.AppendChild(pmnt);

                    //МФО А и Б
                    String PayerMFO = getField(C, Line, "PayerMFO");
                    String PayeeMFO = getField(C, Line, "PayeeMFO");

                    //счета А и Б
                    String PayerACC = getField(C, Line, "PayerAccount");
                    String PayeeACC = getField(C, Line, "PayeeAccount");

                    //код валюты
                    String KV = getField(C, Line, "Currency1");
                    String DK = getField(C, Line, "DK");

                    string PayerOkpo = getField(C, Line, "PayerOKPO");
                    string PayerName = StrDosToWin( getField(C, Line, "PayerName") );
                    string PayeeName = StrDosToWin( getField(C, Line, "PayeeName") );

                    String VOB = String.Empty;
                    String TT = String.Empty;
                    String SK_ZB = String.Empty;
                    String PayeeOKPO = String.Empty;

                    //секция переворачивания счетов
                    if (isCash(PayerACC))
                    {
                        
                        dummy = PayerACC;
                        PayerACC = PayeeACC;
                        PayeeACC = dummy;

                        dummy = PayerMFO;
                        PayerMFO = PayeeMFO;
                        PayeeMFO = dummy;

                        dummy = PayerName;
                        PayerName = PayeeName;
                        PayeeName = dummy;

                        if (DK == "1")
                        {
                            DK = "0";
                        }
                        else if (DK == "0")
                        {
                            DK = "1";
                        }
                    }


                    //секция вычисления операции
                    if (C.StructType == "3")
                    {
                        TT = "PKS";
                    }
                    else if (C.StructType == "4")
                    {
                    }
                    else
                    {
                        //секция вычисления операции
                        if (PayerMFO == PayeeMFO)
                        {
                            //касса
                            if (PayeeACC.Substring(0, 4) == "1001" || PayeeACC.Substring(0, 4) == "1002")
                            {
                                //гривневые
                                if (KV == "980")
                                {
                                    //дебет/кредит
                                    if (DK == "0")
                                    {
                                        //приход кассы грн
                                        TT = "I02";
                                    }
                                    else
                                    {
                                        //расход кассы грн
                                        TT = "I03";
                                    }
                                }
                                //валютные
                                else
                                {
                                    //дебет/кредит
                                    if (DK == "0")
                                    {
                                        //приход кассы валюта
                                        TT = "I04";
                                    }
                                    else
                                    {
                                        //расход кассы валюта
                                        TT = "I05";
                                    }
                                }
                            }
                            //не касса
                            else
                            {
                                TT = "I00";
                            }
                        }
                        else
                        {
                            if (DK == "0")
                            {
                                TT = "I07";
                            }
                            else
                            {
                                if (DK == "2")
                                {
                                    TT = "I06";
                                }
                                else
                                {
                                    TT = "I01";
                                }
                            }
                        }
                    }

                    if (!String.IsNullOrEmpty(getField(C, Line, "Currency2")))
                    {
                      if (( PayeeACC.Substring(0,1) == "6" && DK == "1" ) ||
                          ( PayerACC.Substring(0,1) == "6" && DK == "0" ))  
                      {
                        TT = "D06";
                      }
                      else
                      if (( PayeeACC.Substring(0,1) == "7" && (DK == "0") ) ||
                          ( PayerACC.Substring(0,1) == "7" && (DK == "1") ))
                      {
                        TT = "D07";
                      }
                    }

                    //
                    //долбоебический метод использования поля Резерв
                    //здесь может быть либо OKPO получателя, либо символ кассы, либо
                    //внебаланосвый символ кассы
                    //
                    if (C.StructType == "1")
                    {
                        SK = 0;
                        SK_ZB = "";
                        PayeeOKPO = "";
                        tmp = getField(C, Line, "PayeeOKPO");
                        if (tmp != "")
                        {
                            SK = Convert.ToInt64(tmp);
                        }
                        //касовий позабалансовий символ - записать в доп. реквизит
                        if (SK > 73 && SK < 100)
                        {
                            SK_ZB = Convert.ToString(SK);
                            SK = 0;
                            PayeeOKPO = "";
                        }
                        //символ кассы
                        else if (SK > 0 && SK <= 73)
                        {
                            //SK = SK;
                            SK_ZB = "";
                            PayeeOKPO = "";
                        }
                        //OKPO
                        else if (SK > 0)
                        {
                            PayeeOKPO = tmp;
                            SK = 0;
                            SK_ZB = "";
                        }
                    }
                    //для структуры второго типа - это ОКПО получателя
                    else if (C.StructType == "2")
                    {
                        PayeeOKPO = getField(C, Line, "PayeeOKPO");
                        SK = 0;
                    }
                    else if (C.StructType == "3")
                    {
                        PayeeOKPO = getField(C, Line, "PayeeOKPO");
                        tmp = getField(C, Line, "SK_ZB");
                        if (tmp != "" && int.TryParse(tmp, out tmpint))
                        {
                            SK_ZB = tmp;
                        }
                        else
                        {
                            SK_ZB = "84";
                        }
                    }
                    else
                    {
                        throw new Exception("CNV-8: Неподдерживаемый тип структуры - " + C.StructType);
                    }

                    tmp = getField(C, Line, "VOB");

                    //для третьей структуры воб есть воб
                    if (C.StructType == "3")
                    {
                        VOB = tmp;
                    }
                    else
                        //для первой структуры 
                        if (C.StructType == "1")
                        {
                            //если один из счетов - касса: считаем VOB правильной функцией
                            if (isCash(PayerACC) || isCash(PayeeACC))
                            {
                                VOB = getCashVOB(PayerACC, PayeeACC, DK, TT);
                                if (SK == 0)
                                {
                                    if (tmp != "" && tmp != "6")
                                    {
                                        if (int.TryParse(tmp, out tmpint))
                                        {
                                            SK = tmpint;
                                        }
                                    }
                                }
                            }
                            // если оба счета не кассовые
                            else
                            {
                                //если в файле поле заполнено - выбираем его
                                if (tmp != "")
                                {
                                    VOB = tmp;
                                    //если поле пустое - подставляем значение по-умолчанию  
                                }
                                else
                                {
                                    VOB = "6";
                                }
                            }
                        }
                        else
                            //разборки с полем VOB и СК для второй структуры
                            if (C.StructType == "2")
                            {
                                VOB = "";
                                SK_ZB = "";
                                SK = 0;
                                //документ кассовый
                                if (isCash(PayerACC) || isCash(PayeeACC))
                                {
                                    //это символ кассы
                                    if (KV == "980")
                                    {
                                        //для гривны должно быть заполнено
                                        if (tmp == "")
                                        {
                                            throw new Exception("Для гривневого документа не указан " +
                                              "символ кассового плана");
                                        }
                                        else
                                        {
                                            SK = Convert.ToInt64(tmp);
                                        }
                                    }
                                    //для валютных платежей пофигу
                                    else
                                    {
                                        SK = 0;
                                    }
                                    //вычисляем ВОБ
                                    VOB = getCashVOB(PayerACC, PayeeACC, DK, TT);
                                }
                                else
                                {
                                    //внебалансовый
                                    if (
                                        PayeeMFO == PayerMFO && 
                                        (
                                          PayerACC.Substring(0, 1) == "9" || PayeeACC.Substring(0, 1) == "9" ||
                                          (PayerACC.Substring(0, 3) == "262" &&  PayeeACC.Substring(0, 4) != "6110" ) ||
                                          PayeeACC.Substring(0, 3) == "262"
                                        )
                                     )
                                    {
                                        if (tmp.Trim().Length > 1) SK_ZB = tmp;
                                    }
                                    else
                                    {
                                        //документ не кассовый и не внебалансовый
                                        //это ВОБ
                                        VOB = tmp;
                                        SK = 0;
                                    }
                                }
                            }

                    
                    
                    //закончим переворачивать реквизиты
                    if (isCash(PayeeACC)) 
                    {
                        dummy = PayerOkpo;
                        PayerOkpo = PayeeOKPO;
                        PayeeOKPO = dummy;
                    }

                    //payer
                    XmlElement payer = doc.CreateElement("Payer");
                    setNodeValue(payer, "Name", PayerName);
                    setNodeValue(payer, "MFO", (PayerMFO == "" ? C.OurMFO : PayerMFO));
                    setNodeValue(payer, "Account", PayerACC);
                    setNodeValue(payer, "OKPO", PayerOkpo);
                    payment.AppendChild(payer);
                    //payee
                    XmlElement payee = doc.CreateElement("Payee");
                    setNodeValue(payee, "Name", PayeeName);
                    setNodeValue(payee, "MFO", (PayeeMFO == "" ? C.OurMFO : PayeeMFO));
                    setNodeValue(payee, "Account", PayeeACC);
                    //PayeeOKPO = String.Empty;
                    setNodeValue(payee, "OKPO", PayeeOKPO);
                    payment.AppendChild(payee);

                    //amount1
                    XmlElement amount1 = doc.CreateElement("Amount1");
                    setNodeValue(amount1, "Amount", getField(C, Line, "Amount1"));
                    XmlElement Currency1 = doc.CreateElement("Currency");
                    setNodeValue(Currency1, "NBUCode", KV);
                    amount1.AppendChild(Currency1);
                    payment.AppendChild(amount1);

                    //amount2
                    XmlElement amount2 = doc.CreateElement("Amount2");
                    XmlElement Currency2 = doc.CreateElement("Currency");
                    if (String.IsNullOrEmpty(getField(C, Line, "Currency2")))
                    {
                        setNodeValue(amount2, "Amount", getField(C, Line,"Amount1"));
                        setNodeValue(Currency2, "NBUCode", KV);
                    }
                    else
                    {
                        setNodeValue(amount2, "Amount", String.Empty);
                        setNodeValue(Currency2, "NBUCode", getField(C, Line, "Currency2"));
                    }

                    amount2.AppendChild(Currency2);
                    payment.AppendChild(amount2);

                    //simple
                    setNodeValue(payment, "ValueDate", getField(C, Line, "DATP"));
                    setNodeValue(payment, "VOB", VOB);
                    setNodeValue(payment, "Details", Details);

                    setNodeValue(payment, "TT", TT);

                    setNodeValue(payment, "DK", DK);
                    setNodeValue(payment, "SK", (SK == 0 ? "" : Convert.ToString(SK)));
                    setNodeValue(payment, "REF_A", getField(C, Line, "REF_A"));
                    //----------------------------------------------------------------------------------------------------

                    //AddAttributes
                    XmlElement addAttr = doc.CreateElement("AddAttributes");
                    setNodeValue(addAttr, "IMPTP", C.StructType);

                    if (Settings != null)
                    {
                        for (int fi = 0; fi < Settings.Count; fi++)
                        {
                            if (Settings[fi].ParamName == "SK_ZB")
                            {
                                SK_ZB = Settings[fi].ParamValue;
                            }
                            else
                            {
                                XmlNodeList x = payment.GetElementsByTagName(Settings[fi].ParamName);
                                foreach (XmlElement el in x)
                                {
                                    el.InnerText = Settings[fi].ParamValue;
                                }
                            }
                        }
                    }
                    //обработать доп. реквизит SK_ZB (заполнен выше)
                    if (SK_ZB != "" && SK_ZB != "0")
                    {
                        //SetLength(Attrs, Length(Attrs) + 1);
                        TAttribute a = new TAttribute();
                        a.Name = "SK_ZB";
                        a.Value = SK_ZB;
                        Attrs.Add(a);
                    }

                    //обработать остальные доп. реквизиты
                    //тип 1 не обрабатывается вообще
                    foreach (TAttribute attr_t in Attrs)
                    {
                        if (attr_t.Name != "")
                        {
                            XmlElement attr = doc.CreateElement("Attribute");
                            setNodeValue(attr, "AttributeName", StrDosToWin(attr_t.Name));
                            setNodeValue(attr, "AttributeValue", StrDosToWin(attr_t.Value));
                            setNodeValue(attr, "AttributeType", "String");
                            addAttr.AppendChild(attr);
                        }
                    }

                    payment.AppendChild(addAttr);
                    //----------------------------------------------------------------------------------------------------
                    //счетчик документов
                    n += 1;
                    //счетчик цикла
                    k += 1;
                }
                //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                msg.AppendChild(header);
                msg.AppendChild(body);
                doc.AppendChild(msg);

                //MemoryStream sw = new MemoryStream();
                //doc.Save(sw);
                //StreamReader sr = new StreamReader(sw, Encoding.GetEncoding("windows-1251"));
                //outputBuffer = sr.ReadToEnd();
                outputBuffer = doc.InnerXml;
                resMsg = "";
                return 0;
            }
            catch (Exception ex)
            {
                resMsg = "CNV-6: Ошибка преобразования\n" + ex.Message + "\n" +
                         "At line:" + Convert.ToInt64(n) + "\n" +
                         "Input file: " + inputFileName + "\n" +
                         "Config file: " + configFile;
                outputBuffer = "";
                return -1;
            }
        }
    }
}
