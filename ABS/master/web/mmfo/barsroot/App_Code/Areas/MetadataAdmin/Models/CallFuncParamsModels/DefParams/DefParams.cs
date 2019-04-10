using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DefParams
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class DefParams : ParamMetaInfo
    {
        public DefParams()
        {
            ListDefParams = new List<DefParam>();
        }

        public IList<DefParam> ListDefParams { get; set; }
    }
}