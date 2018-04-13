using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Zay.Models
{
    public class MandatorySale
    {
        public decimal Rnk { get; set; }
        public string Nmk { get; set; }
        public decimal Acc { get; set; }
        public decimal Kv { get; set; }
        public string Iso { get; set; }
        public string Nls { get; set; }
        public decimal Ref { get; set; }
        public decimal Suma { get; set; }
        public DateTime Vdat { get; set; }
        public DateTime Dat5 { get; set; }
        public decimal Dig { get; set; }
        public decimal Kb { get; set; }
        public decimal Tip { get; set; }
        public decimal Dni { get; set; }
        public bool KbFlag
        {
            get { return Kb >= 1; }
        }
        public decimal S1s { get; set; }
        public decimal S2s { get; set; }
        public decimal Zay { get; set; }
        public decimal Payed { get; set; }
        public bool Selected { get; set; }
    }
}
