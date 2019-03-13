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
    public class RequestModel
    {
        public RequestModel()
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
        /// <summary>
        /// Id колонки в meta_columns. Используется при клике на ячейку. 
        /// </summary>
        public int? SparColumn { get; set; }
        /// <summary>
        /// используется при клике на ячейку(проваливание,выполнение процедуры). Для поиска метаописания по родительской таблице. 
        /// </summary>
        public int? NativeTabelId { get; set; }
        /// <summary>
        /// Tabid в таблице meta_nsifunction
        /// </summary>
        public int? NsiTableId { get; set; }
        /// <summary>
        /// FuncId в таблице meta_nsifunction
        /// </summary>
        public int? NsiFuncId { get; set; }
        /// <summary>
        /// имена параметров
        /// </summary>
        public string RowParamsNames { get; set; }
        public bool HasCallbackFunction { get; set; }
        public string FilterCode { get; set; }
        public string JsonTblFilterParams { get; set; }
        public int? BaseCodeOper { get; set; }
        public bool GetFiltersOnly { get; set; }
        public bool SaveFilterLocal { get; set; }
        public string  InsertDefParams { get; set; }
        public string ExternalParams { get; set; }
        public string Code { get; set; }
        public bool ExternalFuncOnly { get; set; }
    }
}