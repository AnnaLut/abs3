using System.Xml.Serialization;

namespace BarsWeb.Areas.WebApi.OnlineWay4.Models
{
    public partial class RequestModel
    {
        public string Url { get; set; }
        public string Data { get; set; }
        public string Prefix { get; set; }
        public string NameSpace { get; set; }
        public string Header { get; set; }
        public string Method { get; set; }
        public string Timeout { get; set; }
    }
}
