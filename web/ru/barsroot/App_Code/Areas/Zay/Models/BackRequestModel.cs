namespace BarsWeb.Areas.Zay.Models
{
    /// <summary>
    /// Модель запиту на повернення заявки
    /// </summary>
    public class BackRequestModel
    {
        public decimal Mode { get; set; }
        public decimal Id { get; set; }
        public decimal IdBack { get; set; }
        public string Comment { get; set; }
    }
}