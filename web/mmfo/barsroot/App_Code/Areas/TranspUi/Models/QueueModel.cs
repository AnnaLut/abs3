using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OutQueueModel
/// </summary>
namespace Areas.TranspUi.Models
{
    public class QueueModel
    {
        public string ReqId { get; set; }
        public int? IsMain { get; set; }
        public int Priority { get; set; }
        public int? Status { get; set; }
        public DateTime? InsertTime { get; set; }
        public decimal? ExecTry { get; set; }
        public DateTime? LastTry { get; set; }
    }
}