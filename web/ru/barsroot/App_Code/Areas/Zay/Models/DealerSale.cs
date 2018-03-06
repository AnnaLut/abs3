using System;

namespace BarsWeb.Areas.Zay.Models
{
    public class DealerSale
    {
        public decimal? ID { get; set; }
        public string MFO { get; set; }
        public string MFO_NAME { get; set; }
        public decimal? REQ_ID { get; set; }
        public decimal? DK { get; set; }
        public decimal? SOS { get; set; }
        public decimal? SOS_DECODED { get; set; }
        public decimal? KV2 { get; set; }
        public string LCV { get; set; }
        public decimal? DIG { get; set; }
        public decimal? KV_CONV { get; set; }
        public DateTime? FDAT { get; set; }
        public decimal? KURS_Z { get; set; }
        public DateTime? VDATE { get; set; }
        public decimal? KURS_F { get; set; }
        public decimal? S2 { get; set; }
        public decimal? VIZA { get; set; }
        public DateTime? DATZ { get; set; }
        public decimal? RNK { get; set; }
        public string NMK { get; set; }
        public string CUST_BRANCH { get; set; }
        public decimal? PRIORITY { get; set; }
        public string PRIORNAME { get; set; }
        public string AIM_NAME { get; set; }
        public string COMM { get; set; }
        public string KURS_KL { get; set; }
        public decimal? PRIORVERIFY_VIZA { get; set; }
        public decimal? CLOSE_TYPE { get; set; }
        public string CLOSE_TYPE_NAME { get; set; }
        public string STATE { get; set; }
        public DateTime? START_TIME { get; set; }
        public decimal? REQ_TYPE { get; set; }
        public DateTime? VDATE_PLAN { get; set; }
        public decimal? S2_EQV { get; set; }
        public decimal OBZ { get; set; }
    }
}