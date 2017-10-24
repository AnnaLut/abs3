using System;

namespace Areas.SyncTablesEditor.Models
{
    public class ResponseSTE
    {
        public ResponseSTE()
        {
            Result = "OK";
            ErrorMsg = "";
            ResultMsg = "";
            ResultObj = "";
        }

        public string Result { get; set; }
        public string ErrorMsg { get; set; }
        public string ResultMsg { get; set; }

        public object ResultObj { get; set; }
    }

    public class FileCheckResponse
    {
        public FileCheckResponse()
        {
            Result = "OK";
            ErrorMsg = string.Empty;
        }

        public string Result { get; set; }
        public bool FileExists { get; set; }
        public string FileDate { get; set; }
        public string FileDateFromSql { get; set; }
        public string ErrorMsg { get; set; }
        public string FilePath { get; set; }
    }
}
