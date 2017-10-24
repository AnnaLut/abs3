using Areas.DownloadXsdScheme.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.DownloadXsdScheme.Infrastructure.DI.Abstract
{
    public interface IDownloadXsdSchemeRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);
        void ExecuteUploadProcedure(int fileId, byte[] fileData, DateTime sDate);
        void UploadFileFromPathIE(FileUploadModel model);

        void UploadFileFromBytes(FileUploadModel model, byte[] fileContent);
    }
}