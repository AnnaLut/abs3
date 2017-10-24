using System;

namespace BarsWeb.Areas.Wcs.Models
{
    public class ScoringQuestionGuar
    {
        public int? bidId { get; set; }
        public int? garanteeNum { get; set; }
        public string questionId { get; set; }
        public string scoreCust { get; set; }
        public string valueCust { get; set; }
        public int? Ord { get; set; }
    }
}