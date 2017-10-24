using System;
using System.Collections.Generic;

namespace Areas.RequestsProcessing.Models
{
    /// <summary>
    /// Summary description for DynamicDictResult
    /// </summary>
    public class DynamicDictResult
    {
        public List<Dictionary<string, object>> data { get; set; }
        public List<TableColumns> tableColumns { get; set; }
        public TableSemantic tableSemantic { get; set; }
        public string ID { get; set; }
    }
}
