using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.BpkW4.Models
{
    public class W4_DKBO_QUESTION_Result
    {
        public int? RN { get; set; }
        public int? LIST_ID { get; set; }
        public string QUEST_GROUP { get; set; }
        public string QUEST_NAME { get; set; }
        public string QUEST_CODE { get; set; }
        public string QUEST_TYPE { get; set; }
        public string LIST_CODE { get; set; }
        public string LIST_NAME { get; set; }
        public string ATTRIBUTE_VALUE { get; set;}
    }
}
