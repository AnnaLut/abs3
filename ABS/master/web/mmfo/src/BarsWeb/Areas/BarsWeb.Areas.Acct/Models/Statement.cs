using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Acct.Models
{
    public class Statement
    {
        public decimal? AccountId { get; set; }
        public string AccountName { get; set; }
        public string AccountNumber { get; set; }
        public decimal? AccountCurrencyId { get; set; }
        public StatementTurnovers Turnovers { get; set; }
        public IQueryable<StatementPayment> PaymentsList { get; set; }

    }
}
