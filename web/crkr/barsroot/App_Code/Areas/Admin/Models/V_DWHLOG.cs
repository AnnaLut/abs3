using System;

namespace BarsWeb.Areas.Admin.Models
{
    public class V_DWHLOG
    {
        public decimal PACKAGE_ID { get; set; }
        public string STATUS { get; set; }
        public string ERRORDESCRIPTION { get; set; }
        public string PACKAGE_TYPE { get; set; }
        public string RECIEVED_DATE { get; set; }
        public string BANK_DATE { get; set; }
        
    }
}
