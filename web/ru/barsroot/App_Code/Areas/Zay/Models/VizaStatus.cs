using System;

namespace BarsWeb.Areas.Zay.Models
{
    public class VizaStatus
    {
        public decimal? ID { get; set; }
        public decimal? TrackId { get; set; }
        public DateTime? ChangeTime { get; set; }
        public string FIO { get; set; }
        public decimal? Viza { get; set; }
        public string StatusName { get; set; }
    }
}