using System;

namespace BarsWeb.Areas.BpkW4.Models
{
    public class ParamsIns
    {
        public string ERROR_MSG { get; set; }
        public bool haveins { get; set; }
        public decimal? insUkrId { get; set; }
        public decimal? insWrdId { get; set; }
        public decimal? tmpUkrId { get; set; }
        public decimal? tmpWrdId { get; set; }
    }
}