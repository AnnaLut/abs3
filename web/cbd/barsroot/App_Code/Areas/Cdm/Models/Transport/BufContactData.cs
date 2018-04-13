using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class BufContactData
    {
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 12, MinimumLength = 6)]
        public string Kf { get; set; }
        
        public int CustId { get; set; }
        
        public string CustName { get; set; }
        
        public int DocType { get; set; }
        
        public string DocSerial { get; set; }
        
        public string DocNumber { get; set; }
        
        public DateTime DocDate { get; set; }

        public string DocIssuer { get; set; }

        public DateTime Birthday { get; set; }

        public string Birthplace { get; set; }

        public string Sex { get; set; }

        public string Adr { get; set; }

        public string Tel { get; set; }

        public string Email { get; set; }

        public string Okpo { get; set; }

        public int Country { get; set; }

        public string Region { get; set; }

        public string Fs { get; set; }

        public string Ved { get; set; }

        public string Sed { get; set; }

        public string Ise { get; set; }

        public string Notes { get; set; }

        public string Maker { get; set; }

        public DateTime MakerDtStamp { get; set; }

    }

}