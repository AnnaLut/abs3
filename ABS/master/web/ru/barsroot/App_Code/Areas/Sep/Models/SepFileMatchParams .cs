namespace BarsWeb.Areas.Sep.Models
{
    public class SepFileMatchParams 
    {
        public string FileName { get; set; }
        public string FileCreated { get; set; }
        public bool Incoming { get; set; }
        public decimal? DebitSum { get; set; }
        public decimal? KreditSum { get; set; }
        public decimal? RowCount { get; set; }
    }
}