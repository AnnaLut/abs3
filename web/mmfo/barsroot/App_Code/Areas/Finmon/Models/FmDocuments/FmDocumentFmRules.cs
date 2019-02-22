using System;

namespace Areas.Finmom.Models
{
    public class DocumentFmRules : DocumentBase
    {
        public long? Id { get; set; }
        public long? RnkA { get; set; }
        public long? RnkB { get; set; }
        public string OkpoA { get; set; }
        public string OkpoB { get; set; }
        public int Kv { get; set; }
        public int Kv2 { get; set; }
        public string OprVid1 { get; set; }
        public string CommVid2 { get; set; }
        public string CommVid3 { get; set; }
        public int MonitorMode { get; set; }
        public string K2Name { get; set; }
        public string K3Name { get; set; }
        public string OurMfo { get; set; }
        public string Md { get; set; }
        public string Fv2Agg { get; set; }
        public string Fv3Agg { get; set; }
        public ClientData ClientA { get; set; }
        public ClientData ClientB { get; set; }
        public long Ref { get; set; }
    }
}