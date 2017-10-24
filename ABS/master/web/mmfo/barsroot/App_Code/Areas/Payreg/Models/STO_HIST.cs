using System;

namespace BarsWeb.Areas.Payreg.Models
{
    public class STO_HIST
    {
        public decimal ID { get; set; }
        public decimal ORDER_ID { get; set; }
        public string USER_ID { get; set; }
        public string COMMENT_TEXT { get; set; }
        public string SYS_TIME { get; set; }
	}
}