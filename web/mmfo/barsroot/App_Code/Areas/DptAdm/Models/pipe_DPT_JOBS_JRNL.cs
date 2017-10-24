using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for pipe_DPT_JOBS_JRNL
/// </summary>


namespace BarsWeb.Areas.DptAdm.Models
{
    public class pipe_DPT_JOBS_JRNL
    {
        public decimal RUN_ID { get; set; }
        public decimal? JOB_ID { get; set; }
        public DateTime? START_DATE { get; set; }
        public DateTime? FINISH_DATE { get; set; }
        public DateTime? BANK_DATE { get; set; }
        public decimal? USER_ID { get; set; }
        public decimal? STATUS { get; set; }
        public string ERRMSG { get; set; }
        public string BRANCH { get; set; }
        public DateTime? DELETED { get; set; }
        public string KF { get; set; }

    }
}