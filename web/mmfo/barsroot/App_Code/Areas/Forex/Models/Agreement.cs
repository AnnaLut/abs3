using BarsWeb.Core.Attributes;
using System;

namespace BarsWeb.Areas.Forex.Models
{
    public class Agreement
    {
        public decimal DealType { get; set; }
        public decimal Mode { get; set; }
        public decimal DealTag { get; set; }
        public decimal? SwapTag { get; set; }
        public string NTIK { get; set; }
        public  string  DAT { get; set; }
        public decimal? KVA { get; set; }
        public string DAT_A { get; set; }
        public decimal? SUMA { get; set; }
        public decimal? SUMC { get; set; }
        public decimal? KVB { get; set; }
        public string DAT_B { get; set; }
        public decimal? SUMB { get; set; }
        public decimal? SUMB1 { get; set; }
        public decimal? SUMB2 { get; set; }
        public decimal? RNK { get; set; }
        public string NB { get; set; }
        public string SKB { get; set; }
        public decimal? SWI_REF { get; set; }
        public string SWI_BIC { get; set; }
        public string SWI_ACC { get; set; }
        public string NLSA { get; set; }
        public string SWO_BIC { get; set; }
        public string SWO_ACC { get; set; }
        public string NLSB { get; set; }
        public decimal? B_PAYFLAG { get; set; }
        public string ACRMNT_NUM { get; set; }
        public string ACRMNT_DATE { get; set; }
        public string INTERM_B { get; set; }
        public string ALT_PARTYB { get; set; }
        public string BICB { get; set; }
        public string CURR_BASE { get; set; }
        public string TELEXNUM { get; set; }
        public string KOD_NA { get; set; }
        public string KOD_NB { get; set; }
        public string FIELD_58D { get; set; }
        public bool VN_FLAG { get; set; }
        public string NAZN { get; set; }        
        public bool CB_NoKsB { get; set; }

        public string F092_CODE { get; set; }
        public string FOREX { get; set; }

    }
}
