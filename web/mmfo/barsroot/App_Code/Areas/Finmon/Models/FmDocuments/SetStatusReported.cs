using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;

namespace Areas.Finmom.Models
{
    public class SetStatusReported
    {
        public List<Document> Documents { get; set; }
        public string Comment { get; set; }
    }
}