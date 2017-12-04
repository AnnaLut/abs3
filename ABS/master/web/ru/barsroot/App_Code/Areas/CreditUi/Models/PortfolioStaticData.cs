using System.Collections.Generic;

namespace BarsWeb.Areas.CreditUi.Models
{
    public class PortfolioStaticData
    {
        public string BANKDATE { get; set; }
        public List<object> LIST_VIDD { get; set; }

        public PortfolioStaticData()
        {
            LIST_VIDD = new List<object>();
        }

    }
}