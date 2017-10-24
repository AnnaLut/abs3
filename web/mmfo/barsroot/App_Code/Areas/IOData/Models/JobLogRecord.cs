using System;

namespace BarsWeb.Areas.IOData.Models
{
    public class JobLogRecord
    {
        public decimal? LogId { get; set; }
        public DateTime? LogDate { get; set; }
        public string JobName { get; set; }
        public string Status { get; set; }
        public DateTime? ActualStartDate { get; set; }
        public decimal? RunDuration { get; set; }
        public string Info { get; set; }
        
        public string MessInfo { get; set; }       
    }
}