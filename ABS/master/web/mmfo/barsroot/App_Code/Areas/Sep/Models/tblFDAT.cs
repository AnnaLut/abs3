using System;

namespace BarsWeb.Areas.Sep.Models
{
    public class tblFDAT
    {
        public DateTime? CHGDATE { get; set; }
        public DateTime FDAT { get; set; }
        public string KF { get; set; }
        public decimal? STAT { get; set; }
    }
}