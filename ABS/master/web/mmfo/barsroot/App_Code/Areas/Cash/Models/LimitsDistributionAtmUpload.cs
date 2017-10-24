using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models
{
    public class LimitsDistributionAtmUpload
    {
        [Display(Name = "Код банкомату", Order = 1)]
        public string AtmCode { get; set; }
        [Display(Name = "Максимальний ліміт завантаження", Order = 2)]
        public decimal? LimitMaxLoad { get; set; }

        [Display(Name = "Назва РУ", Order = 4)]
        public string MfoName { get; set; }


        [Display(Name = "Назва рахунку", Order = 6)]
        public string Name { get; set; }
    }
}