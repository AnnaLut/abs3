using System;

namespace BarsWeb.Areas.Pfu.Models.Console
{
    /// <summary>
    /// V_PFU_SESSION_TRACKING - модель інформування щодо запитів до пфу
    /// </summary>
    public class V_PFU_SESSION_TRACKING
    {
        public decimal id { get; set; }
        public decimal request_id { get; set; }
        public decimal session_id { get; set; }
        public string state_code { get; set; }
        public string state_id { get; set; }
        public DateTime sys_time { get; set; }
        public string tracking_comment { get; set; }
    }
}