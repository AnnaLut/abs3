using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Ndi.Models.ViewModels
{
    /// <summary>
    /// Summary description for MainOptionsModel
    /// </summary>
    public class MainOptionsViewModel
    {
        public MainOptionsViewModel()
        {
            //
            // TODO: Add constructor logic here
            //
            this.DefParamModel = new DefParamModel();
        }

        public MainOptionsViewModel Res { get; set; }
        // public string Res { get; set; }
        public DefParamModel DefParamModel { get;set; }
        public int? TableId { get; set; }
        public string TableMode { get; set; }
        public string Conditions { get; set; }
        public string SqlProc { get; set; }
        public string Base64jsonSqlProcParams { get; set; }
        public int? CodeOper { get; set; }
        public int? SParColumn { get; set; }
        public bool IsFuncOnly { get; set; }
        public int? NativeTabelId { get; set; }
        public int? NsiTableId { get; set; }
        public int? NsiFuncId { get; set; }
        public string FilterCode { get; set; }
        public bool HasCallbackFunction { get; set; }
        public bool GetFiltersOnly { get; set; }
        public int? BaseCodeOper { get; set; }
        public bool SaveFilterLocal { get; set; }

        public string Code { get; set; }

    }
}