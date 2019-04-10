using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TableInfo
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models.DbTabelsInfoModels
{
    public class ColumnDbInfo
    {
        public ColumnDbInfo()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public string ColumnName { get; set; }
        public int ColumnSize { get; set; }
        public bool AllowDBNull { get; set; }

        public int NumericPrecision { get; set; }
        public int? NumericScale { get; set; }

        public string DataType { get; set; }

        public string Semantic { get; set; }

        public int ColumnOrdinal { get; set; }

    }
}