﻿using System;

namespace BarsWeb.Areas.Admin.Models
{
    /// <summary>
    /// АРМи користувача
    /// </summary>
    /// 
    public class V_USERADM_USER_APPS_WEB
    {
        public string CODEAPP { get; set; }
        public string NAME { get; set; }
        public decimal? APPROVED { get; set; }
        public decimal? REVOKED { get; set; }
        public decimal? DISABLED { get; set; }
        public decimal? SUBSTED { get; set; }
        public DateTime? ADATE1 { get; set; }
        public DateTime? ADATE2 { get; set; }
        public DateTime? RDATE1 { get; set; }
        public DateTime? RDATE2 { get; set; }
        public decimal? USERID { get; set; }
    }
}
	