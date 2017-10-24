using System;

namespace BarsWeb.Areas.Wcs.Models
{
    public class ParamsSetAnswers
    {
        public decimal bidId { get; set; }
        public string groupId { get; set; }
        public string questionId { get; set; }
        public string surveyId { get; set; }
        public string value { get; set; }
    }
}