using System.ComponentModel;

namespace BarsWeb.Areas.CRSOUR.ViewModels
{
    /// <summary>
    /// Заявка
    /// </summary>
    public class ComplexClaim
    {
        [DisplayName("ID заявки")]
        public long Id { get; set; }

        [DisplayName("МФО")]
        public string Mfo { get; set; }
        
        [DisplayName("Номер угоди")]
        public string DealNumber { get; set; }
        
        [DisplayName("Тип заявки")]
        public string Type { get; set; }

        [DisplayName("ID типу заявки")]
        public int? ClaimTypeId { get; set; }
        
        [DisplayName("Статус обробки заявки")]
        public string State { get; set; }
        
        [DisplayName("Коментар до статусу заявки")]
        public string Comment { get; set; }
    }
}
