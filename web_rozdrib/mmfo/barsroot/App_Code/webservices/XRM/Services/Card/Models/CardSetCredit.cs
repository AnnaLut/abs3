using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace Bars.WebServices.XRM.Services.Card.Models
{
    public class CardCreditRequest
    {
        [XmlArrayItem("Account")]
        public List<long> Accounts { get; set; }
        public decimal MaxSum { get; set; }
        public decimal DesiredSum { get; set; }
        public decimal InstalledSum { get; set; }
        [XmlArrayItem("Template")]
        public List<string> Templates { get; set; }
    }
    public class CardCreditResponse
    {
        [XmlArrayItem("Account")]
        public List<long> Accounts { get; set; }
        public string RtfContent { get; set; }
        [XmlArrayItem("PdfDocument")]
        public List<PdfDocument> PdfDocuments { get; set; }
    }

    public class PdfDocument
    {
        public long Account { get; set; }
        public string Content { get; set; }
        public long? DocumentId { get; set; }
    }

    public class FrxCreateData
    {
        public FrxCreateData()
        {
            Templates = new List<FrxTemplate>();
            Accounts = new List<FrxAccount>();
        }
        public List<FrxTemplate> Templates { get; set; }
        public List<FrxAccount> Accounts { get; set; }
    }

    public class FrxTemplate
    {
        public string Name { get; set; }
        public decimal? StructCode { get; set; }
    }
    public class FrxAccount
    {
        public long Account { get; set; }
        public long Rnk { get; set; }
    }
}