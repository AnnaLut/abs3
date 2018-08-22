using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MultiParamsGridModel
/// </summary>

namespace BarsWeb.Areas.Ndi.Models
{
    public class MultiParamsGridDataModel : ParamMetaInfo
    {
        public MultiParamsGridDataModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public List<FieldProperties> InputParams { get; set; }
        public List<MultiRowsParams> RowsData { get; set; }


    }
}