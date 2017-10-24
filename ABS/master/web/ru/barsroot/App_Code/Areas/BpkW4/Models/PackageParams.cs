namespace BarsWeb.Areas.BpkW4.Models
{
    public class PackageParams
    {
        public decimal FileId { get; set; }
        public string Branch { get; set; }
        public decimal ExecutorId { get; set; }
        public decimal? ProjectId { get; set; }
        public string CardId { get; set; }
    }
}