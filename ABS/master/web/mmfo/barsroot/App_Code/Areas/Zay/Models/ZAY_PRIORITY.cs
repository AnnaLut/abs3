namespace BarsWeb.Areas.Zay.Models
{
    /// <summary>
    /// ZAY_PRIORITY: Приоритеты заявок клиентов на покупку-продажу валюты
    /// </summary>
    public class ZAY_PRIORITY
    {
        public decimal ID { get; set; }
        public string NAME { get; set; }
        public decimal VERIFY { get; set; }
        public decimal ACTIVE { get; set; }
    }
}