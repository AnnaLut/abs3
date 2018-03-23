using System;
using System.Xml.Serialization;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.SKRN.Models
{
    public class DocsByDealRequest
    {
        /// <summary>
        /// Номер договору
        /// </summary>
        public long? Nd { get; set; }
    }

    public class DocumentsByDealResponse
    {
        [XmlElement(ElementName = "Document")]
        public List<DocumentModel> Documents { get; set; }
    }

    public class DocumentModel
    {
        /// <summary>
        /// Внутрішній номер документу
        /// </summary>
        public Int64? Ref { get; set; }
        /// <summary>
        /// Дата документу
        /// </summary>
        public DateTime? DatD { get; set; }
        /// <summary>
        /// Рахунок відправника
        /// </summary>
        public string NlsA { get; set; }
        /// <summary>
        /// Код валюти
        /// </summary>
        public int? KvA { get; set; }
        /// <summary>
        /// Сума
        /// </summary>
        public decimal? SA { get; set; }
        /// <summary>
        /// Рахунок отримувача
        /// </summary>
        public string NlsB { get; set; }
        /// <summary>
        /// Код валюти 2
        /// </summary>
        public int? KvB { get; set; }
        /// <summary>
        /// Сума 2
        /// </summary>
        public decimal? SB { get; set; }
        /// <summary>
        /// Призначення платежу
        /// </summary>
        public string Nazn { get; set; }
    }
}