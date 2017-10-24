using System;

namespace BarsWeb.Areas.BpkW4.Models
{
    public class FileModel
    {
        public decimal? ID { get; set; }
        public string FILE_NAME { get; set; }
        public DateTime FILE_DATE { get; set; }
        public decimal? FILE_N { get; set; }
        public string FILE_STATUS { get; set; }
        public string ERR_TEXT { get; set; }
    }
}