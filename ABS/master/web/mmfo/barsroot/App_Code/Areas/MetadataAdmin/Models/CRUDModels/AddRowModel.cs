using BarsWeb.Areas.MetaDataAdmin.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AddRowModel
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
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