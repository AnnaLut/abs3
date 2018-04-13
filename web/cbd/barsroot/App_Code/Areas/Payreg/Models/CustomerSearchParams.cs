using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Payreg.Models
{
    public class CustomerSearchParams
    {
        [Display(Name = "РНК")]
        public string CustomerId { get; set; }
        [Display(Name = "ОКПО")]
        public string Okpo { get; set; }
        [Display(Name = "Найменування клієнта")]
        public string CustomerName { get; set; }
        public DateTime? BirthDay { get; set; }
        [Display(Name = "Серійний номер документа")]
        public string DocSerial { get; set; }
        [Display(Name = "Номер документа")]
        public string DocNumber { get; set; }
    }
}