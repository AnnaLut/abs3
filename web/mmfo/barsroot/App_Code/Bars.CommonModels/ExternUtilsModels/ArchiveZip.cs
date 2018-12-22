using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Model for Archive files in zip.
/// </summary>
namespace Bars.CommonModels.ExternUtilsModels
{
    [Serializable]
    public class ArchiveZip : BaseExternModel
    {
       

        public ArchiveZip()
            : base(AvailableExecTypes.ZipArchive)
        {

        }

        public string TempDirPath { get; set; }
        public string ZipName { get; set; }
    }
}