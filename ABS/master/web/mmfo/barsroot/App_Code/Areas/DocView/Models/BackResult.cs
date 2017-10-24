using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.DocView.Models
{
    /// <summary>
    /// модель результату виконання процедури p_back_web
    /// </summary>
    public class BackResult
    {
        public decimal CODE { get; set; }
        public string TEXT { get; set; }
    }
}
