using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Sep.Models
{
    public class ProccessingModel : IDisposable
    {
        [Display(Name = "Док")]
        public string ND { get; set; }

        [Display(Name = "МФО-А")]
        public string MFOA { get; set; }

        [Display(Name = "МФО-Б")]
        public string MFOB { get; set; }

        [Display(Name = "Дебет")]
        public decimal? S1 { get; set; }


        [Display(Name = "Кредит")]
        public decimal? S0 { get; set; }

        [Display(Name = "ССП")]
        public decimal? PRTY { get; set; }


        [Display(Name = "Призначення")]
        public string NAZN { get; set; }

        [Display(Name = "Файл входу")]
        public string FN_A { get; set; }

        [Display(Name = "Дата вх файлу")]
        public DateTime? DAT_A { get; set; }

        [Display(Name = "Файл виходу")]
        public string FN_B { get; set; }

        [Display(Name = "Дата виходу файлу")]
        public DateTime? DAT_B { get; set; }

        [Display(Name = "SOS")]
        public decimal? SOS { get; set; }
        [Display(Name = "REC")]
        public decimal? REC { get; set; }
        [Display(Name = "REF")]
        public decimal? REF { get; set; }
        [Display(Name = "DIK")]
        public decimal? DIK { get; set; }

        [Display(Name = "DK")]
        public decimal? DK { get; set; }

        [Browsable(false)]
        public decimal? SUBDEB { get; set; }
        [Browsable(false)]
        public decimal? SUMCRED { get; set; }

        [Display(Name = "Наш рахунок")]
        public string NLS { get; set; }
        [Display(Name = "Наш клієнт")]
        public string NAM { get; set; }

        [Display(Name = "Рахунок - А")]
        public string NLSA { get; set; }
        [Display(Name = "Рахунок - Б")]
        public string NLSB { get; set; }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}
