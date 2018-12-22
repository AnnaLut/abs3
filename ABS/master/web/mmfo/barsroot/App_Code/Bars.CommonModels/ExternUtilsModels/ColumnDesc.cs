using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Description of columns for DB, or web.
/// </summary>

namespace Bars.CommonModels
{
    [Serializable]
    public class ColumnDesc
    {
        public ColumnDesc()
        {

        }

        public string Name { get; set; }
        public string Semantic { get; set; }
        public string Type { get; set; }
        public string Format { get; set; }
        public  string Value { get; set; }
        public bool AllowDBNull { get; set; }

        public int? ColumnSize { get; set; }

        
    }

}
