namespace BarsWeb.Areas.Sep.Models
{
    public class SepFileUncreateParams
    {
        public string FileName { get; set; }
        public string FileCreated { get; set; }
        public decimal? DebitSum { get; set; }
        public decimal? KreditSum { get; set; }
        public int BpReasonId { get; set; }
        public decimal? RowCount { get; set; }
        public decimal? ErrorCode { get; set; }
    }
}