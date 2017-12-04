using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Escr.Models
{
    [XmlRoot("deals")]
    public class EscrGetStateDeals
    {
        /*public decimal deal_id { get; set; }
        public Int32? state_id { get; set; }
        public string comment { get; set; }
        public DateTime? money_date { get; set; }
        public bool is_set { get; set; }*/
        [XmlElement("deal")]
        public List<EscrGetStateDeal> deal { get; set; }

    }
}