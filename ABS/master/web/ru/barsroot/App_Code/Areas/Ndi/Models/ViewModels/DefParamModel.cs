using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DefParamModel
/// </summary>
public class DefParamModel
{
    public DefParamModel()
    {
        this.InsertDefParams = new List<FieldProperties>();
    }
    public List<FieldProperties> InsertDefParams { get; set; }
    public string Base64InsertDefParamsString { get; set; }

}