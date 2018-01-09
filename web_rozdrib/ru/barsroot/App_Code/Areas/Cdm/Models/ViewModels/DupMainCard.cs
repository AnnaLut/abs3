using System;

namespace BarsWeb.Areas.Cdm.Models
{
    public class DupMainCard
    {
        public decimal? M_RNK { get; set; }
        public decimal? QTY_D_RNK { get; set; }
        public decimal? CARD_QUALITY { get; set; }
        public string OKPO { get; set; }
        public string NMK { get; set; }
        public string DOCUMENT { get; set; }
        public DateTime? BIRTH_DAY { get; set; }
        public string BIRTH_DAY_STR
        {
            get { return BIRTH_DAY == null ? "" : BIRTH_DAY.Value.ToString("dd.MM.yyyy"); }
        }
        public decimal? GROUP_ID { get; set; }
        public string PRODUCT { get; set; }
        public DateTime? LAST_MODIFC_DATE { get; set; }
    }
}