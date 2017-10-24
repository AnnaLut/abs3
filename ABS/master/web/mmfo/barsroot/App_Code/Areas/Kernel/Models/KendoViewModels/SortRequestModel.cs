using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SortRequestModel
/// </sunamespace 
namespace BarsWeb.Areas.Kernel.Models.KendoViewModels
{
    public class SortRequestModel
    {
        public SortRequestModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public string dir { get; set; }
        public string field { get; set; }
    }
}