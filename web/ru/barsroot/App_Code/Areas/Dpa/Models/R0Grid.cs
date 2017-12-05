using System;

namespace BarsWeb.Areas.Dpa.Models
{
    public class R0Grid
    {
        public decimal N { get; set; }
        public string MFO { get; set; }
        public string OKPO { get; set; }
        public decimal? RTYPE { get; set; }
        public string NMKK { get; set; }
        public DateTime ODATE { get; set; }
        public string NLS { get; set; }
        public decimal KV { get; set; }
        public int RESID { get; set; }
        public DateTime DAT_IN_DPA { get; set; }
        public DateTime DAT_ACC_DPA { get; set; }
        public int ID_PR { get; set; }
        public int ID_DPA { get; set; }
        public int ID_DPS { get; set; }
        public string ID_REC { get; set; }
        public string FN_F { get; set; }
        public int N_F { get; set; }
        public string ERR { get; set; }
        public string COM { get; set; }
    }
}