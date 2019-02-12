using System;
using System.Collections;
using System.Collections.Generic;

namespace Areas.Finmom.Models
{
    public class FmRulesSaveModel
    {
        public DocumentFmRules Data { get; set; }
        public List<decimal?> Refs { get; set; }
        public string Vids2 { get; set; }
        public string Vids3 { get; set; }
        public bool Bulk { get; set; }
    }
}