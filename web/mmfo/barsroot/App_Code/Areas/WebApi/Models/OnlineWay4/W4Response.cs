using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.WebApi.OnlineWay4.Models
{
    public class W4Response
    {
        public short RetCode { get; set; }
        public string RetMsg { get; set; }
        public string ResultInfo { get; set; }
    }
}
