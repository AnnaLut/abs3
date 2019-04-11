using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GetFileInfo
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class GetFileParInfo : GetParamsInfo
    {
        public GetFileParInfo()
        {
            this.Kind = "GET_FILE";
            this.Semantic = "файл";
            this.IsInput = false;
            this.FileForBackend = true;
        }
        public string FileGetFrom { get; set; }
        public string SrcFile { get; set; }
        public string FileNameGetFrom { get; set; }
        public string SrcFileName { get; set; }
        public string Extention { get; set; }

    }
}