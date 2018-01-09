using System;

namespace BarsWeb.Areas.Kernel.Models
{
    public class Branches
    {
        public string Branch { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string B040 { get; set; }
        public DateTime? DateOpened { get; set; }
        public DateTime? DateClosed { get; set; }
        public DateTime? DateDeleted { get; set; }
        public string Sab { get; set; }
        public decimal? Idpdr { get; set; }
    }
}