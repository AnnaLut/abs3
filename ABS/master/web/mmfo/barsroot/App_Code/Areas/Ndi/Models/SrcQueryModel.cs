using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SrcQueryModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class SrcQueryModel
    {
        public SrcQueryModel()
        {
            
        }

        public SrcQueryModel(int tabid, int colId, List<ColumnMetaInfo> queryParamsInfo)
            : this(tabid, colId, queryParamsInfo, new List<FieldProperties>())
        {
            
        }

        public SrcQueryModel(int tabid, int colId, List<ColumnMetaInfo> queryParamsInfo, List<FieldProperties> queryParams)
        {
            this.Tabid = tabid;
            this.ColId = colId;
            this.QueryParamsInfo = queryParamsInfo;
            this.QueryParams = queryParams;
        }

        public string  IdColName = "ID";
        public string  SemanticColName = "NAME";

        public int Tabid { get; set; }
        public int ColId {get;set;}

        public List<ColumnMetaInfo> QueryParamsInfo { get; set; }
        public List<FieldProperties> QueryParams {get;set;}


    }
}