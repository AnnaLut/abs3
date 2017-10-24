using System;

namespace BarsWeb.Areas.Wcs.Models
{
    public class QuestionParameters
    {
        public Decimal? TEXT_LENG_MIN { get; set; }
        public Decimal? TEXT_LENG_MAX { get; set; }
        public string TEXT_VAL_DEFAULT { get; set; }
        public Decimal? TEXT_WIDTH { get; set; }
        public Decimal? TEXT_ROWS { get; set; }
        public Decimal? NMBDEC_VAL_MIN { get; set; }
        public Decimal? NMBDEC_VAL_MAX { get; set; }
        public Decimal? NMBDEC_VAL_DEFAULT { get; set; }
        public DateTime? DAT_VAL_MIN { get; set; }
        public DateTime? DAT_VAL_MAX { get; set; }
        public DateTime? DAT_VAL_DEFAULT { get; set; }
        public Decimal? LIST_SID_DEFAULT { get; set; }
        public string REFER_SID_DEFAULT { get; set; }
        public string TAB_NAME { get; set; }
        public string KEY_FIELD { get; set; }
        public string SEMANTIC_FIELD { get; set; }
        public string SHOW_FIELDS { get; set; }
        public string WHERE_CLAUSE { get; set; }
        public Decimal? BOOL_VAL_DEFAULT { get; set; }
    }
}