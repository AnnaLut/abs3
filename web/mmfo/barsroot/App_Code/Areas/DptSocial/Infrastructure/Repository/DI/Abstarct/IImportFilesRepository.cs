using System;
using System.Collections.Generic;
using Bars.Areas.DptSocial.Models;
using System.Web;

namespace BarsWeb.Areas.DptSocial.Infrastructure.Repository.DI.Abstract
{
    public interface IImportFilesRepository
    {
        List<V_DPT_FILE_IMPR> GetImportedFilesGridData(Int32 file_tp, String file_date);
        List<V_DPT_FILE_IMPR_DTL> GetImportedFileDetailGridData(string file_dt, Int32 file_tp);
        Result ProcessFiles(String path, Int32 file_tp);
    }
}