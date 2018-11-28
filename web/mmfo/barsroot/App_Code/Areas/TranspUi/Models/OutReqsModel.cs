using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OutReqsModel
/// </summary>

namespace Areas.TranspUi.Models
{
    public class OutReqsModel
    {
        public string Id { get; set; }
        public string MainId { get; set; }
        public string ReqId { get; set; }
        public string UriGrId { get; set; }
        public string UriKf { get; set; }
        public string TypeId { get; set; }
        public DateTime? InsertTime { get; set; }
        public DateTime? SendTime { get; set; }
        public int? Status { get; set; }
        public DateTime? ProcessedTime { get; set; }
    }
}