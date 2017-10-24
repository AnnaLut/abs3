using BarsWeb.Areas.PB1.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;


namespace BarsWeb.Areas.PB1.Infrastructure.Repository.DI.Abstract
{
    public interface IFormingReportRepository
    {
        List<DropDown> GetDropDownData();
        List<GridData> GetGridData(string D, string KOD_B, bool data_exist);
        object GetParams();
        Object CreateFileForPrint();
    }
}