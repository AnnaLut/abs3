using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.ReserveAccs.Models.Bases
{
    public class ReservedAccountBase
    {
        [Key]
        public decimal? Id { get; set; }
        public string Number { get; set; }
        public string CurrencyId { get; set; }
        public string Name { get; set; }
        public decimal? CustomerId { get; set; }
    }
}
