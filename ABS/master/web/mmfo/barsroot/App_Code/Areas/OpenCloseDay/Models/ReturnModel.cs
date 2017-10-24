using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.OpenCloseDay.Models
{
    public class ReturnModel
    {
        public List<Function> ListFunc { get; set; }
        public decimal IdGroup { get; set; }
        public string StartDate { get; set; }
        public string Duration { get; set; }
        public string StatusGroup { get; set; }
        public decimal GroupLog { get; set; }
        public ErrorInfo Error { get; set; }
    }

}