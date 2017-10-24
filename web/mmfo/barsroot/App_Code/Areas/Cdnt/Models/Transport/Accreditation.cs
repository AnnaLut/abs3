 // ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.Cdnt.Models.Transport
{
    public class Accreditation
    {
        public int Id { get; set; }
        public int? AccreditationTypeId { get; set; }
        public string StartDate { get; set; }
        public string ExpiryDate { get; set; }
        public string CloseDate { get; set; }
        public string AccountNumber { get; set; }
        public string AccountMfo { get; set; }
        public int? StateId { get; set; } 
    }
}