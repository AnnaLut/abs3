using System;

namespace BarsWeb.Areas.Mbdk.Models
{
    public class NostroPortfolioRow
    {
        public ulong ND { get; set; }
        public ulong? NDI { get; set; }
        public ulong? RNK { get; set; }
        public string NMK { get; set; }
        public short? KV { get; set; }
        public string KV_NAME { get; set; }
        public string NLS { get; set; }
        public ulong ACC { get; set; }
        public string MFO { get; set; }
        public string BIC { get; set; }
        public string CC_ID { get; set; }
        public DateTime? SDATE { get; set; }
        public DateTime? WDATE { get; set; }
        public decimal? LIMIT { get; set; }
        public byte? FIN23 { get; set; }
        public string FIN_NAME { get; set; }
        public byte? OBS23 { get; set; }
        public string OBS_NAME { get; set; }
        public byte? KAT23 { get; set; }
        public string KAT_NAME { get; set; }
        public float? K23 { get; set; }
        public byte? SOS { get; set; }
        public float? IR { get; set; }
        public decimal? SDOG { get; set; }
        public string BRANCH { get; set; }
        public string PROD { get; set; }
        public byte? FIN_351 { get; set; }
        public decimal? PD { get; set; }
        public string NKD { get; set; }
        public string DKD { get; set; }
    }
}