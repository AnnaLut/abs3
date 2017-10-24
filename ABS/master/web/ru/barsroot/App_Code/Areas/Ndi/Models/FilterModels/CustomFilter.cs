using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
    public ColumnMetaInfo FilterMetaColumn { get; set; }
    public FieldProperties checkParam { get; set; }
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
    public string WHERE_CLAUSE { get; set; }
    public string BANCH { get; set; }
    /// <summary>
    /// Список параметров, которые нужно подставить в выражение фильтра META_FILTERCODES.CONDITION
    /// </summary>
    public List<FieldProperties> FilterParams { get; set; }

    public void BuildFilterParams()
    {
        this.Name = this.FILTER_ID.ToString();
        this.IsUserFilter = USERID.HasValue;
        this.SEMANTIC += this.IsUserFilter ? "(фільтр користувача)" : "(системний фільтр)";
        this.SEMANTIC += " FILTER_ID: " + this.FILTER_ID.ToString();
        if (!string.IsNullOrEmpty(this.PKEY))
            this.SEMANTIC += "PKEY: " + this.PKEY;
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