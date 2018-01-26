using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DeleteRowsModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class DeleteRowsModel
    {
        public DeleteRowsModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public List<DeleteRowModel> RowsArray { get; set; }
    }
}