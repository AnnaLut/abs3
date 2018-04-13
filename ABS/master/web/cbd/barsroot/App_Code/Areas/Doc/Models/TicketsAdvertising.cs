using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Doc.Models
{
    public class TicketsAdvertising
    {
        [Display(Name = "Ід реклами")]
        public decimal? Id { get; set; }

        [Display(Name = "Назва рекламного блоку")]
        public String Name { get; set; }

        [Display(Name = "Дата початку дії")]
        public DateTime? DateBegin { get; set; }

        [Display(Name = "Дата закінчення дії")]
        public DateTime? DateEnd { get; set; }

        [Display(Name = "Признак активності")]
        public String IsActive{ get; set; }

        [Display(Name = "Тіло самої реклами в HTML")]
        public String DataBodyHtml { get; set; }

        [Display(Name = "Тіло самої реклами в вигляді картинки")]
        public Byte[] DataBody { get; set; }

        [Display(Name = "Довільний опис")]
        public String Description { get; set; }

        //[Display(Name = "Користувач для якого виводити рекламу")]
        //public Decimal? UserId { get; set; }

        //[Display(Name = "Відділення для якого виводити рекламу, діє по дереву ієрархії")]
        //public String Branch { get; set; }

        [Display(Name = "Список відділень для яких виводити рекламу")]
        public IEnumerable<string> BranchList { get; set; }

        [Display(Name = "Список операцій для яких виводити рекламу")]
        public String TransactionCodeList { get; set; }

        [Display(Name = "Признак реклами по зхамовчуванню")]
        public String IsDefault { get; set; }

        [Display(Name = "Код філіала")]
        public String Kf { get; set; }
        
        [Display(Name = "Ширина блоку")]
        public int? Width { get; set; }

        [Display(Name = "Висота блоку")]
        public int? Height { get; set; }
        
        [Display(Name = "Тип (HTML/Image)")]
        public int Type { get; set; }
    }
}
