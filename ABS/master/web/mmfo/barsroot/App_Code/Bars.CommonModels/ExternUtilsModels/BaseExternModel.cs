using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Bars.CommonModels.ExternUtilsModels
{
    /// <summary>
    /// Model for execut functional in other process from ABS
    /// </summary>
    [Serializable]
    public class BaseExternModel
    {
        public BaseExternModel(AvailableExecTypes execType)
        {
            ExecType = execType.ToString();
            TimeOut = 200000;
        }
        [ScriptIgnore]
        public string ExtUrlParam { get; set; }
        [ScriptIgnore]
        public string ExtUrl { get; set; }
        public  string ExecType { get; set; }
        public  int TimeOut { get; set; }
    }

    public  enum AvailableExecTypes
    {
        ExceleExport,
        ExcelImport,
        CsvExport,
        ZipArchive
    }
}
