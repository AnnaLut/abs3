using System;
namespace BarsWeb.Areas.Payreg.Models
{
    public class RegularSbonWithoutContractOrder
    {
        public int? Id { get; set; }
        public int PayerAccountId { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? StopDate { get; set; }
        public int PaymentFrequency { get; set; }
        public int HolidayShift { get; set; }
        public int ProviderId { get; set; }        
        public string PersonalAccount { get; set; }
        public decimal RegularAmount { get; set; }
        public string ExtraAttributes { get; set; }       
    }
}