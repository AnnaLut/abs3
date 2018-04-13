using System;

namespace BarsWeb.Areas.Admin.Models
{
    public class V_APPADM_APP_REP
    {
        public decimal CODEREP { get; set; }
        public string NAME { get; set; }
        public string ROLENAME { get; set; }
        public decimal? APPROVED { get; set; }
        public decimal? REVOKED { get; set; }
        public decimal? DISABLED { get; set; }
        public DateTime? ADATE1 { get; set; }
        public DateTime? ADETE2 { get; set; }
        public DateTime? RDATE1 { get; set; }
        public DateTime? RDATE2 { get; set; }
    }
}
