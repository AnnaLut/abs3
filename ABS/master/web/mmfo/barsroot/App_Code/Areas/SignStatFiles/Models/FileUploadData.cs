using System;

namespace BarsWeb.Areas.SignStatFiles.Models
{
    public class FileUploadData
    {
        public string Name { get; set; }
        public byte[] Content { get; set; }
        public string Hash { get; set; }
        public string Extension { get; set; }
    }
}
