using System;

namespace BarsWeb.Areas.KFiles.Models
{
    public class V_OB_CORPORATION
    {
        public decimal ID { get; set; }
        public string EXTERNAL_ID { get; set; }
        public string CORPORATION_NAME { get; set; }

        public string CORPORATION_CODE { get; set; }
        public decimal? PARENT_ID { get; set; }
        public decimal? STATE_ID { get; set; }
        public string CORPORATION_STATE { get; set; }

        public string PARENT_NAME { get; set; }
    }

    public class V_SYNC_SESSION
    {
        public Decimal ID { get; set; }
        public String MFO { get; set; }
        public String FILE_DATE { get; set; }
        public String CORPORATION { get; set; }
        public String STATE { get; set; }
        public String SYNCTIME { get; set; }

    }

}
