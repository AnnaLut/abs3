using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.ComponentModel.DataAnnotations;

namespace Bars.WebServices.GercPayModels
{
    public struct DocumentData
    {
        public string DocumentNumber { get; set; }
        public string OperationType { get; set; }
        public decimal? DocumentType { get; set; }
        public DateTime? DocumentDate { get; set; }
        public string DebitMfo { get; set; }
        public string CreditMfo { get; set; }
        public string DebitAccount { get; set; }
        public string CreditAccount { get; set; }
        public string DebitName { get; set; }
        public string CreditName { get; set; }
        public string DebitEdrpou { get; set; }
        public string CreditEdrpou { get; set; }
        public decimal? Amount { get; set; }
        public string Currency { get; set; }
        public string Purpose { get; set; }

        [XmlIgnore]
        public decimal? CashSymbol { get; set; }

        [XmlElement("CashSymbol")]
        public String CashSymbolForXml
        {
            get
            {
                return null == CashSymbol ? null : CashSymbol.ToString();
            }
            set
            {
                if (!string.IsNullOrEmpty(value))
                {
                    decimal tmp;
                    if (!decimal.TryParse(value, out tmp))
                        throw new System.Exception("Parameter CashSymbol must be a number.");
                    else
                        CashSymbol = tmp;
                }
                else
                {
                    CashSymbol = null;
                }
            }
        }

        public decimal? DebitFlag { get; set; }
        public string AdditionalRequisites { get; set; }
        public string DigitalSignature { get; set; }
        public string DocumentAuthor { get; set; }
        public string Branch { get; set; }
        public string ExternalDocumentId { get; set; }
        public string AdditionalOperRequisites { get; set; }
    }
}