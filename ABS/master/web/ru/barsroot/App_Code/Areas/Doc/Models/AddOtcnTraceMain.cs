using System;

namespace BarsWeb.Areas.Doc.Models
{
    public class AddOtcnTraceMain
    {
        public decimal? REF { get; set; }
        public string KODF { get; set; }
        public DateTime? DATF { get; set; }
        public decimal? KV { get; set; }
        public string SumVal { get; set; }
        public decimal? COMM { get; set; } // это референс дочерней проводки, для которой вызовем форму доввода рекв.
    }
}