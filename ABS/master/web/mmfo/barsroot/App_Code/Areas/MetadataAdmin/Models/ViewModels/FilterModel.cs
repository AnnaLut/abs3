using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace BarsWeb.Areas.MetaDataAdmin.Models.ViewModels
{
    public class FilterModel
    {
        public string WhereClause { get; set; }

        public int Filter_id { get; set; }
    }
}