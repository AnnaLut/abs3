using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Wcs.Models
{
    public class QuestRelationResult
    {
        public string CQID { get; set; }
        public string CQ_TYPE_ID { get; set; }
        public bool? DNSHOW_IF { get; set; }
        public string TAB_NAME { get; set; }
        public string SHOW_FIELDS { get; set; }
        public string WHERE_CLAUSE { get; set; }
        public string CALC_RESULT { get; set; }
        public decimal HAS_REL { get; set; }
    }
}