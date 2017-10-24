using System;

namespace BarsWeb.Areas.DepoFiles.Models
{
    public class UpdateModel
    {
        public string NLS { get; set; }
        public decimal? BRANCHCODE { get; set; }
        public decimal? DPTCODE { get; set; }
        public decimal SUM { get; set; }
        public string FIO { get; set; }
        public string IDCODE { get; set; }
        public DateTime PAYOFFDATE { get; set; }
        public decimal? EXCLUDED { get; set; }
        public string BRANCH { get; set; }
        public string ACCTYPE { get; set; }
        public decimal? INFOID { get; set; }
    }
}