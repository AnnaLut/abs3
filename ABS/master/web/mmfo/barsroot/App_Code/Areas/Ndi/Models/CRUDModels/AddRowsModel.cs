using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AddRowsModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class AddRowsModel
    {
        public AddRowsModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public List<AddRowModel> RowsToAddArray { get; set; }
    }
}