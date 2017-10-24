using System;

namespace BarsWeb.Areas.Dwh.Models
{
    /// <summary>
    /// Summary description for V_DWH_CBIREP_QUERIES
    /// </summary>
    public class V_DWH_CBIREP_QUERIES
    {
        public DateTime CREATION_TIME { get; set; }
        public string FILE_NAMES { get; set; }
        public decimal ID { get; set; } 
        public decimal? JOB_ID { get; set; } 
        public string KEY_PARAMS { get; set; }
        public string REPORT_NAME { get; set; }
        public decimal REP_ID { get; set; } 
        public decimal? SESSION_ID { get; set; } 
        public DateTime STATUS_DATE { get; set; }
        public string STATUS_ID { get; set; }
        public string STATUS_NAME { get; set; }
        public decimal USERID { get; set; } 
    }
}