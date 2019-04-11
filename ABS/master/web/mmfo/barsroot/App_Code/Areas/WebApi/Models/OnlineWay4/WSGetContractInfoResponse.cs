using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.WebApi.OnlineWay4.Models
{
    public class WSGetContractInfoResponse : W4Response
    {
        public int? OutObjectCount { get; set; }
        public bool ShouldSerializeOutObjectCount()
        {
            return OutObjectCount != null;
        }

        [XmlArrayItem("InfoRecord")]
        public InfoRecord[] OutObject { get; set; }
    }
}
