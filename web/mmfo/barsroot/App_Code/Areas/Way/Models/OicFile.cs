using System;

namespace BarsWeb.Areas.Way.Models
{
    public class OicFile
    {
        public decimal? ID { get; set; }
        public string FILE_TYPE { get; set; }
        public string FILE_NAME { get; set; }
        public DateTime? FILE_DATE { get; set; }
        public decimal? FILE_STATUS { get; set; }
        public string ERR_TEXT { get; set; }
        public decimal? FILE_N { get; set; }
        public decimal? N_OPL { get; set; }
        public decimal? N_ERR { get; set; }
        public decimal? N_DEL { get; set; }
        public decimal? N_ABS { get; set; }
    }
}