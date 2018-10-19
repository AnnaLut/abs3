using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.SWCompare.Models
{
    public class ResolveModel
    {
        public decimal p_id { get; set; }
        public string comment { get; set; }
    }

    public class HandModel
    {
        public string p_kod_nbu { get; set; }
        public decimal? p_ref { get; set; }
        public string p_tt { get; set; }
        public string p_transactionid { get; set; }
        public decimal p_operation { get; set; }
        public DateTime p_ddate_oper { get; set; }
        public decimal p_prn_file { get; set; }
        public string p_kf { get; set; }
        public string p_comments { get; set; }
    }

}
