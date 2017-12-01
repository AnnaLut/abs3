using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MetaTable
/// </summary>
namespace BarsWeb.Areas.Ndi.Models.DbModels
{
    public class MetaTable
    {
        public MetaTable()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public string TABNAME { get; set; }
        public int TABID { get; set; }

        public string SEMANTIC { get; set; }

        public string BRANCH { get; set; }

        public int TABRELATION { get; set; }
        public int? TableDel { get; set; }

        public int? LINESDEF { get; set; }

        public string SELECT_STATEMENT { get; set; }
        
    }
}