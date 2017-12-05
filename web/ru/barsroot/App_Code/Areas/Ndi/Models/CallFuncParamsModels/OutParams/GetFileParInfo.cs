using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GetFileInfo
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class GetFileParInfo : OutParamsInfo
    {
        public GetFileParInfo()
        {
            this.Kind = "GET_FILE";
            this.Semantic = "файл";
            this.IsInput = false;
            this.FileForBackend = true;
        }

        public string FileNameGetFrom { get; set; }
        public string SrcFileName { get; set; }
        public string Extention { get; set; }
    }
}