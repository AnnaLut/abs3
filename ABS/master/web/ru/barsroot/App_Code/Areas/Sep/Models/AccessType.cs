namespace BarsWeb.Areas.Sep.Models
{
    public class AccessType
    {
        public string AccessFlags { get; set; }
        public string Mode { get; set; }
        public bool  PaymentStateFlag  { get; set; }
        public string NN { get; set; }
        public string KV { get; set; }

        public bool obFixed { get; set; }
    }
}