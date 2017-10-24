using BarsWeb.Areas.Acct.Models.Bases;

namespace BarsWeb.Areas.Acct.Models
{
    public class ReservedAccount : ReservedAccountBase
    {
        public string IsOpen { get; set; }

        public string CustomerCode { get; set; }
        public string CustomerName { get; set; }
    }
}
