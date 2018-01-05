using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RowsDataModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models.ViewModels
{
    public class RowDataModel
    {
        public RowDataModel()
        {

        }
        public List<FieldProperties> RowFilds { get; set; }
    }
}