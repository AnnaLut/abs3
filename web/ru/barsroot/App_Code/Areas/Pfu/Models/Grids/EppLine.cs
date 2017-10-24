using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class EppLine
    {
        public string EPP_NUMBER { get; set; }
        public string TAX_REGISTRATION_NUMBER { get; set; }
        public string PHONE_NUMBER { get; set; }
        public string DOCUMENT_ID { get; set; }
        public string ACCOUNT_NUMBER { get; set; }
        public string LAST_NAME { get; set; }
        public decimal? RNK { get; set; }
        public string FIRST_NAME { get; set; }
        public string MIDDLE_NAME { get; set; }
        public string PENS_TYPE { get; set; }
        public string BRANCH { get; set; }
        public decimal? STATE_ID { get; set; }
        public string ERR_TAG { get; set; }
    }
}