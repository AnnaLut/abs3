using System;

namespace BarsWeb.Areas.WebApi.OnlineWay4.Models
{
    public class Header
    {
        public string SessionContextStr { get; set; }
        public string UserInfo { get; set; }
        public string CorrelationId { get; set; }
    }
}
