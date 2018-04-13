using System;
using System.ComponentModel.DataAnnotations;
using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Models.ViewModels
{
    public class V_CLIM_ACCOUNT_LIMIT_VM : V_CLIM_ACCOUNT_LIMIT_MD
    {
        public String CHECK_FLAG { get; set; }

        public String ACC_OB22 { get; set; }
        public DateTime? ACC_OPEN_DATE { get; set; }

        [Display(Name = "Ліміт порушений")]
        public decimal? LIMIT_VIOLATION { get; set; }

        public decimal? ACC_BALANCE { get; set; }
    }

}