using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ColumnDesc
/// </summary>
namespace Bars.CommonModels
{
    public class ColumnDesc
    {
        public ColumnDesc()
        {

        }
        public string Name { get; set; }
        public string Semantic { get; set; }
        public string Type { get; set; }
        public string Format {get;set;}

    }
}

