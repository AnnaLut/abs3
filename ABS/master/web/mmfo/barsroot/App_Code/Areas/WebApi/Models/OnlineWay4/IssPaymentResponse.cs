namespace BarsWeb.Areas.WebApi.OnlineWay4.Models
{
    public partial class IssPaymentResponse : W4Response
    {
        public string CustomDataOut { get; set; }
        public string AuthCode { get; set; }
        public DebugInfoRecord[] DebugInfo { get; set; }
    }
}
