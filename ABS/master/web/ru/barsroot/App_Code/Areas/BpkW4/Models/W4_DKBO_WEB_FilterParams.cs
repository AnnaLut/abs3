using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.BpkW4.Models
{
    public class W4_DKBO_WEB_FilterParams
    { 
        public string list_code { get; set; }
        public string submitButton { get; set; }
        // search by customer params set:
        public string CUSTOMER_NAME { get; set; }
        public string CUSTOMER_NAME_HIDDEN { get; set; }
        public string CUSTOMER_ZKPO { get; set; }

        public string PASS_SERIAL { get; set; }

        public string PASS_NUMBER { get; set; }

        public string CUSTOMER_BDAY { get; set; }
      
        public string CUSTOMER_ID { get; set; } 

        public string CARD_ACCs { get; set; }
        public string CUSTOMER_ID_HIDDEN { get; set; }
        public string new_dkbo_id { get; set; }

        public string serviceInfo { get; set; }

        public decimal? DEAL_ID { get; set; }
         
    }
}