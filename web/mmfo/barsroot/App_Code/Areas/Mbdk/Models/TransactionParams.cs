using System;

namespace BarsWeb.Areas.Mbdk.Models
{
    public class TransactionParams
    {
        public decimal ND { get; set; }
        public string CC_ID { get; set; }
        public decimal VIDD { get; set; }
        public string VIDD_NAME { get; set; }
        public decimal TIPD { get; set; }
        public DateTime DATE_END { get; set; }
        public DateTime DATE_U { get; set; }
        public DateTime DATE_V { get; set; }
        public decimal S { get; set; }
        public decimal S_PR { get; set; }
        public string A_NLS { get; set; }
        public decimal A_OSTC { get; set; }
        public decimal A_ACC { get; set; }
        public string A_TIP { get; set; }
        public decimal A_KV { get; set; }
        public string NAME { get; set; }
        public string B_NLS { get; set; }
        public decimal B_OSTC { get; set; }
        public decimal RNK { get; set; }
        public string NMK { get; set; }
        public string NMKK { get; set; }
        public string OKPO { get; set; }
        public string NUM_ND { get; set; }
        public DateTime DAT_ND { get; set; }
        public string MFO { get; set; }
        public string ACCKRED { get; set; }
        public string ACCPERC { get; set; }
        public string MFOKRED { get; set; }
        public string MFOKPERC { get; set; }
        public decimal REFP { get; set; }
        public decimal KPROLOG { get; set; }
        public string SWI_ACC { get; set; }
        public string SWI_BIC { get; set; }
        public decimal SWO_ACC { get; set; }
        public string SWO_BIC { get; set; }
        public string ALT_PARTYB { get; set; }
        public string INTER_B { get; set; }
        public string INT_PARTYA { get; set; }
        public string INT_PARTYB { get; set; }
        public decimal INT_AMOUNT { get; set; }
        public decimal BASEY { get; set; }
        public decimal OSTC { get; set; }
        public string NLS_1819 { get; set; }
        public decimal DIG { get; set; }
        public decimal DIGN { get; set; }
        public string ZAL { get; set; }
    }
}
