using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


/// <summary>
/// Summary description for MultiParamsDataModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class MultiParamsDataModel : ParamMetaInfo
    {
        public MultiParamsDataModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public List<FieldProperties> InputParams { get; set; }
        public List<MultiRowsParams> RowsData { get; set; }


    }
}