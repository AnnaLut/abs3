using System;

namespace Areas.DownloadXsdScheme.Models
{
    public class FileUploadModel
    {
        public string Date { get; set; }
        public int FileId { get; set; }
        public string FilePath { get; set; }

        public string SelectedFileName { get; set; }
        public string DesiredFileName { get; set; }
    }

    public class ResponseXSD
    {
        public ResponseXSD()
        {
            Result = "OK";
        }
        public string Result { get; set; }
        public string ErrorMsg { get; set; }
    }
}
