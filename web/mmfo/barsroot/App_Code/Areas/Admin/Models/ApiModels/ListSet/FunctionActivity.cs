namespace BarsWeb.Areas.Admin.Models.ApiModels.ListSet
{
    /// <summary>
    /// модель оновлення активності функції (та коментарія)
    /// </summary>
    public class FunctionActivity
    {
        public decimal setId { get; set; }
        public decimal functionId { get; set; }
        public decimal activityType { get; set; }
        public string comments { get; set; }
    }
}