using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.CreditUi.Models
{
    public class CustomerInfo
    {
        public string EDRPO { get; set; }
        public string EDUCA { get; set; }
        public string MEMB { get; set; }
        public string NAMEW { get; set; }
        public string NREMO { get; set; }
        public string REMO { get; set; }
        public string STAT { get; set; }
        public string TYPEW { get; set; }
        public string Error_Message { get; set; }
        public string REAL6INCOME { get; set; }
        public string NOREAL6INCOME { get; set; }


        public List<Tuple<string, string, string, string>> data_names = new List<Tuple<string, string, string, string>>
        {
            new Tuple<string, string, string, string>("STAT","CIG_D08", "ID", "TXT"),
            new Tuple<string, string, string, string>("EDUCA","EDUCATION", "ID", "NAME"),
            new Tuple<string, string, string, string>("TYPEW","EMPLOYER_TYPE", "ID", "NAME")
        };
    }
}