using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UploadFileName
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class UploadFileName : UploadParamsInfo
    {
        public UploadFileName()
            :base(false)
        {
            this.Semantic = "ім'я файлу";
            this.ColType = "S";
            this.GetFrom = "FILE_NAME";
        }
        
        public bool WithoutExt { get;set;}
    }
}