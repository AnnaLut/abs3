using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Async.Models
{
    public class TaskParamViewModel
    {
        public string SchedelerCode { get; set; }
        [Required(ErrorMessage = "Parameter is required")]
        public List<TaskParameter> Parameters { get;set; }
    }

}