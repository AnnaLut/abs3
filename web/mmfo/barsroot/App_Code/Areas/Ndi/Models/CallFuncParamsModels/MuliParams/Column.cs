using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CellParam
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{

    public struct Column
    {
  
        [DisplayName("Tag")]
        public string Tag { get; set; }
        [DisplayName("Value")]
        public string Value { get; set; }

    }
}