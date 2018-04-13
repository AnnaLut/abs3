
using System;

namespace BarsWeb.Areas.Kernel.Models
{
    public class Currency 
    {
        public int Code { get; set; }
        public int? GroupCode { get; set; }
        public string CharCode { get; set; }
        public string SepCharCode { get; set; }
        public string Name { get; set; }
        public int? Country { get; set; }
        public DateTime? DateClosed { get; set; }
        public bool IsMetal { get; set; }

    }
}