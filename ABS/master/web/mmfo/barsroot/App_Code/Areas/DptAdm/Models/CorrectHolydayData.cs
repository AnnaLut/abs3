using System;

namespace BarsWeb.Areas.DptAdm.Models
{
    public class CorrectHolydayData
    {
        public DateTime Current_Date_End { get; set; }
        public DateTime New_Date_End { get; set; }
        public byte Corr_Type { get; set; }

    }
}