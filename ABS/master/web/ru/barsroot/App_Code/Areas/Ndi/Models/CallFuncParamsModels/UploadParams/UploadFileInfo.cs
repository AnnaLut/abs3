using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UploadFileInfo
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class UploadFileInfo : UploadParamsInfo
    {
        public UploadFileInfo()
            :base(true)
        {
            this.Kind = "UPLOAD_FILE";
        }
       public void   AddOptionsFromDictionary(Dictionary<string, string> options)
        {
            foreach (var option in options)
            {
                switch (option.Key)
                {
                    case "SEM":
                        Semantic = option.Value;
                        break;
                    case "TYPE":
                        ColType = option.Value;
                        break;
                    case "GET_FROM":
                        GetFrom = option.Value;
                        break;
                }
            }
        }
    }
}