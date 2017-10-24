using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BarsWeb.Areas.Clients.Models
{
    public class Address
    {
        /*public Address()
        {
            Customer = new Customer();
        }*/
        [Key]
        [Required]
        [Display(Name = "Идентификатор клиента")]
        //[ForeignKey("Customer")]
        public decimal? CustomerId { get; set; } 
        //[ForeignKey("CustomerId")]
        //public virtual Customer Customer { get; set; }

        //[Key, Column(Order = 1)]
        [Required]
        [Display(Name = "Тип адреса")]
        public decimal? TypeId { get; set; }

        [Required]
        [Display(Name = "Код страны")]
        public decimal? CountryId { get; set; }

        [StringLength(20, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Индекс")]
        public string Zip { get; set; }

        [StringLength(30, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Область")]
        public string Domain { get; set; }

        [StringLength(30, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Регион")]
        public string Region { get; set; }

        [StringLength(30, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Населенный пукт")]
        public string Locality { get; set; }

        //[Obsolete]
        //[StringLength(100, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        //[Display(Name = "Адрес (улица, дом, квартира)")]
        //public string AddressStr { get; private set; }

        [Display(Name = "Код адреса")]
        public decimal? TerritoryId { get; set; }

        [Display(Name = "Тип населенного пункта")]
        public int?  LocalityType { get; set; }

        [Display(Name = "Тип улицы")]
        public decimal? StreetType { get; set; }

        [StringLength(100, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Улица")]
        public string Street { get; set; }

        [Display(Name = "Тип дома")]
        public decimal? HomeType { get; set; }

        [StringLength(100, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "№ дома")]
        public string Home { get; set; }

        [Display(Name = "Тип деления дома(если есть)")]
        public decimal? HomepartType { get; set; }

        [StringLength(100, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "№ типа деления дома")]
        public string Homepart { get; set; }

        [Display(Name = "Тип жилого помещения")]
        public decimal? RoomType { get; set; }

        [StringLength(100, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "№ жилого помещения")]
        public string Room { get; set; }
        
    }
}

