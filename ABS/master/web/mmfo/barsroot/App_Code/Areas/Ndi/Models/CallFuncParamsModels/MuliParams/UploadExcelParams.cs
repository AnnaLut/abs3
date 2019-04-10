using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UploadExcelParams
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class UploadExcelParams : MultiRowsParams
    {
        public UploadExcelParams()
        {
            this.Kind = "FROM_UPLOAD_EXCEL";
        }

        public List<FieldProperties> ConvertParamList { get; set; }
        public string ColNameGetFrom { get; internal set; }
    }
}