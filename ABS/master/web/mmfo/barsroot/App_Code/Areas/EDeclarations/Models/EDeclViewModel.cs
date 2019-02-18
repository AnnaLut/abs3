using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Linq;
using System.Web;

namespace Areas.EDeclarations.Models
{
    public class EDeclViewModel
    {
        [Required]
        [StringLength(10)]
        public String Inn { get; set; }

        public DateTime DateOfBirth { get; set; }

        [Required]
        public String Fullname { get; set; }

        public Int32 PersonDocType { get; set; }
        public String PersonDocSerial { get; set; }

        [Required]
        public String PersonDocNumber { get; set; }
        public DateTime DateFrom { get; set; }
        public DateTime DateTo { get; set; }
        public String Rnk { get; set; }
        public Int32? DeclId { get; set; }
    }
}