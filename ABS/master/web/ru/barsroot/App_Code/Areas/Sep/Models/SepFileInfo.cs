using System;

namespace BarsWeb.Areas.Sep.Models
{
    public class SepFileInfo
    {
        public string FileName { get; set; }
        public string Currency { get; set; }
        public DateTime FileCreated { get; set; }
        public long? RowCount { get; set; }
        public decimal? DebitSum { get; set; }
        public decimal? KreditSum { get; set; }
        public DateTime? MatchingDate { get; set; }
        public int? FileStatus { get; set; }
        public decimal? Ref { get; set; }
        public decimal? ErrorCode { get; set; }
        public int? State { get; set; }
    }
}