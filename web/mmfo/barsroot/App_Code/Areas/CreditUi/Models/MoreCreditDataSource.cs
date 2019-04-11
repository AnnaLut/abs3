using System;
using System.Linq;
using System.Collections.Generic;

namespace BarsWeb.Areas.CreditUi.Models
{
    public class MoreCreditDataSource
    {
        public List<KeyValuePair<string, string>> TabList { get; set; }
        public Dictionary<string, IQueryable<NdTxtList>> NdTxt { get; set; }

        public MoreCreditDataSource()
        {
            TabList = new List<KeyValuePair<string, string>>();
            NdTxt = new Dictionary<string, IQueryable<NdTxtList>>();
        }
    }
}