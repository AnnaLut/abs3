using System;
using System.Linq;
using System.Collections.Generic;

namespace BarsWeb.Areas.CreditUi.Models
{
    public class CustomerList
    {
        public decimal? RNK { get; set; }
        public string NMK { get; set; }
        public string OKPO { get; set; }
        public decimal? CUSTTYPE { get; set; }
        public DateTime? DATE_ON { get; set; }
        public DateTime? DATE_OFF { get; set; }
        public decimal? TGR { get; set; }
        public decimal? C_DST { get; set; }
        public decimal? C_REG { get; set; }
        public string ND { get; set; }
        public decimal? CODCAGENT { get; set; }
        public string NAMEAGENT { get; set; }
        public decimal? COUNTRY { get; set; }
        public decimal? PRINSIDER { get; set; }
        public string NAMEPRINSIDER { get; set; }
        public decimal? STMT { get; set; }
        public string SAB { get; set; }
        public decimal? CRISK { get; set; }
        public string ADR { get; set; }
        public string VED { get; set; }
        public string SED { get; set; }
    }
}