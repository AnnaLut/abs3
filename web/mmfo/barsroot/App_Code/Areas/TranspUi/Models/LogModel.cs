using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OutputLogModel
/// </summary>

namespace Areas.TranspUi.Models
{
    public class LogModel
    {
        public decimal Id { get; set; }
        public string ReqId { get; set; }
        public string SubReq { get; set; }
        public string ChkReq { get; set; }
        public string Act { get; set; }
        public string State { get; set; }
        public string Message { get; set; }
        public DateTime? InsertDate { get; set; }
    }
}