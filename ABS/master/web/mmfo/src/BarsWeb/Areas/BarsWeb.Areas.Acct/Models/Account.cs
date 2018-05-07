using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Acct.Models
{
    public class Account
    {
        [Key]
        public decimal? Id { get; set; }
        public decimal? ClientId { get; set; }
        public decimal? UserId { get; set; }
        public string BankId { get; set; }
        public string Branch { get; set; }
        public string Name { get; set; }
        public string Number { get; set; }
        public decimal? CurrencyId { get; set; }
        public string CurrencyCode { get; set; }
        public string Type { get; set; }
        public decimal? Balance { get; set; }
        public decimal? PlannedBalance { get; set; }
        public DateTime? LastActiveDate { get; set; }
    }
}
