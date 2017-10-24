using System.Collections.Generic;

namespace BarsWeb.Areas.LimitControl.ViewModels
{
    public class DocStatus
    {
        public LimitSearchInfo SearchInfo { get; set; }
        public IEnumerable<LcsServices.Operation> Operations { get; set; }
        public IEnumerable<LcsServices.Transaction> Transactions { get; set; }
    }
}

namespace Areas.LimitControl.ViewModels
{
    public class DocStatus : BarsWeb.Areas.LimitControl.ViewModels.DocStatus
    {
    }
}
