using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DeleteRowModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class DeleteRowModel
    {
        public DeleteRowModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public List<FieldProperties> RowToDelete { get; set; }
    }
}