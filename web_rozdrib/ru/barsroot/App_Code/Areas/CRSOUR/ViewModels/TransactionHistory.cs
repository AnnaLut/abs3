using System;
using System.ComponentModel;

namespace BarsWeb.Areas.CRSOUR.ViewModels
{
    /// <summary>
    /// История транзакции
    /// </summary>
    public class TransactionHistory
    {
        [DisplayName("ID транзакції")]
        public int? Id { get; set; }
        
        [DisplayName("Системний час")]
        public DateTime? SysTime { get; set; }

        [DisplayName("Статус обробки транзакції")]
        public string TransactionState { get; set; }

        [DisplayName("Коментар до статусу")]
        public string Comment { get; set; }
    }
}
