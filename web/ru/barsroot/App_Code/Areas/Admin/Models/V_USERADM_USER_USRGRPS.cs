﻿using System;

namespace BarsWeb.Areas.Admin.Models
{
    /// <summary>
    /// Групи користувачів обраного користувача
    /// </summary>
    public class V_USERADM_USER_USRGRPS
    {
        public decimal IDG { get; set; }
        public string NAME { get; set; }
        public decimal? SEC_SEL { get; set; }
        public decimal? SEC_DEB { get; set; }
        public decimal? SEC_CRE { get; set; }
        public decimal? APPROVED { get; set; }
        public decimal? REVOKED { get; set; }
        public decimal? DISABLED { get; set; }
        public decimal? SUBSTED { get; set; }
        public DateTime? ADATE1 { get; set; }
        public DateTime? ADATE2 { get; set; }
        public DateTime? RDATE1 { get; set; }
        public DateTime? RDATE2 { get; set; }
    }
}
