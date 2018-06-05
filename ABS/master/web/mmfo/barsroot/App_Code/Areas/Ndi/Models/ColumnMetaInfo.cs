using BarsWeb.Areas.Ndi.Models.DbModels;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Serialization;

namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Метаданные колонок справочника (на основе META_COLUMNS)
    /// </summary>
    public class ColumnMetaInfo : ICloneable
    {
        public ColumnMetaInfo()
        {
            Dependencies = new List<DependencyModel>();
            ParamsNames = new List<string>();
        }
        //основные поля
        public int TABID { get; set; }
        public int COLID { get; set; }
        public string COLNAME { get; set; }
        public string COLTYPE { get; set; }
        public string SEMANTIC { get; set; }
        public decimal? SHOWWIDTH { get; set; }
        public decimal? SHOWMAXCHAR { get; set; }
        public string SHOWFORMAT { get; set; }
        public int SHOWIN_FLTR { get; set; }
        public string SHOWRESULT { get; set; }
        public int NOT_TO_EDIT { get; set; }
        public int NOT_TO_SHOW { get; set; }
        public short? SHOWPOS { get; set; }
        public short EXTRNVAL { get; set; }
        public string FORM_NAME { get; set; }
        public string WEB_FORM_NAME { get; set; }
        public string COL_DYN_TABNAME { get; set; }
        public bool IsFuncOnly { get; set; }
        public short? IsPk { get; set; }
        public bool HasSrcCond { get; set; }
        public short? InputInNewRecord { get; set; }
        public List<string> ParamsNames { get; set; }
        public CallFunctionMetaInfo FunctionMetaInfo { get; set; }
        public List<DependencyModel> Dependencies { get; set; }
        public SrcQueryModel srcQueryModel { get; set; }

        //поля реквизитов внешних колонок
        [ScriptIgnore]
        public decimal SrcTableId { get; set; }
        public string SrcTableName { get; set; }
        [ScriptIgnore]
        public decimal SrcColid { get; set; }
        public string SrcColName { get; set; }
       // [ScriptIgnore]
        public string Tab_Alias { get; set; }

        public string SrcTab_Alias { get; set; }
        [ScriptIgnore]
        public string Tab_Cond { get; set; }
       // [ScriptIgnore]
        public string Src_Cond { get; set; }
        [ScriptIgnore]
        public string SrcColFullName
        {
            get { return string.IsNullOrEmpty(Tab_Alias) ? SrcTableName + "." + SrcColName : Tab_Alias + "." + SrcColName; }
        }
        [ScriptIgnore]
        public string ResultColFullName
        {
            get { return string.IsNullOrEmpty(Tab_Alias) ? SrcTableName + '.' + COLNAME : Tab_Alias + '.' + COLNAME; }
        }
        [ScriptIgnore]
        public string TabAliasFull
        {
            get
            {
                if (Tab_Alias == null)
                {
                    return "";
                }
                else
                {
                    return " AS " + Tab_Alias;
                }
            }
        }
        [ScriptIgnore]
        public string ColumnAliasWithAs
        {
            get
            {
                var colAlias = ColumnAlias;
                if (!string.IsNullOrEmpty(colAlias))
                {
                    colAlias = " AS " + colAlias;
                }
                return colAlias;
            }
        }
        [ScriptIgnore]
        public string ColumnAlias
        {
            get
            {
                if (string.IsNullOrEmpty(SrcTableName))
                {
                    return "";
                }
                else
                {
                    return string.IsNullOrEmpty(Tab_Alias) ? SrcTableName + "_" + COLNAME : Tab_Alias + "_" + COLNAME;
                }
            }
        }
        //поля для основных колонок описывающие внешние связи
        public string SrcTextColName { get; set; }
        //поле обозначает lookup колонку из другой таблицы
        public bool IsForeignColumn { get; set; }

        public string LookupNativeColName(List<ColumnMetaInfo> nativeColumnsList)
        {
            var nativeColumnMeta = nativeColumnsList.FirstOrDefault(nc => nc.COLID == COLID);
            return nativeColumnMeta != null ? nativeColumnMeta.COLNAME : "";
        }

        public object Clone()
        {
            return this.MemberwiseClone();
        }

        public  string BuildWebFormName(string webFormName, string searchParam, int? sParColumn, int? nativeTabelId, string baseUrl)
        {
            string res;
            if (string.IsNullOrEmpty(webFormName) || webFormName.IndexOf(searchParam) != 0)
                return webFormName;
            string funNsiEditFParamsString = webFormName.Substring(webFormName.IndexOf(searchParam) + searchParam.Length);
            FunNSIEditFParams par = new FunNSIEditFParams(funNsiEditFParamsString);
            CallFunctionMetaInfo function = par.BuildToCallFunctionMetaInfo();
            function.TABID = nativeTabelId;
            function.ColumnId = Convert.ToInt32(sParColumn);

            if (webFormName.Contains("sPar=["))
                function.PROC_EXEC = "SELECTED_ONE";

            res = baseUrl + "?" + "sParColumn" + "=" + sParColumn + "&" + "nativeTabelId" + "=" + nativeTabelId;
            
            this.IsFuncOnly = par.IsFuncOnly;
            this.FunctionMetaInfo = function;
            this.ParamsNames = par.ParamsNames;
            //string paramvalue = url.Substring(url.LastIndexOf(firstParamName) + firstParamName.Length);
            //string addParam = string.IsNullOrEmpty(additionParameterName) && string.IsNullOrEmpty(additionParameterValue) ? "" : "&" + additionParameterName + "=" + additionParameterValue;
            //string resWebName = url.Replace(paramvalue, firstPramValue) + addParam;
            return res.Trim();
        }

        public void BuildFromDbColumn(MetaColumnsDbModel dbColumn)
        {
           

            this.COLID = Convert.ToInt32(dbColumn.COLID);
            this.COLNAME = string.IsNullOrEmpty(dbColumn.COLNAME) ? dbColumn.COLNAME : dbColumn.COLNAME.Trim();
            this.COLTYPE = string.IsNullOrEmpty(dbColumn.COLTYPE) ? dbColumn.COLTYPE : dbColumn.COLTYPE.Trim();
            this.SEMANTIC = string.IsNullOrEmpty(dbColumn.SEMANTIC) ? dbColumn.SEMANTIC : dbColumn.SEMANTIC.Trim();
            this.SHOWWIDTH = Convert.ToInt32(dbColumn.SHOWWIDTH);
            this.SHOWMAXCHAR = Convert.ToInt32(dbColumn.SHOWMAXCHAR);
            this.SHOWFORMAT = string.IsNullOrEmpty(dbColumn.SHOWFORMAT) ? dbColumn.SHOWFORMAT : dbColumn.SHOWFORMAT.Trim();
            this.SHOWIN_FLTR = dbColumn.SHOWIN_FLTR;
            this.NOT_TO_EDIT = dbColumn.NOT_TO_EDIT;
            this.NOT_TO_SHOW = dbColumn.NOT_TO_SHOW;
            this.EXTRNVAL = dbColumn.EXTRNVAL;
            this.SHOWPOS = dbColumn.SHOWPOS;
            this.SHOWRESULT = dbColumn.SHOWRESULT;
            this.TABID = Convert.ToInt32(dbColumn.TABID);
            this.IsPk = dbColumn.SHOWRETVAL;
            this.InputInNewRecord = dbColumn.INPUT_IN_NEW_RECORD;
        }


    }
}

