using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Serialization;

namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Метаданные колонок справочника (на основе META_COLUMNS)
    /// </summary>
    public class ColumnMetaInfo
    {
        //основные поля
        public decimal COLID { get; set; }
        public string COLNAME { get; set; }
        public string COLTYPE { get; set; }
        public string SEMANTIC { get; set; }
        public decimal? SHOWWIDTH { get; set; }
        public int? SHOWMAXCHAR { get; set; }
        public string SHOWFORMAT { get; set; }
        public short SHOWIN_FLTR { get; set; }
        public string SHOWRESULT { get; set; }
        public short NOT_TO_EDIT { get; set; }
        public short NOT_TO_SHOW { get; set; }
        public short? SHOWPOS { get; set; }
        public short EXTRNVAL { get; set; }
        //поля реквизитов внешних колонок
        [ScriptIgnore]
        public decimal SrcTableId { get; set; }
        public string SrcTableName { get; set; }
        [ScriptIgnore]
        public decimal SrcColid { get; set; }
        public string SrcColName { get; set; }
        [ScriptIgnore]
        public string Tab_Alias { get; set; }
        [ScriptIgnore]
        public string Tab_Cond { get; set; }
        [ScriptIgnore]
        public string Src_Cond { get; set; }
        [ScriptIgnore]
        public string SrcColFullName
        {
            get { return SrcTableName + "." + SrcColName; }
        }
        [ScriptIgnore]
        public string ResultColFullName
        {
            get { return SrcTableName + '.' + COLNAME; }
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
                    return SrcTableName + "_" + COLNAME;
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

        /// <summary>
        /// Информация о проваливании для колонки
        /// </summary>
        public FallDownColumnInfo FallDownInfo { get; set; }
    }
}

