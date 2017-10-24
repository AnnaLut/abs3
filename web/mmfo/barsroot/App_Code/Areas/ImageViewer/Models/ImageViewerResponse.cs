using System;

namespace Areas.ImageViewer.Models
{
    public class ImageViewerResponse
    {
        public decimal RNK { get; set; }
        public string OKPO { get; set; }
        public string NMK { get; set; }
        public string TYPE_IMG { get; set; }
        public DateTime DATE_IMG { get; set; }
        public string ISP { get; set; }
    }
}
