namespace BarsWeb.Areas.Admin.Models
{
    /// <summary>
    /// Summary description for USERADM_USERGRP_WEB
    /// </summary>
    public class USERADM_USERGRP_WEB
    {
        public decimal ID { get; set; }
        public decimal IDG { get; set; }
        public string NAME { get; set; }
        public decimal? REVOKED { get; set; }
        public decimal? APPROVE { get; set; }
        public decimal? PR { get; set; }
        public decimal? DEB { get; set; }
        public decimal? CRE { get; set; }
    }
}