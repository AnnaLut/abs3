namespace BarsWeb.Areas.IOData.Models
{
    public class EnableJob
    {
        public string JobName { get; set; }
        public string Description { get; set; }

        public decimal? IsActive { get; set; }
    }
}