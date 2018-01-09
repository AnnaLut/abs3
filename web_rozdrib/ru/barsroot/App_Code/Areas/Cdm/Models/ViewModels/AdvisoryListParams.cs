namespace BarsWeb.Areas.Cdm.Models
{
    public class AdvisoryListParams
    {
        public int GroupId { get; set; }
        public int? SubGroupId { get; set; }

        public string SubGroupStr
        {
            get { return SubGroupId == null ? "null" : SubGroupId.Value.ToString(); }
        }

        public int? SubGroupOrd { get; set; }

        public string SubGroupOrdStr
        {
            get { return SubGroupOrd == null ? "null" : SubGroupOrd.Value.ToString(); }
        }

        public string CustName { get; set; }
        public int? CustRnk { get; set; }
        public string CustInn { get; set; }
        public string CustDocSerial { get; set; }
        public string CustDocNumber { get; set; }
        public string CustQualityGroup { get; set; }
        public decimal? CustQuality { get; set; }
        public int? CustAtrCount { get; set; }
        public string CustBranch { get; set; }
    }
}