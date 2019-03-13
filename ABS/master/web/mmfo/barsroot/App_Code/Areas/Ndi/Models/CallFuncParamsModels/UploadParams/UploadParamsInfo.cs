using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UploadModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class UploadParamsInfo : ParamMetaInfo
    {
        public UploadParamsInfo()
        {
            this.IsInput = true;
            this.Kind = "UploadParam";
        }
        public UploadParamsInfo(bool isInpup)
            :base(isInpup)
        {
           
        }
        /// <summary>
        /// допустима
        /// </summary>
        public string ExtValid { get; set; }
        //public string GetFrom { get; set; }


       
    }
}