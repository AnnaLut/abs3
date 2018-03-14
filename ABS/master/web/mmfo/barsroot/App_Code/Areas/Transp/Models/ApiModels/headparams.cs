using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Transp.Models.ApiModels
{

    /// <summary>
    /// Summary description for TagValueXml
    /// </summary>
    public class Headparams
    {
        [XmlElement("Headparam")]
        public List<Headparam> headparam { get; set; }

    }
}