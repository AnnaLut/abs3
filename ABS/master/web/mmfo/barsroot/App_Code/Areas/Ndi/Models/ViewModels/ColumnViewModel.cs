using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ColumnViewModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models.ViewModels
{
    public class ColumnViewModel
    {
        public ColumnViewModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public string COLNAME { get; set; }
        public string COLTYPE { get; set; }
        public string SEMANTIC { get; set; }

        public string SrcColName
        {
            get;
            set;
        }
        public string SrcTableName { get; set; }
        public string SrcTextColName { get; set; }
    }
}