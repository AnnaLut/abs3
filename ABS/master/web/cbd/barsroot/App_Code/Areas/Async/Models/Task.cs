using System;

namespace BarsWeb.Areas.Async.Models
{
    public class Task
    {
        public int Id { get; set; }
        public int SchedulerId { get; set; }
        public string JobName { get; set; }
        public string JobSql { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public decimal? DbmshpRunId { get; set; }
        public string ExclusionMode { get; set; }
        public string State { get; set; }
        public string ErrorMessage { get; set; }
        public int? UserId { get; set; }
    }
}
