using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Account
/// </summary>
/// 
namespace BarsWeb.Areas.Mbdk.Models
{
    public class ContractorParams
    {
        public string nls { get; set; }
        public string nlsn { get; set; }

        public string swo_bic { get; set; }
        public string swo_acc { get; set; }
        public string swo_alt { get; set; }
        public string interm_b { get; set; }
        public string field_58d { get; set; }        
    }
}