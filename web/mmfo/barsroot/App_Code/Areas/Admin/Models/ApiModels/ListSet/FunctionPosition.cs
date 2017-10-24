namespace BarsWeb.Areas.Admin.Models.ApiModels.ListSet
{
    /// <summary>
    /// Модель оновлення позиції функції
    /// </summary>
    public class FunctionPosition
    {
        public decimal setId { get; set; }
        public decimal functionId { get; set; }
        public decimal position { get; set; }
    }
}