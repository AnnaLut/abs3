using BarsWeb.Areas.MetaDataAdmin.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DefParamModel
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{ 
    public class DefParamModel
    {
        public DefParamModel()
        {
            this.InsertDefParams = new List<FieldProperties>();
        }
        public List<FieldProperties> InsertDefParams { get; set; }
        public string Base64InsertDefParamsString { get; set; }

    }
}