using BarsWeb.Areas.MetaDataAdmin.Infrastructure.Repository.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EditFilterModel
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class EditFilterModel
    {
        public EditFilterModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int TableId { get; set; }
        public string TableName { get; set; }
        public string JosnStructure { get; set; }
        public string FilterName { get; set; }
        public int FilterId { get; set; }
        public List<BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers.FilterRowInfo> FilterRows { get; set; }
        public string Clause { get; set; }
    }
}