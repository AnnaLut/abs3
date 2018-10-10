using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ExcelResulModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class ExcelResulModel
    {
        public ExcelResulModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public byte[] ContentResult { get; set; }
        public string StringContentResult { get; set; }
        public string FileName { get; set; }
        public string ContentType { get; set; }
        public string Path { get; set; }
    }
}