namespace BarsWeb.Areas.WebApi.Subvention.Models
{
    public class PaymentResult
    {
        public byte Status { get; set; }
        public long Ref { get; set; }
        public long ExtId { get; set; }
    }
}
