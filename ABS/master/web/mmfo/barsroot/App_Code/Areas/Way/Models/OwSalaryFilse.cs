using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Way.Models
{
    public class OwSalaryFilse
    {
       public int? ID { get; set; }
       public string FILE_NAME { get; set; }
       public DateTime? FILE_DATE { get; set; }
       public int? FILE_N { get; set; }
       public int? FILE_DEAL { get; set; }
       public string CARD_CODE { get; set; }
       public string BRANCH { get; set; }
       public int? ISP { get; set; }
    }
}