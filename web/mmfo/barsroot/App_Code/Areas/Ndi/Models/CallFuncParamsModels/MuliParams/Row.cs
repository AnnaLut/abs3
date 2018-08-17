using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Row
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class Row
    {
        public Row()
        {
            this.Column = new List<Column>();
        }

        public List<Column> Column { get; set; }
    }
}