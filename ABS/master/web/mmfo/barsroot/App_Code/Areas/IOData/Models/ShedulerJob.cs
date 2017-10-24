using System;

namespace BarsWeb.Areas.IOData.Models
{
    public class ShedulerJob
    {
        public string JobName { get; set; }
        public string State { get; set; }
        public string Enabled { get; set; }

        public DateTime? LastStartDate { get; set; }
        public DateTime? NextRunDate { get; set; }
        public string Description { get; set; }
        public string JobAction { get; set; }
    }
}