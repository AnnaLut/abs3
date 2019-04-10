using BarsWeb.Areas.MetaDataAdmin.Infrastructure.Repository.Helpers;
using System.Collections.Generic;

namespace BarsWeb.Areas.MetaDataAdmin.Models.FilterModels
{
    /// <summary>
    /// Summary description for CreateFilterModel
    /// </summary>
    public class CreateFilterModel
    {
        public CreateFilterModel()
        {
     
        }


        public string Parameters { get; set; }
        public FilterType FilterType { get; set; }
        public List<BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers.FilterRowInfo> FilterRows { get; set; }
        public string FilterTypeDescription { get; set; }
        public int SaveFilter = 1;
        public string WhereClause { get; set; }

   
    }
}

