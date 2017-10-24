using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Forex.Models
{
    public class FXUPD
    {
        public decimal? DEAL_TAG { get; set; }
        //public decimal? RNK { get; set; }
        public string NameVA { get; set; }
        public string NameVB { get; set; }
        public decimal? KVA { get; set; }
        public decimal? KVB { get; set; }
        public DateTime? DAT { get; set; }
        public DateTime? DAT_A { get; set; }
        public DateTime? DAT_B { get; set; }
        public decimal? SUMA { get; set; }
        public decimal? SUMB { get; set; }
        public string BICA { get; set; }
        public string BICB { get; set; }
        public string NBA { get; set; }
        public string NBB { get; set; }
        public string SWI_BIC { get; set; }
        public string SWI_ACC { get; set; }
        public string SWO_BIC { get; set; }
        public string SWO_ACC { get; set; }
        public string NBKB { get; set; }
        public string ALT_PARTYB { get; set; }
        public string INTERM_B { get; set; }       
    }
}