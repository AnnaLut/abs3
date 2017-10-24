using System;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFU_PENSIONER
    {
        public string adr { get; set; }
        public DateTime? bday { get; set; }
        public string bplace { get; set; }
        public string branch { get; set; }
        public string cellphone { get; set; }
        public string comm { get; set; }
        public DateTime? date_off { get; set; }
        public DateTime date_on { get; set; }
        public decimal id { get; set; }
        public string kf { get; set; }
        public string nmk { get; set; }
        public string numdoc { get; set; }
        public string okpo { get; set; }
        public string organ { get; set; }
        public Int32 passp { get; set; }
        public DateTime? pdate { get; set; }
        public decimal rnk { get; set; }
        public string ser { get; set; }
        public string state { get; set; }

        public int? type_pensioner { get; set; }
        public string nls { get; set; }
        public DateTime? daos { get; set; }
        public int? block_type { get; set; }
        public DateTime? block_date { get; set; }
        public Int32 is_okpo_well { get; set; }
    }
}