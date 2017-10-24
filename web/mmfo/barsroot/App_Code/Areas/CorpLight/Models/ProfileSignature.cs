using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.CorpLight.Models
{
    public class ProfileSignature
    {
        public ProfileSignature()
        {           
        }

        [Key]
        public decimal? VisaId { get; set; }
        [Key]
        public decimal? CustomerId { get; set; }
        public string KeyId { get; set; }
        public string UserId { get; set; }
        public DateTime? VisaDate { get; set; }
        public string Signature { get; set; }

    }
}
