using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PFU_DEATHS_NOTIFY
/// </summary>

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFU_DEATHS
    {
        public decimal? ID { get; set; }
        public decimal? REQUEST_ID { get; set; }
        public decimal? COUNT_RES { get; set; }
        public DateTime? DATE_PFU { get; set; }
        public DateTime? DATE_CR { get; set; }
        public string STATE { get; set; }
        public decimal? USERID { get; set; }
        public string PFU_FILE_ID { get; set; }

    }
}