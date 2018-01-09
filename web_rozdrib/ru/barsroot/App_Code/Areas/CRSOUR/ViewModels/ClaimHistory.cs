using System;
using System.ComponentModel;

namespace BarsWeb.Areas.CRSOUR.ViewModels
{
    /// <summary>
    /// История обработки заявки
    /// </summary>
    public class ClaimHistory
    {
        [DisplayName("ID заявки")]
        public int? Id { get; set; }
        
        [DisplayName("Системний час")]
        public DateTime? SysTime { get; set; }

        [DisplayName("Статус обробки заявки")]
        public string ClaimState { get; set; }

        [DisplayName("Коментар до статусу")]
        public string Comment { get; set; }
    }
}
