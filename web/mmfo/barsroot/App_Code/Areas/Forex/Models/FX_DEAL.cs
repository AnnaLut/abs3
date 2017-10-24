using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Forex.Models
{
    public class FX_DEAL
    {     
        public string NTIK { get; set; }
        public decimal? KVA { get; set; }
        public decimal? SUMA { get; set; }
        public decimal? KVB { get; set; }
        public decimal? SUMB { get; set; }
        public string KODB { get; set; }
        public string SWI_BIC { get; set; }
        public string SWI_ACC { get; set; }
        public string SWO_BIC { get; set; }
        public string SWO_ACC { get; set; }        
        public string AGRMNT_NUM { get; set; }
        public DateTime? AGRMNT_DATE { get; set; }
        public string BICB { get; set; }
        public string INTERM_B { get; set; }
        public string ALT_PARTYB { get; set; }
        public string TELEXNUM { get; set; }
        public string FIELD_58D { get; set; }        
        public decimal? SWAP_TAG { get; set; }
        public decimal? RNK { get; set; }
        public string KOD_NA { get; set; }
        public string KOD_NB { get; set; }

    }
}
