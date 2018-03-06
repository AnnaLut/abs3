using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.CDO.Corp2.Models
{
    /// <summary>
    /// Summary description for LimitViewModel
    /// </summary>
    public class LimitViewModel
    {
        public decimal USER_ID { get; set; }
        //public int LOGIN_TYPE { get; set; }
        public decimal? DOC_SUM { get; set; }
        public decimal? DOC_CREATED_COUNT { get; set; }
        public decimal? DOC_SENT_COUNT { get; set; }
        public string LIMIT_ID { get; set; }
        public DateTime? DOC_DATE_LIM { get; set; }
    }
    public class LimitDictionaryItem
    {
        public string LIMIT_ID { get; set; }
        //public string DESCRIPTION { get; set; }
        public decimal? DOC_SUM { get; set; }
        public decimal? DOC_CREATED_COUNT { get; set; }
        public decimal? DOC_SENT_COUNT { get; set; }
    }
}