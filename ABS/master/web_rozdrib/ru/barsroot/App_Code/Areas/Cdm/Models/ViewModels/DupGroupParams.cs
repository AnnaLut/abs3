namespace BarsWeb.Areas.Cdm.Models
{
    public class DupGroupParams
    {
        public decimal? M_rnk { get; set; }
        public string Nmk { get; set; }
        public string Okpo { get; set; }
        public string Document { get; set; }
        public decimal? Card_Quality { get; set; }
        public string Branch { get; set; }
        public bool IsParamsEmpty
        {
            get
            {
                return M_rnk == null && string.IsNullOrEmpty(Nmk) && string.IsNullOrEmpty(Okpo) &&
                       string.IsNullOrEmpty(Document.Trim()) && (Card_Quality == null || Card_Quality >= 100) &&
                       string.IsNullOrEmpty(Branch);
            }
        }
    }
}