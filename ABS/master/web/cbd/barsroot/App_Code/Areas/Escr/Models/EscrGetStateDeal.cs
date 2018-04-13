using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Escr.Models
{
    [XmlRoot("deal")]
    public class EscrGetStateDeal
    {
        [XmlElement("deal_id")]
        public decimal deal_id { get; set; }
        [XmlElement("state_id")]
        public int? state_id { get; set; }
        [XmlElement("comment")]
        public string comment { get; set; }
        [XmlElement("money_date")]
        public DateTime? money_date { get; set; }
        [XmlElement("is_set")]
        public bool is_set { get; set; }
        
        [XmlElement("NEW_GOOD_COST")]
        public decimal? NEW_GOOD_COST { get; set; }

        [XmlElement("NEW_DEAL_SUM")]
        public decimal? NEW_DEAL_SUM { get; set; }
        [XmlElement("NEW_COMP_SUM")]
        public decimal? NEW_COMP_SUM { get; set; }

        [XmlElement("OUTER_NUMBER")]
        public string OUTER_NUMBER { get; set; }
        
        
}
}