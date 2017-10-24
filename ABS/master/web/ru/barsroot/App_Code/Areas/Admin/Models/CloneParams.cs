using System;

namespace BarsWeb.Areas.Admin.Models
{
    public class CloneParams
    {
        public string ClonedID { get; set; }
        public string CloneID { get; set; }
        public string ResourceID { get; set; }
        public string Clone { get; set; }
        public string Clear { get; set; }
    }
}
