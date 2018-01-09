using System.Collections.Generic;

namespace BarsWeb.Areas.Cdm.Models
{
    public class DropDownList
    {
        public string ATTR_NAME { get; set; }
        public string DESCR { get; set; }
        public List<DropDownItem> DROPDOWN_DATA { get; set; }
    }
}