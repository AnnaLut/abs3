using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.PfuServer.Models
{
    public class SyncRuParam
    {
        public string KF { get; set; } //mfo
        public DateTime? LAST_SYNC_DATE { get; set; }
        public string LAST_SYNC_STATUS { get; set; }
        public string NAME { get; set; }
        public decimal PACK_SIZE { get; set; }
        public Int16 SYNC_ENABLED { get; set; }
        public string SYNC_LOGIN { get; set; }
        public string SYNC_PASSWORD { get; set; }
        public string SYNC_SERVICE_URL { get; set; }
    }
}