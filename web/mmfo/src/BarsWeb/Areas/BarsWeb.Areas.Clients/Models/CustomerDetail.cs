using System.ComponentModel.DataAnnotations;
//using System.ComponentModel.DataAnnotations.Schema;

namespace BarsWeb.Areas.Clients.Models
{
    public class CustomerDetail
    {
        [Key/*, Column(Order = 0)*/]
        [Required]
        [Display(Name = "Идентифікатор клиієнта")]
        public decimal? CustomerId { get; set; }

        //[Key, Column(Order = 1)]
        [Required]
        [Display(Name = "Код")]
        public string Code { get; set; }

        [Display(Name = "Значення")]
        public string Value { get; set; }

        //[Display(Name = "Виконавець заповнення реквізиту")]
        //public string UserId { get; set; }
    }
}
