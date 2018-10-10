using BarsWeb.Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Models.FilterModels;

namespace BarsWeb.Areas.Ndi.Models.ViewModels
{
    /// <summary>
    /// Summary description for GetDataModel
    /// </summary>
    public class DataModel
    {
        public string GridFilter { get; set; }
        public string ExternalFilter { get; set; }
         public virtual string DynamicFilter { get; set; }
        public int TableId { get; set; }
        public string TableName { get; set; }
        public string StartFilter { get; set; }
         public string JsonSqlProcParams { get; set; }
        public string Base64jsonSqlProcParams   {get;set;}
        public int? CodeOper { get; set; }
        public int? NsiTableId { get; set; }
        public int? NativeTabelId { get; set; }
        public int? NsiFuncId { get; set; }
        public int? SParColumn { get; set; }
        public string FilterCode { get; set; }

        public string ExecuteBeforFunc { get; set; }
        public int? FilterTblId { get; set; }
        public string KindOfFilter { get; set; }

        public bool IsResetPages { get; set; }

        public string Sort { get; set; }

        public int Limit  {get; set;}

        public int Start { get; set; }

        public string Code { get; set; }
        public bool GetAll { get; set; }

    }

    public class TestClass
    {
        public int testVar { get; set; }
        public string sumvar { get; set; }

        public string testVar2 { get; set; }
    }

    public class ExterNalParams
    {
        public string StartFilter;
        public string JsonSqlProcParams;
        public string Base64jsonSqlProcParam;
        public string dynamicFilter;
    }


}