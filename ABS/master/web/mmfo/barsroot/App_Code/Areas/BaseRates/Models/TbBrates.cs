using System;

namespace BarsWeb.Areas.BaseRates.Models
{
    public class TbBrates
    {
        public string IDROW { get; set; }
        public DateTime DATB { get; set; }
        public int KV { get; set; }
        public decimal IR { get; set; }
        public decimal? S { get; set; }
        public string S_STRING
        {
            get { return S.ToString(); }
            set
            {
                S = string.IsNullOrEmpty(value)? (decimal?)null : Convert.ToDecimal(value);
            }
        }
        public string BRANCH { get; set; }
        public string BRANCH_NAME { get; set; }
    }
}