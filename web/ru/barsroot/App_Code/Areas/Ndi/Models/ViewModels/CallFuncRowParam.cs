using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CallFuncRowParam
/// </summary>
namespace BarsWeb.Areas.Ndi.Models.ViewModels
{
    public class CallFuncRowParam
    {
        public CallFuncRowParam()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public int RowIndex { get; set; }
        public List<FieldProperties> RowParams { get; set; }
    }
}