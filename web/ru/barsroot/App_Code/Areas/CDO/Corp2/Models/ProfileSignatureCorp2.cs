using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.CDO.Corp2.Models
{
    public class ProfileSignatureCorp2
    {
        public decimal UserId { get; set; }
        public decimal VisaId { get; set; }
        public DateTime? VisaDate { get; set; }
        public string KeyId { get; set; }
        public string Signature { get; set; }

    }
}
