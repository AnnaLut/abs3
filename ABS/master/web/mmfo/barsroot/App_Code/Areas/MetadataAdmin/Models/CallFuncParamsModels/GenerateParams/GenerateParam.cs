using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GenerateParam
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class GenerateParamInfo : ParamMetaInfo
    {
        public GenerateParamInfo()
        {
            
        }
        public string PostFix { get; set; }

        public string SrcValue { get; set; }
    }
}