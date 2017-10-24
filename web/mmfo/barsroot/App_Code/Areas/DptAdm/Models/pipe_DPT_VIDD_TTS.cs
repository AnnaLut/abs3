using System;

namespace BarsWeb.Areas.DptAdm.Models
{
    public class pipe_DPT_VIDD_TTS
    {
        public decimal vidd{ get; set; }
        public string added { get; set; }
        public string OP_TYPE { get; set; }
        public string OP_NAME { get; set; }
        public Int32 TT_ID { get; set; }
        public string TT_NAME { get; set; }
        public decimal? TT_CASH { get; set; }
    }
}