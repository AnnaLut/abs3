using System;

namespace BarsWeb.Areas.OpenCloseDay.Models
{
    public class FormReportParam
    {
        public string kodz { get; set; }
        public string encode { get; set; }
        public decimal? reptype { get; set; }
        public string PriorSqlStatement { get; set; }
        public string FnameSqlStatement { get; set; }
        public DateTime   RepDate { get; set; }
    }                      
}                         