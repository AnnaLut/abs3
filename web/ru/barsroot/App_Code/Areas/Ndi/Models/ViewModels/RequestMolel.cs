using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for RequestMolel
/// </summary>
/// namespace BarsWeb.Areas.Ndi.Models.ViewModels

namespace BarsWeb.Areas.Ndi.Models.ViewModels
{
    public class RequestMolel
    {
        public RequestMolel()
        {
            SaveFilterLocal = true;
            //
            // TODO: Add constructor logic here
            //
        }
        public int? AccessCode { get; set; }
        public string TableName { get; set; }
        public int? Spar { get; set; }
        public string JsonSqlParams { get; set; }
        public int? SparColumn { get; set; }
        public int? NativeTabelId { get; set; }
        public int? NsiTableId { get; set; }
        public int? NsiFuncId { get; set; }
        public string RowParamsNames { get; set; }
        public bool HasCallbackFunction { get; set; }
        public string FilterCode { get; set; }
        public string JsonTblFilterParams { get; set; }
        public int? BaseCodeOper { get; set; }
        public bool GetFiltersOnly { get; set; }
        public bool SaveFilterLocal { get; set; }
        public string  InsertDefParams { get; set; }
        public string Code { get; set; }
    }
}