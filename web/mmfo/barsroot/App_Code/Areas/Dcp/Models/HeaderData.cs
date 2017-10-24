using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Dcp.Models
{
    public class HeaderData
    {
        public string FN { get; set; }
        public DateTime DATF { get; set; }
        public int INFO_LENGTH { get; set; }
        public decimal NUMO { get; set; }
        public decimal S { get; set; }
        public string ECP { get; set; }
        public string ID_ECP { get; set; }
        public string Reserve { get; set; }
    }
}