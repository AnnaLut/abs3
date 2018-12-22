using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ExcelModel
/// </summary>
namespace Bars.CommonModels.ExternUtilsModels
{
    public class ExcelExtModel : BaseExternModel
    {
        public String Semantic { get; set; }
        public SelectModel SelectModel { get; set; }
        public List<ColumnDesc> ColumnsInfo { get; set; }
        public LoginModel LoginModel { get; set; }
        public ExcelExtModel()
            :base(AvailableExecTypes.ExceleExport)
        {

        }
      

    }
}