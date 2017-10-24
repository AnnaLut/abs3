namespace BarsWeb.Areas.Admin.Models
{
    public class Branch
    {
        public decimal BranchId { get; set; }
        public string BranchName { get; set; }
        public bool HasSubBranch { get; set; }
        public decimal? SubBranchId { get; set; }
    }
}