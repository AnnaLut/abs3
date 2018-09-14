using System;

namespace Areas.SalaryBag.Models
{
    public class SignedModel
    {
        public string signed { get; set; }
        public string signed_fio { get; set; }
    }

    public class PayRollModel : SignedModel
    {
        public decimal? id { get; set; }
        public decimal? zp_id { get; set; }
        public string zp_deal_id { get; set; }
        public DateTime? pr_date { get; set; }
        public decimal? cnt { get; set; }
        public decimal? s { get; set; }
        public decimal? cms { get; set; }

        public string payroll_name { get; set; }
        public string src_name { get; set; }
        public string sos_name { get; set; }
        public string deal_name { get; set; }

        public int sos { get; set; }

        public decimal? rnk { get; set; }
        public string comm_reject { get; set; }

        public decimal? not_enogh_money { get; set; }
        public decimal? not_enogh_sum { get; set; }

        public string payroll_num { get; set; }

        public string nmk { get; set; }
        public string fio { get; set; }

        public decimal? ostc_2909 { get; set; }

        public decimal? src { get; set; }
        public DateTime? imp_date { get; set; }
    }
}
