using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.Areas.DptSocial.Models
{
    public class Result
    {
        public Result(List<ProcessFileResult> error_files, Int32 file_amnt)
        {
            ERRORS_FILES = error_files;
            FILE_AMNT = file_amnt;
        }
        public List<ProcessFileResult> ERRORS_FILES { get; set; }
        public Int32 FILE_AMNT { get; set; }
    }
}