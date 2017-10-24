using System;

namespace BarsWeb.Areas.Admin.Models
{
    public class V_USERADM_USERS
    {
        public decimal? USER_ID { get; set; }
        public string USER_FIO { get; set; }
        public string USER_LOGNAME { get; set; }
        public decimal? USER_CLSID { get; set; }
        public decimal? USER_TYPE { get; set; }
        public string USER_TABNUM { get; set; }
        public string USER_TABNUM_APPROVE { get; set; }
        public decimal? USER_STATUS { get; set; }
        public decimal? USER_CHECKIN { get; set; }
        public DateTime? USER_CHECKDATE { get; set; }
        public string USER_PAYLOCK { get; set; }
        public DateTime? USER_PAYLOCKDATE { get; set; }
        public decimal? USER_USEARC { get; set; }
        public decimal? USER_USEGTW { get; set; }
        public string USER_WEBPROFILE { get; set; }
        public string USER_BRANCH { get; set; }
        public decimal? USER_APPROVED { get; set; }
        public decimal? USER_ACTIVE { get; set; }
        public string USER_CANSELECTBRANCH { get; set; }
        public string USER_CHANGEPWD { get; set; }
        public decimal? USER_TIP { get; set; }
        public decimal? USER_LICCODE { get; set; }
        public string USER_LICSTATE { get; set; }
        public DateTime? USER_LICEXPIRED { get; set; }
        public decimal? UREC_ID { get; set; }
        public decimal? UREC_STATUS { get; set; }
        public string UREC_PROXY { get; set; }
        public DateTime? UREC_LOCKDATE { get; set; }
        public DateTime? UREC_EXPIREDATE { get; set; }
        public string UREC_TSDEFAULT { get; set; }
        public string UREC_TSTEMP { get; set; }
        public string UREC_PROFILE { get; set; }
        public string UREC_CONSGRP { get; set; }
        public decimal? USER_DISABLE { get; set; }
        public DateTime? USER_RDATE2 { get; set; }
    }
}
