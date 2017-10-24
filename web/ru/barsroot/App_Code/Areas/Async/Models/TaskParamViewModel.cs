using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Async.Models
{
    public class TaskParamViewModel
    {
        public string SchedelerCode { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }

        [Required(ErrorMessage = "Parameter is required")]
        public List<TaskParameter> Parameters { get;set; }
    }

}