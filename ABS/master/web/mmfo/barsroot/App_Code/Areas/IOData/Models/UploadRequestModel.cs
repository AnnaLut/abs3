using System;

namespace BarsWeb.Areas.IOData.Models
{
    public class UploadRequestModel
    {
        public string FileCode { get; set; }
        public string JobName { get; set; }
        public DateTime JobDate { get; set; }
    }
}