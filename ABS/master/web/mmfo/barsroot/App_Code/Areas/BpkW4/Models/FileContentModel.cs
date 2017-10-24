using System;

namespace BarsWeb.Areas.BpkW4.Models
{
    public class FileContentModel
    {
        public decimal? ID { get; set; }
        public decimal? FILEID { get; set; }
        public decimal? IDN { get; set; }
        public decimal? RNK { get; set; }
        public string NLS { get; set; }
        public string BRANCH { get; set; }
        public int STATE { get; set; }
        public string MSG { get; set; }
    }
}