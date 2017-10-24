using System;

namespace BarsWeb.Areas.Reporting.Models
{
    public class RepoDataRequest
    {
        public string fileCodeBase64 { get; set; }
        public string schemeCode { get; set; }
        public string kf { get; set; }
        public string isCon { get; set; }
        public string versionId { get; set; }
        public string date { get; set; }
    }
}
