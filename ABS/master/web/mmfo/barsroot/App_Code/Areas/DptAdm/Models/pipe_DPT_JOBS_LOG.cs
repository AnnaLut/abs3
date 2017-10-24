using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for pipe_DPT_JOBS_LOG
/// </summary>
namespace BarsWeb.Areas.DptAdm.Models
{
    public class pipe_DPT_JOBS_LOG
    {
        public decimal? REC_ID { get; set; }
        public decimal? RUN_ID { get; set; }
        public decimal? JOB_ID { get; set; }
        public decimal? DPT_ID { get; set; }
        public string BRANCH { get; set; }
        public decimal? REF { get; set; }
        public decimal? RNK { get; set; }
        public decimal? KV { get; set; }
        public decimal? DPT_SUM { get; set; }
        public decimal? INT_SUM { get; set; }
        public decimal? STATUS { get; set; }
        public string ERRMSG { get; set; }
        public string NLS { get; set; }
        public decimal? CONTRACT_ID { get; set; }
        public string DEAL_NUM { get; set; }
        public decimal? RATE_VAL { get; set; }
        public DateTime? RATE_DAT { get; set; }
        public string KF { get; set; }       
    }
}