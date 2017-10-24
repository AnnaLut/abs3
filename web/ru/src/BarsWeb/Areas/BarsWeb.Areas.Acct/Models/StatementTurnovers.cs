using System;

namespace BarsWeb.Areas.Acct.Models
{
    public class StatementTurnovers
    {
        public decimal? TurnoverDebit { get; set; }
        public decimal? TurnoverCredit { get; set; }
        public decimal? InBalance { get; set; }
        public decimal? OutBalance { get; set; }
        public DateTime? MinDate { get; set; }
        public DateTime? MaxDate { get; set; }
    }
}
