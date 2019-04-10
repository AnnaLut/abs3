using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UploadModel
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class UploadParamsInfo : ParamMetaInfo
    {
        public UploadParamsInfo()
        {
            this.IsInput = true;
        }
        public UploadParamsInfo(bool isInpup)
            :base(isInpup)
        {
           
        }
        //public string GetFrom { get; set; }


       
    }
}