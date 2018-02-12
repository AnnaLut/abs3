namespace BarsWeb.Models
{
    public class UserBranch
    {
        public string BRANCH { get; set; }
        public string NAME { get; set; }
        public decimal? CAN_SELECT { get; set; }
        public bool HAS_CHILD { get; set; }
        public string PARENT_BRANCH { get; set; }
        public string BRANCH_PATH { get; set; }
        public bool SHOW_REGIONAL_NAME { get; set; }
    }
}
