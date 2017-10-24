using System;

namespace BarsWeb.Areas.Sep.Models
{
    public class SepParticipantsHistoryModel
    {
        public string DAT { get; set; }
        public decimal USERID { get; set; }
        public decimal? LIM { get; set; }
        public decimal? LNO { get; set; }
        public string DAT_SYS { get; set; }
        public string FIO { get; set; }
    }
}