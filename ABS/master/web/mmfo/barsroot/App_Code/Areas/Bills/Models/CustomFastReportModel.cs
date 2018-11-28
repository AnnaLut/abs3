using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель набора данных для формирования отчета (FastReport) 
    /// </summary>
    public class CustomFastReportModel
    {
        public FrxParameters Parameters { get; set; }
        public Int32 ReportID { get; set; }
    }
}