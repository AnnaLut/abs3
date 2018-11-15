using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace Bars.WebServices.XRM.Services.Common.Models
{
    public class SignDocumentsRequest
    {
        [XmlElement("DocumentId")]
        /// <summary>
        /// document id in ead_doc
        /// </summary>        
        public List<decimal> DocumentsId { get; set; }
    }

    public class SignDocumentsResponse
    {
        public SignDocumentsResponse()
        {
            Documents = new List<DocumentResult>();
        }

        [XmlElement("Document")]
        public List<DocumentResult> Documents { get; set; }
    }
    public class DocumentResult
    {

        public decimal DocumentId { get; set; }
        public int ResultCode { get; set; }
        public string ErrMessage { get; set; }
    }
}
