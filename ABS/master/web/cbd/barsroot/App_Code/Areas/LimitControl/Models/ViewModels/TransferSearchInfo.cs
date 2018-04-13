using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.LimitControl.ViewModels
{
    public class TransferSearchInfo
    {
        /// <summary>
        /// Серия документа
        /// </summary>
        [DisplayName("Серія")]
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
    public class TransferSearchInfo : BarsWeb.Areas.LimitControl.ViewModels.TransferSearchInfo
    {
    }
}