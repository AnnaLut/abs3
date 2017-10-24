using System;

namespace Bars.Areas.DptSocial.Models
{
    public class ProcessFileResult
    {
        public ProcessFileResult(String file_name, String error)
        {
            FILE_NAME = file_name;
            ERORR = error;
        }
        public String FILE_NAME { get; set; }
        public String ERORR { get; set; }
    }
}
