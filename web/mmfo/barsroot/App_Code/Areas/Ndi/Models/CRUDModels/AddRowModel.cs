using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AddRowModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class AddRowModel
    {
        public AddRowModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public List<FieldProperties> RowToAddFielsdArray { get; set; }

    }
}