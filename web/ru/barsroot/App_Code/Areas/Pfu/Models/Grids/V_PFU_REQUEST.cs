using System;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    /// <summary>
    /// Summary description for V_PFU_REQUEST
    /// </summary>
    public class V_PFU_REQUEST
    {
        public decimal id { get; set; }
        public DateTime? date_from { get; set; }
        public DateTime? date_to { get; set; }
        public string state_id { get; set; }
        public string state_name { get; set; }
        public decimal? pfu_request_id { get; set; }
        public DateTime request_time { get; set; }
        public string type_name { get; set; }
    }

}