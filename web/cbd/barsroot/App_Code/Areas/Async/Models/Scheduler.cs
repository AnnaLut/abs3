using System.Collections.Generic;

namespace BarsWeb.Areas.Async.Models
{
    public class Scheduler
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Type { get; set; }
        public int? SqlId { get; set; }
        public string SqlText { get; set; }
        public int? WebUiId { get; set; }
        public bool? IsBarsLogin { get; set; }
        public string ExclusionMode { get; set; }
        public int? MaxExecutionTime { get; set; }
        public string UserMessages { get; set; }
        public List<TaskParameter> ParametersList { get; set; }
    }
}

