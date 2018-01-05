using BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InsertFilterModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class InsertFilterModel
    {
        public InsertFilterModel()
        {
            FilterName = "фильтер1";
            SaveFilter = 1;
            //
            // TODO: Add constructor logic here
            //
        }

        public int TableId { get; set; }
        public string TableName { get; set; }
        public string JosnStructure { get; set; }
        public string FilterName { get; set; }
        public int SaveFilter { get; set; }
        public string Clause { get; set; }
        public List<FilterRowInfo> FilterRows { get; set; }
    }
}