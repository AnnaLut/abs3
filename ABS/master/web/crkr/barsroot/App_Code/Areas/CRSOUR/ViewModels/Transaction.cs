using System.ComponentModel;

namespace BarsWeb.Areas.CRSOUR.ViewModels
{
    /// <summary>
    /// История обработки заявки
    /// </summary>
    public class Transaction
    {
        [DisplayName("ID транзакції")]
        public decimal? TransactionId { get; set; }

        [DisplayName("ID заявки")]
        public decimal? ClaimId { get; set; }

        [DisplayName("Тип заявки")]
        public string ClaimType { get; set; }

        [DisplayName("ID типу заявки")]
        public int? ClaimTypeId { get; set; }

        [DisplayName("Код МФО адресата транзакції")]
        public string MfoCode { get; set; }

        [DisplayName("Тип транзакції")]
        public string TransactionType { get; set; }

        [DisplayName("ID типу транзакції")]
        public int? TransactionTypeId { get; set; }

        [DisplayName("Об’єкт")]
        public string Object { get; set; }

        [DisplayName("Пріоритет обробки")]
        public int? Priority { get; set; }

        [DisplayName("Кількість невдалих спроб")]
        public int? FailCounter { get; set; }

        [DisplayName("Статус обробки транзакції")]
        public string TransactionState { get; set; }

        [DisplayName("Коментар до статусу транзакції")]
        public string Comment { get; set; }
    }
}
