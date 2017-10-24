using System;
using System.Data;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace bars.sberimport
{
    public static class PaymentMessageManager
    {
        public static byte[] FillArray(string fName, DataRowCollection rs)
        {
            byte[] data = null;

            PaymentMessage pm = new PaymentMessage();
            pm.Header = new Header_()
            {
                MessageID = fName, MessageType = "PMNT", MessageTimestamp = "", SenderID = "", ReceiverID = ""
            };
            pm.Body = new Body_();
            pm.Body.PMNT = new PMNT_[rs.Count];

            for (int i = 0; i < rs.Count; i++)
            {
                DataRow r = rs[i];

                string kb_a = Convert.ToString(r.ItemArray[0]);         //МФО банку відправника
                string kk_a = Convert.ToString(r.ItemArray[1]);         //Рахунок банку відправника
                string kb_b = Convert.ToString(r.ItemArray[2]);         //МФО банку отримувача
                string kk_b = Convert.ToString(r.ItemArray[3]);         //Рахунок отримувача
                byte d_k = Convert.ToByte(r.ItemArray[4]);              //Ознака «0 – дебет, 1 – кредит»
                decimal summa = Convert.ToDecimal(r.ItemArray[5]);      //Сума документу
                //summa *= 100;
                int vid = Convert.ToInt32(r.ItemArray[6]);              //Вид документу
                string ndoc = Convert.ToString(r.ItemArray[7]);         //Номер документу
                int i_va = Convert.ToInt32(r.ItemArray[8]);             //Валюта платежу
                DateTime da = Convert.ToDateTime(r.ItemArray[9]);       //Дата проведення в банку Клієнта
                DateTime da_doc = Convert.ToDateTime(r.ItemArray[10]);  //Дата платіжного документу
                string nk_a = Convert.ToString(r.ItemArray[11]);        //Назва  кореспондента А  
                string nk_b = Convert.ToString(r.ItemArray[12]);        //Назва  кореспондента Б
                string nazn = Convert.ToString(r.ItemArray[13]);        //Призначення платежу
                string kod_a = Convert.ToString(r.ItemArray[14]);       //Код ЄДРПОУ відправника
                string kod_b = Convert.ToString(r.ItemArray[15]);       //Код ЄДРПОУ отримувача

                pm.Body.PMNT[i] = new PMNT_()
                {
                    KEY = "",
                    SIGN = "",
                    Body_PMNT = new Body_PMNT_()
                    {
                        Payment = new Payment_()
                        {
                            //<Attribute><AttributeName>SK_ZB</AttributeName><AttributeValue>84</AttributeValue><AttributeType>String</AttributeType></Attribute>
                            AddAttributes = new Attributes()
                            {
                                IMPTP = "7",
                                Attribute = new Attribute_
                                {
                                    AttributeName = "SK_ZB",
                                    AttributeType = "String",
                                    AttributeValue = "84"
                                }
                            },
                            Amount1 = new Amount_() { Amount = summa, Currency = new Currency_() { NBUCode = i_va } },
                            Amount2 = new Amount_() { Amount = summa, Currency = new Currency_() { NBUCode = i_va } },
                            LineNumber = i + 1,
                            Details = nazn,
                            DK = d_k,
                            DocDate = da_doc.ToString("yyyy-MM-dd"),
                            DocNumber = ndoc,
                            ValueDate = da.ToString("yyyy-MM-dd"),
                            Payee = new Subject()
                            {
                                Account = kk_b,
                                MFO = kb_b,
                                Name = nk_b,
                                OKPO = kod_b
                            },
                            Payer = new Subject()
                            {
                                Account = kk_a,
                                MFO = kb_a,
                                Name = nk_a,
                                OKPO = kod_a
                            },
                            TT = "PKS", REF_A = "", SK = "", VOB = ""
                        }
                    }
                };
            }

            XmlSerializer formatter = new XmlSerializer(typeof(PaymentMessage));
            XmlSerializerNamespaces xns = new XmlSerializerNamespaces();
            xns.Add(string.Empty, string.Empty);

            XmlWriterSettings settings = new XmlWriterSettings();
            settings.OmitXmlDeclaration = true;
            settings.Encoding = Encoding.GetEncoding(1251);
            // next two settings are optional
            settings.Indent = true;
            settings.IndentChars = "    ";
            
            using (MemoryStream st = new MemoryStream())
            {
                //using (XmlWriter writer = XmlWriter.Create(Path.Combine(Path.GetTempPath(), string.Format("{0}.xml", Path.GetFileNameWithoutExtension(fName))), settings))
                //{
                //    writer.WriteRaw("<?xml version=\"1.0\" encoding=\"windows-1251\" standalone=\"yes\"?>\r\n");
                //    formatter.Serialize(writer, pm, xns);
                //}
                using (XmlWriter writer = XmlWriter.Create(st, settings))
                {
                    writer.WriteRaw("<?xml version=\"1.0\" encoding=\"windows-1251\" standalone=\"yes\"?>\r\n");
                    formatter.Serialize(writer, pm, xns);
                    data = st.ToArray();
                }
            }
            return data;
        }                
    }

    [Serializable]
    public class PaymentMessage
    {
        public Header_ Header { get; set; }
        public Body_ Body { get; set; }
    }

    [Serializable]
    public class Header_
    {
        public string MessageID { get; set; }
        public string MessageType { get; set; }
        public string MessageTimestamp { get; set; }
        public string SenderID { get; set; }
        public string ReceiverID { get; set; }
    }

    [Serializable]
    public class Body_
    {
        [XmlElement]
        public PMNT_[] PMNT;
    }

    [Serializable]
    public class PMNT_
    {
        [XmlAttribute]
        public string SIGN { get; set; }

        [XmlAttribute]
        public string KEY { get; set; }

        public Body_PMNT_ Body_PMNT { get; set; }
    }

    [Serializable]
    public class Body_PMNT_
    {
        public Payment_ Payment { get; set; }
    }

    [Serializable]
    public class Attributes
    {
        public string IMPTP { get; set; }
        public Attribute_ Attribute { get; set; }
    }

    [Serializable]
    public class Attribute_
    {
        public string AttributeName { get; set; }
        public string AttributeValue { get; set; }
        public string AttributeType { get; set; }
    }

    [Serializable]
    public class Currency_
    {
        public int NBUCode { get; set; }
    }

    [Serializable]
    public class Amount_
    {
        public decimal Amount { get; set; }
        public Currency_ Currency { get; set; }
    }

    [Serializable]
    public class Subject
    {
        public string Name { get; set; }
        public string MFO { get; set; }
        public string Account { get; set; }
        public string OKPO { get; set; }
    }

    [Serializable]
    public class Payment_
    {
        [XmlAttribute]
        public int LineNumber { get; set; }
        public string DocNumber { get; set; }
        public string DocDate { get; set; }
        public Subject Payer { get; set; }
        public Subject Payee { get; set; }
        public Amount_ Amount1 { get; set; }
        public Amount_ Amount2 { get; set; }
        public string ValueDate { get; set; }
        public string Details { get; set; }
        public byte DK { get; set; }
        public string TT { get; set; }

        // unknown
        public string VOB { get; set; }
        public string REF_A { get; set; }
        public string SK { get; set; }
        public Attributes AddAttributes { get; set; }
    }
}
