using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.MetaDataAdmin.Models;

/// <summary>
/// Summary description for BasePatternGridModel
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class BasePatternGridModel : BaseOutPutPatternModel
    {
    
        public BasePatternGridModel()
        {

        }

        public List<Dictionary<string, object>> Data { get; set; }
        public List<ColumnMetaInfo> MetaColumns { get; set; }
    }
}