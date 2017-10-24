using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFUFILE_BLOB
    {
        public decimal id { get; set; }
        public string file_name { get; set; }
        public byte[] file_data { get; set; }
    }
}