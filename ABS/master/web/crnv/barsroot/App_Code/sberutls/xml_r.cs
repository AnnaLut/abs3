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
    public class xml_r : xml_base
    {
        public override String version() { return "1.2(C#)"; }
        public override String semantic() { return "R_FILE1"; }
        public override String description() { return "Виписка клієнт-банк 'ХИТС'"; }
        public override String libsConfig() { return "file_r1.config"; }
        public override String libsType() { return "6"; }

        protected override TConfig LoadConfigFile(String ConfigFile)
        {
            int i = 0;
            String LastError = String.Empty;
            TConfig conf = new TConfig();
            try
            {
                List<String> Lines = getStringList(ConfigFile);
                List<TSettingsItem> list = new List<TSettingsItem>(Lines.Count);
                foreach (String lst in Lines)
                {
                    String strVal = lst.IndexOf("//") >= 0 ? lst.Remove(lst.IndexOf("//")) : lst;
                    i += 1;
                    if (String.IsNullOrEmpty(StringEx.Trim(strVal))) continue;

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
                        conf.DataFields.Add(t);
                    }
                    //StructType
                    if (lPar.Count == 1 && String.IsNullOrEmpty(conf.StructType))
                    {
                        conf.StructType = StringEx.Trim(lPar[0]);
                    }

                }
                //параметры должны быть указаны
                if (conf.StructType == "")
                {
                    throw new Exception("Не заполнены конфигурационные параметры (StructType)");
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
                        String v = Line.Split(new char[] { 'ъ' })[Config.DataFields[i].Pos - 1];//. split(Line, (char)250, Config.DataFields[i].Pos);

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
                                sRes = DateTime.ParseExact(v, "yyyyMMdd", null).ToString("yyyy-MM-dd", null);
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
            String t = String.Empty;
            String tm = String.Empty;
            String LastError = String.Empty;

            TConfig C = LoadConfigFile(configFile);
            List<TSettingsItem> Settings = LoadSettingsFile(C.StructType, settingsFile);
            XmlDocument doc = new XmlDocument();
            XmlDeclaration decl = doc.CreateXmlDeclaration("1.0", "windows-1251", "yes");
            doc.InsertBefore(decl, doc.DocumentElement);

            int n = 0;

            try
            {
                List<String> F = new List<string>(Regex.Split(inputBuffer, "\r\n"));

                XmlElement msg = doc.CreateElement("PaymentMessage");
                XmlElement header = doc.CreateElement("Header");
                setNodeValue(header, "MessageID", inputFileName);
                setNodeValue(header, "MessageType", "PMNT");
                setNodeValue(header, "MessageTimestamp", null);
                setNodeValue(header, "SenderID", null);
                setNodeValue(header, "ReceiverID", null);
                //body
                XmlElement body = doc.CreateElement("Body");

                int k = 0;
                

                while (k < F.Count)
                {

                    //рядок з даними
                    String Line = F[k];

                    if (StringEx.Trim(Line) == String.Empty)
                    {
                        k += 1;
                        continue;
                    }

                    n += 1;

                    //Назначение платежа
                    String Details = StrDosToWin(getField(C, Line, "Details"));

                    String tmp = String.Empty;

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
                    if (String.IsNullOrEmpty(KV)) KV = "980";

                    String DK = String.Empty;

                    //секция переворачивания счетов
                    if (isCash(PayerACC))
                    {
                        String dummy = PayerACC;
                        PayerACC = PayeeACC;
                        PayeeACC = dummy;
                        if (DK == "1")
                        {
                            DK = "0";
                        }
                        else if (DK == "0")
                        {
                            DK = "1";
                        }
                    }
                    String VOB = String.Empty;
                    String TT = String.Empty;
                    String SK_ZB = String.Empty;

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

                    String SK = getField(C, Line, "SK");
                    String PayeeOKPO = getField(C, Line, "PayeeOKPO");
                    int DocType = Convert.ToInt32((getField(C, Line, "DocType")));

                    //таблица получения DK и VOB по типу документа
                    if (DocType == 1) { DK = "1"; VOB = "01"; }
                    else if (DocType == 2) { DK = "1"; VOB = "01"; }
                    else if (DocType == 9) { DK = "1"; VOB = "02"; }
                    else if (DocType == 10) { DK = "1"; VOB = "08"; }
                    else if (DocType == 11) { DK = "0"; VOB = "07"; }
                    else if (DocType == 55) { DK = "0"; VOB = "06"; }
                    else if (DocType == 56) { DK = "1"; VOB = "06"; }
                    else if (DocType == 60) { DK = "1"; VOB = "06"; }
                    else if (DocType == 70) { DK = "0"; VOB = "07"; }
                    else if (DocType == 75) { DK = "0"; VOB = "06"; }
                    else if (DocType == 76) { DK = "1"; VOB = "06"; }
                    else if (DocType == 2111) { DK = "1"; VOB = "12"; }
                    else if (DocType == 2121) { DK = "0"; VOB = "00"; }
                    else if (DocType == 2211) { DK = "1"; VOB = "12"; }
                    else if (DocType == 2221) { DK = "0"; VOB = "00"; }
                    else throw new Exception("Неизвестный тип документа: " + DocType.ToString());

                    //payer
                    XmlElement payer = doc.CreateElement("Payer");
                    setNodeValue(payer, "Name", StrDosToWin(getField(C, Line, "PayerName")));
                    setNodeValue(payer, "MFO", (PayerMFO == "" ? C.OurMFO : PayerMFO));
                    setNodeValue(payer, "Account", PayerACC);
                    setNodeValue(payer, "OKPO", getField(C, Line, "PayerOKPO"));
                    payment.AppendChild(payer);
                    //payee
                    XmlElement payee = doc.CreateElement("Payee");
                    setNodeValue(payee, "Name", StrDosToWin(getField(C, Line, "PayeeName")));
                    setNodeValue(payee, "MFO", (PayeeMFO == "" ? C.OurMFO : PayeeMFO));
                    setNodeValue(payee, "Account", PayeeACC);
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
                    setNodeValue(amount2, "Amount", getField(C, Line, "Amount1"));
                    XmlElement Currency2 = doc.CreateElement("Currency");
                    setNodeValue(Currency2, "NBUCode", KV);
                    amount2.AppendChild(Currency2);
                    payment.AppendChild(amount2);

                    //simple
                    setNodeValue(payment, "ValueDate", getField(C, Line, "DATP"));
                    setNodeValue(payment, "VOB", VOB);
                    setNodeValue(payment, "Details", Details);

                    setNodeValue(payment, "TT", TT);

                    setNodeValue(payment, "DK", DK);
                    setNodeValue(payment, "SK", SK);
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

                    List<TAttribute> Attrs = new List<TAttribute>();

                    //обработать доп. реквизит SK_ZB (заполнен выше)
                    if (SK_ZB != "" && SK_ZB != "0")
                    {
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

                    //счетчик цикла
                    k += 1;
                }
                
                msg.AppendChild(header);
                msg.AppendChild(body);
                doc.AppendChild(msg);

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
