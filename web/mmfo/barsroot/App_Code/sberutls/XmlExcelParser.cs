﻿using System;
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
using OfficeOpenXml;

namespace bars.sberimport
{
    public class XmlExcelParser : xml_base
    {
        public override String version() { return "1.2(C#)"; }
        public override String semantic() { return "A_FILE1||A_FILE2||A_FILE3||A_FILE4"; }
        public override String description() { return "Імпорт файлів на договірне списання"; }
        public override String libsConfig() { return "file_e3.config"; }
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
                    if (lPar.Count == 4)
                    {
                        TToken t = new TToken();
                        t.Pos = Convert.ToInt32(StringEx.Trim(lPar[0]));
                        t.Mandatory = StringEx.Trim(lPar[1]) == "1";
                        t.Tp = StringEx.Trim(lPar[2]);
                        t.Name = StringEx.Trim(lPar[3].Replace("'", ""));
                        n = n + 1;
                        //строки с первой по девятую - заголовок
                        //if (n >= 1 && n <= 9)
                        //{
                        //    conf.HeaderFields.Insert(n - 1, t);
                        //    //conf.HeaderFields[n] = t;
                        //}
                        //строки с 10 по 46 - тело
                        if (n >= 1 && n <= 46)
                        {
                            conf.DataFields.Insert(n - 1, t);
                            //conf.DataFields[n - 9] = t;
                        }
                    }
                    ////SenderId
                    //if (lPar.Count == 1 && i == 2)
                    //{
                    //    conf.SenderId = StringEx.Trim(lPar[0]);
                    //}
                    ////OurMFO
                    //if (lPar.Count == 1 && i == 3)
                    //{
                    //    conf.OurMFO = StringEx.Trim(lPar[0]);
                    //}
                    //StructType
                    if (lPar.Count == 1 && i == 2)
                    {
                        conf.StructType = StringEx.Trim(lPar[0]);
                    }

                }
                //параметры должны быть указаны
                //if (conf.SenderId == "" || conf.OurMFO == "" || conf.StructType == "")
                //{
                //    throw new Exception("Не заполнены конфигурационные параметры (SenderId, MFO, StructType)");
                //}
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


        private  String GetField(TConfig config, List<string> line, String name)
        {
            int i = 0;
            String LastError = String.Empty;
            String sRes = String.Empty;
            try
            {
                for (i = 0; (i < config.DataFields.Count && sRes == String.Empty); i++)
                {
                    if (config.DataFields[i].Name == name)
                    {
                        //значение
                        String v = line.Count >= config.DataFields[i].Pos ? line[config.DataFields[i].Pos - 1] : "";


                        CheckStrings(name, v);
                        //если поле обязательное - применим проверки
                        if (config.DataFields[i].Mandatory)
                        {
                            //обработка пустого значения
                            if (string.IsNullOrEmpty(v))
                            {
                                throw new Exception("Не заполнено обязательное поле");
                            }
                        }
                        //если не пустое
                        if (!string.IsNullOrEmpty(v))
                        {
                            //обработка типов
                            if (config.DataFields[i].Tp == "N")
                            {
                                sRes = Convert.ToString(Convert.ToInt64(v));
                            }
                            else if (config.DataFields[i].Tp == "D")
                            {
                                sRes = DateTime.ParseExact(v, "yyMMdd", null).ToString("yyyy-MM-dd", null);
                            }
                            else if (config.DataFields[i].Tp == "DT")
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
                            "Имя поля:" + name + "\n" +
                            "Позиция: " + config.DataFields[i].Pos;
                throw new Exception(LastError);
            }
        }

        public override int ConvertBufferEx(String configFile,
                                   String settingsFile,
                                   String inputFileName,
                                   byte[] dataBuffer,
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
                List<List<String>> rows = ParseExcelFile(dataBuffer);

               
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
                int k =  0;

                //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                while (k < rows.Count)
                {
                    int BisCnt = 0;
                    Int64 SK = 0;
                    int tmpint = 0;

                    //рядок з даними
                    List<string> line = rows[k];

                    if (line.FindAll( x => x != "").Count == 0)
                    {
                        k += 1;
                        continue;
                    }
                    String SLineNumber = GetField(C, line, "LineNumber");


                    //доп. реквизиты
                    List<TAttribute> Attrs = GetAttrs(C, GetField(C, line, "AddAtributes"));

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
                    String Details = GetField(C, line, "Details");    // StrDosToWin(GetField(C, line, "Details")).Trim();

                    //если не указана строчка с доп. реквизитом #B - пропустить
                    // нулевые документы с реквизитом #C
                    if (BisCnt == 0 &&
                        StringEx.Trim(Details).Substring(0, 2).ToUpper() == "#C" &&
                        GetField(C, line, "Amount1") == "0")
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
                        tmp = (GetField(C, rows[k + j - 1], "Details"));
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
                    setAttributeValue(pmnt, "SIGN", GetField(C, line, "SIGN"));
                    setAttributeValue(pmnt, "KEY", GetField(C, line, "KEY"));
                    XmlElement paymentBody = doc.CreateElement("Body_PMNT");
                    XmlElement payment = doc.CreateElement("Payment");
                    setAttributeValue(payment, "LineNumber", Convert.ToString(n));

                    //номер и дата документа
                    setNodeValue(payment, "DocNumber", GetField(C, line, "DocNumber"));
                    setNodeValue(payment, "DocDate", GetField(C, line, "DocDate"));
                    paymentBody.AppendChild(payment);
                    pmnt.AppendChild(paymentBody);
                    body.AppendChild(pmnt);

                    //МФО А и Б
                    String PayerMFO = GetField(C, line, "PayerMFO");
                    String PayeeMFO = GetField(C, line, "PayeeMFO");

                    //счета А и Б
                    String PayerACC = GetField(C, line, "PayerAccount");
                    String PayeeACC = GetField(C, line, "PayeeAccount");

                    //код валюты
                    String KV = GetField(C, line, "Currency1");
                    String DK = GetField(C, line, "DK");

                    string PayerOkpo = GetField(C, line, "PayerOKPO");
                    string PayerName = GetField(C, line, "PayerName");
                    string PayeeName = GetField(C, line, "PayeeName");

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

                    if (!String.IsNullOrEmpty(GetField(C, line, "Currency2")))
                    {
                        if ((PayeeACC.Substring(0, 1) == "6" && DK == "1") ||
                            (PayerACC.Substring(0, 1) == "6" && DK == "0"))
                        {
                            TT = "D06";
                        }
                        else
                        if ((PayeeACC.Substring(0, 1) == "7" && (DK == "0")) ||
                            (PayerACC.Substring(0, 1) == "7" && (DK == "1")))
                        {
                            TT = "D07";
                        }
                    }

                    ////
                    ////долбоебический метод использования поля Резерв
                    ////здесь может быть либо OKPO получателя, либо символ кассы, либо
                    ////внебаланосвый символ кассы
                    ////
                    if (C.StructType == "1")
                    {
                        SK = 0;
                        SK_ZB = "";
                        PayeeOKPO = "";
                        tmp = GetField(C, line, "PayeeOKPO");
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
                        PayeeOKPO = GetField(C, line, "PayeeOKPO");
                        SK = 0;
                    }
                    else if (C.StructType == "3")
                    {
                        PayeeOKPO = GetField(C, line, "PayeeOKPO");
                        tmp = GetField(C, line, "SK_ZB");
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

                    //tmp = GetField(C, line, "VOB");

                    ////для третьей структуры воб есть воб
                    //if (C.StructType == "3")
                    //{
                    //    VOB = tmp;
                    //}
                    //else
                    //    //для первой структуры 
                    //    if (C.StructType == "1")
                    //{
                    //    //если один из счетов - касса: считаем VOB правильной функцией
                    //    if (isCash(PayerACC) || isCash(PayeeACC))
                    //    {
                    //        VOB = getCashVOB(PayerACC, PayeeACC, DK, TT);
                    //        if (SK == 0)
                    //        {
                    //            if (tmp != "" && tmp != "6")
                    //            {
                    //                if (int.TryParse(tmp, out tmpint))
                    //                {
                    //                    SK = tmpint;
                    //                }
                    //            }
                    //        }
                    //    }
                    //    // если оба счета не кассовые
                    //    else
                    //    {
                    //        //если в файле поле заполнено - выбираем его
                    //        if (tmp != "")
                    //        {
                    //            VOB = tmp;
                    //            //если поле пустое - подставляем значение по-умолчанию  
                    //        }
                    //        else
                    //        {
                    //            VOB = "6";
                    //        }
                    //    }
                    //}
                    //else
                    //        //разборки с полем VOB и СК для второй структуры
                    //        if (C.StructType == "2")
                    //{
                    //    VOB = "";
                    //    SK_ZB = "";
                    //    SK = 0;
                    //    //документ кассовый
                    //    if (isCash(PayerACC) || isCash(PayeeACC))
                    //    {
                    //        //это символ кассы
                    //        if (KV == "980")
                    //        {
                    //            //для гривны должно быть заполнено
                    //            if (tmp == "")
                    //            {
                    //                throw new Exception("Для гривневого документа не указан " +
                    //                  "символ кассового плана");
                    //            }
                    //            else
                    //            {
                    //                SK = Convert.ToInt64(tmp);
                    //            }
                    //        }
                    //        //для валютных платежей пофигу
                    //        else
                    //        {
                    //            SK = 0;
                    //        }
                    //        //вычисляем ВОБ
                    //        VOB = getCashVOB(PayerACC, PayeeACC, DK, TT);
                    //    }
                    //    else
                    //    {

                    //        Bars.WebServices.NewNbs ws = new Bars.WebServices.NewNbs();
                    //        string _nbs = ws.UseNewNbs() ? "6510" : "6110";

                    //        //внебалансовый
                    //        if (
                    //                    PayeeMFO == PayerMFO &&
                    //                    (
                    //                      PayerACC.Substring(0, 1) == "9" || PayeeACC.Substring(0, 1) == "9" ||
                    //                      (PayerACC.Substring(0, 3) == "262" && PayeeACC.Substring(0, 4) != _nbs) ||
                    //                      PayeeACC.Substring(0, 3) == "262"
                    //                    )
                    //                 )
                    //        {
                    //            if (tmp.Trim().Length > 1) SK_ZB = tmp;
                    //        }
                    //        else
                    //        {
                    //            //документ не кассовый и не внебалансовый
                    //            //это ВОБ
                    //            VOB = tmp;
                    //            SK = 0;
                    //        }
                    //    }
                    //}



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
                    setNodeValue(amount1, "Amount", GetField(C, line, "Amount1"));
                    XmlElement Currency1 = doc.CreateElement("Currency");
                    setNodeValue(Currency1, "NBUCode", KV);
                    amount1.AppendChild(Currency1);
                    payment.AppendChild(amount1);

                    //amount2
                    XmlElement amount2 = doc.CreateElement("Amount2");
                    XmlElement Currency2 = doc.CreateElement("Currency");
                    if (String.IsNullOrEmpty(GetField(C, line, "Currency2")))
                    {
                        setNodeValue(amount2, "Amount", GetField(C, line, "Amount1"));
                        setNodeValue(Currency2, "NBUCode", KV);
                    }
                    else
                    {
                        setNodeValue(amount2, "Amount", String.Empty);
                        setNodeValue(Currency2, "NBUCode", GetField(C, line, "Currency2"));
                    }

                    amount2.AppendChild(Currency2);
                    payment.AppendChild(amount2);

                    //simple
                    setNodeValue(payment, "ValueDate", GetField(C, line, "DATP"));
                    setNodeValue(payment, "VOB", VOB);
                    setNodeValue(payment, "Details", Details);

                    setNodeValue(payment, "TT", TT);

                    setNodeValue(payment, "DK", DK);
                    setNodeValue(payment, "SK", (SK == 0 ? "" : Convert.ToString(SK)));
                    setNodeValue(payment, "REF_A", GetField(C, line, "REF_A"));
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

                        //settingFile for multi TT configuration file
                        string tt_tmp_name = String.Format("TT_{0}", TT);
                        for (int fi = 0; fi < Settings.Count; fi++)
                        {
                            if (String.Compare(tt_tmp_name, Settings[fi].ParamName) == 0)
                            {
                                XmlNodeList x = payment.GetElementsByTagName("TT");
                                foreach (XmlElement el in x)
                                {
                                    el.InnerText = Settings[fi].ParamValue;
                                }
                                break;
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
                            setNodeValue(attr, "AttributeName", attr_t.Name);
                            setNodeValue(attr, "AttributeValue",attr_t.Value);
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

        public List<List<string>> ParseExcelFile(byte [] parsedFileBuffer)
        {
            List<List<string>> rows = new List<List<string>>();
            List<string> excelColSemanticList = new List<string>();
            int dataStartsFromRow = 1;
            int dataStartFromCol = 1;
            int curCol;
            Stream stream = new MemoryStream(parsedFileBuffer);

            using (ExcelPackage package = new ExcelPackage(stream))
            {
                ExcelWorksheet worksheet;
                worksheet = package.Workbook.Worksheets[1];
                bool emptyData = true;
                var startFrom = worksheet.Dimension.Start;
                var finishTo = worksheet.Dimension.End;
                List<string> colExcelSemantics = new List<string>();



                dataStartsFromRow++;
                for (int irow = dataStartsFromRow; irow <= finishTo.Row; irow++)
                {
                    List<string> rowFields = new List<string>();
                    curCol = dataStartFromCol;
                    for (int col = dataStartFromCol; col <= finishTo.Column; col++)
                    {
                        object value = worksheet.Cells[irow, col].Value ?? "";

                        rowFields.Add(value.ToString());
                    }
                    rows.Add(rowFields);
                }
            }
            return rows;




        }

    }
}
