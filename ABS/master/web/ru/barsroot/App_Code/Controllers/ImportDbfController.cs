using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;
using System.Xml.Serialization;
using AttributeRouting.Helpers;
using BarsWeb.Models;
using DotNetDBF;
using Oracle.DataAccess.Client;

namespace BarsWeb.Controllers
{
    public class ImportDbfController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Save(IEnumerable<HttpPostedFileBase> files, int dosPage = 1)
        {
            HttpPostedFileBase[] dbfs = { };
            PaymentMessage payments = null;
            if (files != null)
            {
                dbfs = files.ToArray();
                DBFReader file = new DBFReader(dbfs[0].InputStream);
                if (file.RecordCount == 0)
                {
                    HttpContext.AddError(new Exception("Файл пустий."));
                    return null;
                }
                payments = new PaymentMessage(Path.GetFileName(dbfs[0].FileName));
                for (var i = 0; i < file.RecordCount; i++)
                {
                    var objects = file.NextRecord(dosPage == 1 ? 866 : 1251);

                    payments.Body.Body.Add(new Pnmt()
                    {
                        BodyPayment = new BodyPayment()
                        {
                            Payments = new Payment(
                                rowNum: i + 1,
                                ndoc: (string)objects[0],
                                dt: (DateTime)objects[1],
                                mfocli: (string)objects[2],
                                okpocli: (string)objects[3],
                                acccli: (string)objects[4],
                                namecli: (string)objects[5],
                                bankcli: (string)objects[6],
                                mfocor: (string)objects[7],
                                acccor: (string)objects[8],
                                okpocor: (string)objects[9],
                                namecor: (string)objects[10],
                                bankcor: (string)objects[11],
                                dk: (decimal)objects[12],
                                summa: (decimal)objects[13],
                                nazn: (string)objects[14],
                                val: (decimal)objects[15])
                        }
                    }

                        );
                }
            }
            else
            {
                HttpContext.AddError(new Exception("Помилка завантаження файлу."));
            }

            var xml = SerializeToXml(payments);
            return Json(ImportXml(xml), "text/plain");
        }

        private string SerializeToXml(PaymentMessage obj)
        {
            XmlWriterSettings settings = new XmlWriterSettings { OmitXmlDeclaration = true, CheckCharacters = false };
            XmlSerializerNamespaces names = new XmlSerializerNamespaces();
            names.Add("", "");
            XmlSerializer ser = new XmlSerializer(typeof(PaymentMessage));
            MemoryStream ms = new MemoryStream();
            XmlWriter writer = XmlWriter.Create(ms, settings);
            ser.Serialize(writer, obj, names);
            writer.Close();
            ms.Flush();
            ms.Seek(0, SeekOrigin.Begin);

            StreamReader sr = new StreamReader(ms);
            var xml = sr.ReadToEnd();
            return xml;
        }

        private ImportResult ImportXml(string xml)
        {
            var entity = new EntitiesBarsCore().NewEntity();
            string outFileName = null;
            object[] parameters =
            {
                new OracleParameter("p_indoc", OracleDbType.Clob) {Value = xml} ,
                new OracleParameter("p_packname", OracleDbType.Varchar2) { Direction = ParameterDirection.Output, Size = 30}
            };
            entity.ExecuteStoreCommand(@"begin bars_xmlklb_imp.make_import(p_indoc => :p_indoc, p_packname => :p_packname); end;", parameters);
            outFileName = ((OracleParameter)parameters[1]).Value.ToString();

            decimal cnt = 0;
            decimal sum = 0;
            object[] parameters1 =
            {
                new OracleParameter("p_filename", OracleDbType.Varchar2, string.IsNullOrEmpty(outFileName) ? null : outFileName, ParameterDirection.Input),
                new OracleParameter("p_filecnt", OracleDbType.Decimal, cnt, ParameterDirection.Output),
                new OracleParameter("p_filesum", OracleDbType.Decimal, sum, ParameterDirection.Output)
            };
            entity.ExecuteStoreCommand(@"
                    begin 
                        bars_xmlklb_imp.import_results(
                          p_filename => :p_filename,  
                          p_dat      => bankdate, 
                          p_filecnt  => :p_filecnt,  
                          p_filesum  => :p_filesum); 
                    end;", parameters1);
            cnt = int.Parse(((OracleParameter)parameters1[1]).Value.ToString());
            sum = int.Parse(((OracleParameter)parameters1[2]).Value.ToString());
            return new ImportResult()
            {
                ImportedRows = cnt,
                ImportedSum = sum / 100
            };
        }
    }

    #region Вспомогательные классы

    internal class ImportResult
    {
        public decimal ImportedRows { get; set; }
        public decimal ImportedSum { get; set; }
    }

    [XmlRoot(ElementName = "PaymentMessage")]
    public class PaymentMessage
    {
        public MsgHeader Header { get; set; }
        public MsgBody Body { get; set; }

        public PaymentMessage()
        {
            Header = new MsgHeader("null", "PMNT", null, null, null);
            Body = new MsgBody();
        }
        public PaymentMessage(string fileName)
        {
            Header = new MsgHeader(fileName, "PMNT", null, null, null);
            Body = new MsgBody();
        }
    }

    public class MsgHeader
    {
        public MsgHeader(string id, string type, string timestamp, string senderId, string receiverId)
        {
            MessageId = id;
            MessageType = type;
            MessageTimestamp = timestamp;
            SenderId = senderId;
            ReceiverId = receiverId;

        }
        public MsgHeader()
        {

        }
        [XmlElement("MessageID")]
        public string MessageId { get; set; }
        public string MessageType { get; set; }
        public string MessageTimestamp { get; set; }
        [XmlElement("SenderID")]
        public string SenderId { get; set; }
        [XmlElement("ReceiverID")]
        public string ReceiverId { get; set; }
    }

    public class MsgBody
    {
        public MsgBody()
        {
            Body = new List<Pnmt>();
        }
        [XmlElement("PMNT")]
        public List<Pnmt> Body { get; set; }
    }

    public class Pnmt
    {
        public Pnmt()
        {
            Sign = "";
            Key = "";
            BodyPayment = new BodyPayment();
        }
        [XmlAttribute("SIGN")]
        public string Sign { get; set; }
        [XmlAttribute("KEY")]
        public string Key { get; set; }
        [XmlElement("Body_PMNT")]
        public BodyPayment BodyPayment { get; set; }
    }

    public class BodyPayment
    {
        public BodyPayment()
        {
            Payments = new Payment();
        }
        [XmlElement("Payment")]
        public Payment Payments { get; set; }
    }

    public class Payment
    {
        public Payment()
        {
            AddAttributes = new AddAttributes();
        }
        public Payment(
            int rowNum,
            string ndoc,
            DateTime dt,
            string mfocli,
            string okpocli,
            string acccli,
            string namecli,
            string bankcli,
            string mfocor,
            string acccor,
            string okpocor,
            string namecor,
            string bankcor,
            decimal dk,
            decimal summa,
            string nazn,
            decimal val)
        {
            LineNumber = rowNum.ToString();
            DocNumber = ndoc.Trim();
            DocDate = dt.ToString("yyyy-MM-dd");
            Payer = new Contragent(namecli.Trim(), mfocli.Trim(), okpocli.Trim(), acccli.Trim());
            Payee = new Contragent(namecor.Trim(), mfocor.Trim(), okpocor.Trim(), acccor.Trim());
            Amount1 = new Amount((long)summa, (int)val);
            Amount2 = new Amount((long)summa, (int)val);
            Dk = dk.ToString();
            Details = nazn.Trim();
            AddAttributes = new AddAttributes();
        }
        [XmlAttribute("LineNumber")]
        public string LineNumber { get; set; }
        public string DocNumber { get; set; }
        public string DocDate { get; set; }
        public Contragent Payer { get; set; }
        public Contragent Payee { get; set; }
        public Amount Amount1 { get; set; }
        public Amount Amount2 { get; set; }
        public string ValueDate { get; set; }
        [XmlElement("VOB")]
        public string Vob { get; set; }
        public string Details { get; set; }
        [XmlElement("TT")]
        public string Tt { get; set; }
        [XmlElement("DK")]
        public string Dk { get; set; }
        [XmlElement("SK")]
        public string Sk { get; set; }
        [XmlElement("REF_A")]
        public string RefA { get; set; }
        public AddAttributes AddAttributes { get; set; }
    }

    public class AddAttributes
    {
        public AddAttributes()
        {
            ImportType = 2;
        }
        [XmlElement("IMPTP")]
        public int ImportType { get; set; }
    }

    public class Contragent
    {
        public Contragent()
        {
        }

        public Contragent(string name, string mfo, string okpo, string account)
        {
            Name = name;
            Mfo = mfo;
            Okpo = okpo;
            Account = account;
        }
        public string Name { get; set; }
        [XmlElement("MFO")]
        public string Mfo { get; set; }
        public string Account { get; set; }
        [XmlElement("OKPO")]
        public string Okpo { get; set; }
    }

    public class Amount
    {
        public Amount()
        {
        }

        public Amount(Int64 sum, int val)
        {
            Sum = sum;
            Currency = new Currency(val);
        }
        [XmlElement("Amount")]
        public Int64 Sum { get; set; }
        public Currency Currency { get; set; }
    }

    public class Currency
    {
        public Currency()
        {
        }

        public Currency(int val)
        {
            NbuCode = val;
        }
        [XmlElement("NBUCode")]
        public Int64 NbuCode { get; set; }
    }
    #endregion
}