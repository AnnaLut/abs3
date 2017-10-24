using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFU_JOB_INFO
    {
        public string JOB_NAME { get; set; }
        public string COMMENTS { get; set; }
        public string STATE { get; set; }
        public string LAST_START_DATE { get; set; }
        public Object LAST_RUN_DURATION { get; set; }
        public string NEXT_RUN_DATE { get; set; }
        public string RUN_STATUS { get; set; }
        public string ADD_INFO { get; set; }


        public static String GetTimestamp(DateTime value)
        {
            return value.ToString("yyyyMMddHHmmssffff");
        }
    }
}