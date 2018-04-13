using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.LimitControl.ViewModels
{
    public class LimitSearchInfo
    {
        /// <summary>
        /// Серия документа
        /// </summary>
        [DisplayName("Серія")]
        [Required(ErrorMessage = "Введіть серію документа")]
        public string Series { get; set; }

        /// <summary>
        /// Номер документа
        /// </summary>
        [DisplayName("Номер")]
        [Required(ErrorMessage = "Введіть номер документа")]
        public string Number { get; set; }
    }
}

//для сумісності з дельта 85
namespace Areas.LimitControl.ViewModels
{
    public class LimitSearchInfo : BarsWeb.Areas.LimitControl.ViewModels.LimitSearchInfo
    {
    }
}