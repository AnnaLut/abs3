using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models
{
    public class LimitsDistributionAtmUpload
    {
        [Display(Name = "Код банкомату", Order = 1)]
        public string AtmCode { get; set; }
        [Display(Name = "Максимальний ліміт завантаження", Order = 2)]
        public decimal? LimitMaxLoad { get; set; }

    }
}