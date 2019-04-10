using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.MetaDataAdmin.Models;
/// <summary>
/// Summary description for ColMultiRowParam
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class ColMultiRowParam : ParamMetaInfo
    {
        public ColMultiRowParam()
        {
            this.Kind = "ColMultiRowParam";
            this.IsInput = false;
        }


    }
}