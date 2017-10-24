using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ReplaceModel
/// </summary>
public class ReplaceModel
{
    public ReplaceModel()
    {
        this.ReplaceSemanticFields = new List<FieldProperties>();
        //
        // TODO: Add constructor logic here
        //
    }

    public List<FieldProperties> ReplaceSemanticFields { get; set; }

}