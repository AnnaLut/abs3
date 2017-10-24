namespace BarsWeb.Areas.Admin.Models.ListSet
{
    /// <summary>
    /// tbl: LIST_FUNCSET
    /// </summary>
    public class LIST_FUNCSET
    {
        public decimal REC_ID { get; set; }
        public decimal SET_ID { get; set; }
        public decimal FUNC_ID { get; set; }
        public decimal? FUNC_ACTIVITY { get; set; }
        public decimal? FUNC_POSITION { get; set; }
        public string FUNC_COMMENTS { get; set; }
        //public string KF { get; set; }
        public string FUNCNAME { get; set; }
    }
}