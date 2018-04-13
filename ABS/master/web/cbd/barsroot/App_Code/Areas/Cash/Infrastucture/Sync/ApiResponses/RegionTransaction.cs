using System;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Отделение (бранч), полученный из региона
    /// </summary>
    public class RegionTransaction
    {
        public string Mfo { get; set; }
        public decimal? AccSourceId { get; set; }
        public string AccNumber { get; set; }
        public decimal? AccCurrency { get; set; }
        public decimal? Summa { get; set; }
        public DateTime? Date { get; set; }
        public decimal? Reference { get; set; }
    }
}