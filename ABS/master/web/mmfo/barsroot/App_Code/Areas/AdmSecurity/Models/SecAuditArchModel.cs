using System;

namespace BarsWeb.Areas.AdmSecurity.Models
{
    /// <summary>
    /// SEC_AUDIT_ARCH tbl model
    /// </summary>
    public class SecAuditArchModel
    {
        public decimal? REC_ID { get; set; }
        public decimal? REC_UID { get; set; }
        public string REC_UNAME { get; set; }
        public string REC_UPROXY { get; set; }
        public DateTime? REC_DATE { get; set; }
        public DateTime? REC_BDATE { get; set; }
        public string REC_TYPE { get; set; }
        public string REC_MODULE { get; set; }
        public string REC_MESSAGE { get; set; }
        public string MACHINE { get; set; }
        public string REC_OBJECT { get; set; }
        public decimal? REC_USERID { get; set; }
        public string BRANCH { get; set; }
        public string REC_STACK { get; set; }
        public string CLIENT_IDENTIFIER { get; set; }
    }
}