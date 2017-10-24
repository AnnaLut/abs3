using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FileObject
/// </summary>

namespace BarsWeb.Areas.TechWorks.Models
{
    public class RequestFileInfo
    {
        public string FileName;        
        public string FileMessage;
        public string FileType
        {
            get
            {
                return Path.GetExtension(FileName);
            }
        }
    }
}
