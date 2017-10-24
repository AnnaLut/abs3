namespace BarsWeb.Areas.Admin.Models
{
    /// <summary>
    /// tbl: OPERLIST
    /// </summary>
    public class OPERLIST
    {
        public decimal CODEOPER { get; set; }
        public string NAME { get; set; }
        public string DLGNAME { get; set; }
        public string FUNCNAME { get; set; }
        public string SEMANTIC { get; set; }
        public decimal? RUNABLE { get; set; }
        public decimal? PARENTID { get; set; }
        public string ROLENAME { get; set; }
        public decimal FRONTEND { get; set; }
        public decimal USEARC { get; set; }
        public string ID_MODULE { get; set; }
    }
}