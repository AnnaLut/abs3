using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ExcelResult
/// </summary>
public class ResultForExcel : GetDataResultInfo
{
    public ResultForExcel()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string ExcelParam { get; set; }
}