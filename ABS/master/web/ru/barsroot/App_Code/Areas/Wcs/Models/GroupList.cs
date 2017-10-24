using System;

namespace BarsWeb.Areas.Wcs.Models
{
    public class GroupList
    {
        public Int32 BID_ID { get; set; }
        public string SURVEY_ID { get; set; }
        public string GROUP_ID { get; set; }
        public string GROUP_NAME { get; set; }
        public string RESULT_QID { get; set; }
        public short IS_FILLED { get; set; }
    }
}