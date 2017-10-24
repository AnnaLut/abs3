using System;
using System.Linq;
using System.Collections.Generic;

namespace BarsWeb.Areas.Wcs.Models
{
    public class ScoringQuestion
    {
        public int? bidId { get; set; }
        public string questionId { get; set; }
        public string Name { get; set; }
        public string scoreCust { get; set; }
        public string valueCust { get; set; }
        public int? Ord { get; set; }
        public IQueryable<ScoringQuestionGuar> listGuarant { get; set; }
    }
}