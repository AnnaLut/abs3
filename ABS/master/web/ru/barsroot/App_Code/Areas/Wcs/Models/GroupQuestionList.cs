using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Wcs.Models
{
    public class GroupQuestionList
    {
        public Int32 BID_ID { get; set; }
        public string SURVEY_ID { get; set; }
        public string GROUP_ID { get; set; }
        public string RECTYPE_ID { get; set; }
        public string NEXT_RECTYPE_ID { get; set; }
        public string QUESTION_ID { get; set; }
        public string QUESTION_NAME { get; set; }
        public string TYPE_ID { get; set; }
        public int IS_CALCABLE { get; set; }
        public int IS_REQUIRED { get; set; }
        public int IS_READONLY { get; set; }
        public int IS_REWRITABLE { get; set; }
        public int IS_CHECKABLE { get; set; }
        public int DNSHOW_IF { get; set; }
        public string VALUE { get; set; }
        public decimal HAS_RELATED { get; set; }
        public QuestionParameters QUEST_PARAMS { get; set; }
        public List<QuestionList> QUEST_LIST_ITEMS { get; set; }
    }
}