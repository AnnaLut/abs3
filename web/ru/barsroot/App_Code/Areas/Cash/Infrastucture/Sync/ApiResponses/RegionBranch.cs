using System;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Отделение (бранч), полученный из региона
    /// </summary>
    public class RegionBranch
    {
        public string Branch { get; set; }
        public string Name { get; set; }
        public string B040 { get; set; }
        public string Description { get; set; }
        public decimal? IdPdr { get; set; }
        public DateTime OpenDate { get; set; }
        public DateTime? CloseDate { get; set; }
        public DateTime? DeleteDate { get; set; }
        public string Sab { get; set; }
        public string Obl { get; set; }
    }
}