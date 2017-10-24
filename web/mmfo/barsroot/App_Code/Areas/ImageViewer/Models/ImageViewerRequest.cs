using System;

namespace Areas.ImageViewer.Models
{
    public class ImageViewerRequest
    {
        public string TYPE_IMG { get; set; }
        public string DATE_IMG_START { get; set; }
        public string DATE_IMG_END { get; set; }
    }
}
