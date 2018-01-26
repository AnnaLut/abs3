using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers;

namespace BarsWeb.Areas.Ndi.Models.FilterModels
{
    /// <summary>
    /// Summary description for CustomFilter
    /// </summary>
    public class FilterInfo
    {
        public FilterInfo()
        {
            //
            // TODO: Add constructor logic here
            //
        }


        public FilterInfo(FilterModel filter)
        {
            this.FILTER_ID = filter.Filter_id;
            this.Where_clause = filter.WhereClause;
        }

        public ColumnMetaInfo FilterMetaColumn { get; set; }
        public FieldProperties checkParam { get; set; }
        public List<FilterRowInfo> FilterRows { get; set; }
        public string CONDITION_LIST { get; set; }
        public string Name { get; set; }
        public bool IsUserFilter { get; set; }

        public string Type = "B";
        public string Value { get; set; }
        public string PKEY { get; set; }
        public string SEMANTIC { get; set; }
        public int FILTER_ID { get; set; }
        public int? USERID { get; set; }
        public int? TABID { get; set; }
        public string FROM_CLAUSE { get; set; }
        /// <summary>
        /// Выражение фильтра
        /// </summary>
        public string Where_clause { get; set; }
       


        /// <summary>
        /// Список параметров, которые нужно подставить в выражение фильтра META_FILTERCODES.CONDITION
        /// </summary>
        public List<FieldProperties> FilterParams { get; set; }

        public void BuildFilterParams()
        {
            this.Name = FILTER_ID.ToString();
            this.IsUserFilter = USERID.HasValue;
            //this.SEMANTIC += IsUserFilter ? "(фільтр користувача)" : "(системний фільтр)";
            //this.SEMANTIC += " FILTER_ID: " + FILTER_ID;
            //if (!string.IsNullOrEmpty(PKEY))
            //    this.SEMANTIC += "PKEY: " + PKEY;
            if (!string.IsNullOrEmpty(CONDITION_LIST))
                this.FilterRows = FormatConverter.JsonToObject<List<FilterRowInfo>>(CONDITION_LIST);

        }
        //public ColumnMetaInfo BuildMetaColumnFromFilter()
        //{
        //    FilterMetaColumn = new ColumnMetaInfo();
        //    FilterMetaColumn.SEMANTIC = this.SEMANTIC;
        //    FilterMetaColumn.
        //}
        public static string BuildFilterConditions(int tableId, int? userid = null)
        {
            string conditions;
            if (userid != null)
                conditions = string.Format("TABID={0} and USERID = {1}", tableId, userid.Value);
            else
                conditions = string.Format("TABID={0} AND USERID IS NULL", tableId);
            return conditions;
        }

    }

    public enum KindsOfFilters
    {
        CustomFilter,
        SystemFilter,
        SimpleFilter
    }
}