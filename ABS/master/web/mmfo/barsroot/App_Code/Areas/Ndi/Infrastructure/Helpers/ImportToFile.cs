using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using Bars.CommonModels;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using Ninject;
using BarsWeb.Core.Logger;
using BarsWeb.Areas.Ndi.Models;
using Bars.CommonModels.ExternUtilsModels;
using BarsWeb.Infrastructure.Helpers;
/// <summary>
/// Summary description for ImportToFileHelper
/// </summary>

namespace BarsWeb.Areas.Ndi.Infrastructure.Helpers
{

    public class ImportToFile : ImportToFileHelper
    {
        public string ExcelExportToZipCSVFiles(char columnSeparator, string fileName, IEnumerable<Dictionary<string, object>> dataRecords, List<ColumnMetaInfo> columnsInfo)
        {
            List<ColumnDesc> columns = columnsInfo.Select(x => new ColumnDesc()
            {
                Name = x.COLNAME,
                Type = x.COLTYPE,
                Semantic = x.SEMANTIC,
                Format = x.SHOWFORMAT
            }).ToList();
            return base.ExcelExportToZipCSVFiles(columnSeparator, fileName, dataRecords, columns);
        }

    }
}