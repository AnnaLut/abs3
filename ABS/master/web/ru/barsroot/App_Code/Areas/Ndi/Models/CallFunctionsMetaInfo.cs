﻿
using System.Collections.Generic;
namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Информация о процедурах, которые могут быть вызваны из справочников (META_NSIFUNCTION)
    /// </summary>
    public class CallFunctionMetaInfo
    {
        public CallFunctionMetaInfo(string webFormName, int colId,int tableId)
        {
            this.WEB_FORM_NAME = webFormName;
            this.TABID = tableId;
        }

        public CallFunctionMetaInfo ()
        {

        }
        public decimal? TABID { get; set; }
        public int? ColumnId { get; set; }
        public decimal? ICON_ID { get; set; }
        public string TableName { get; set; }

        public bool isFuncOnly = true;
        public string BtnDysplayName { get; set; }
        public List<string> DysplayParamsNames { get; set; }
        public string IconClassName { get; set; }
        public decimal? FUNCID { get; set; }
        public string PROC_NAME { get; set; }
        public string DESCR { get; set; }
        public string PROC_PAR { get; set; }
        public string PROC_EXEC { get; set; }
        public string QST { get; set; }
        public string MSG { get; set; }
        public string CHECK_FUNC { get; set; }
        public object ParamsInfo { get; set; }
        public string WEB_FORM_NAME { get; set; }
        public List<string> ConditionParamNames { get; set; }
        public int? CodeOper { get; set; }
        public string OutParams { get; set; }
        public string LinkWebFormName { get; set; }
        public bool OpenInWindow { get; set; }
    }
}