using System;
using System.Collections.Generic;

namespace Areas.RequestsProcessing.Models
{
    public class DynamicRequestParams
    {
        public string ID { get; set; }
        public string VALUE { get; set; }
    }

    /// <summary>
    /// Summary description for DynamicRequestData
    /// </summary>
    public class DynamicRequestData
    {
        public decimal KODZ { get; set; }
        public List<DynamicRequestParams> PARAMS { get; set; }
    }
}
