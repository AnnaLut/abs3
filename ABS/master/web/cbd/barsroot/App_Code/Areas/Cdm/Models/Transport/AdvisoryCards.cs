using System.ComponentModel.DataAnnotations;
using System.Xml.Serialization;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot("request")]
    public class AdvisoryCards
    {
        [Required]
        [XmlElement("batchId")]
        public string BatchId { get; set; }
        [Required]
        [XmlElement("kf")]
        public string Kf { get; set; }
        [Required]
        [XmlElement("clientAnalysis")]
        public ClientAnalysis[] ClientsAnalysis { get; set; }
    }
}