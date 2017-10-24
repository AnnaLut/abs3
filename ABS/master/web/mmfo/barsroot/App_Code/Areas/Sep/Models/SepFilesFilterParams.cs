namespace BarsWeb.Areas.Sep.Models
{
    public class SepFilesFilterParams
    {
        public string FileNameMask { get; set; }
        public bool IsMatched { get; set; }
        public bool Incoming { get; set; }
        public string FileDate { get; set; }
        public string Currency { get; set; }
    }
}
