using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Forex.Models
{
    public class ForexPartner
    {
        public int RNK { get; set; }
        public string NAME { get; set; }
        public int? CODCAGENT { get; set; }
        public string BIC { get; set; }
        public string MFO { get; set; }
        public string OKPO { get; set; }
        public int? KOD_B { get; set; }
        public string KOD_G { get; set; }
        public string NLS { get; set; }
        public string BICK { get; set; }
        public string NLSK { get; set; }
        public string ALT_PARTYB { get; set; }
        public string INTERM_B { get; set; }
        public string FIELD_58D { get; set; }
        public string AGRMNT_NUM { get; set; }
        public DateTime? AGRMNT_DATE { get; set; }
        public string TELEXNUM { get; set; }
        public string TXT { get; set; }
    }
}