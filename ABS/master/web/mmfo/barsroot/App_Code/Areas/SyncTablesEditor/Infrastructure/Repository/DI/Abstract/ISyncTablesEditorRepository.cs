using Areas.SyncTablesEditor.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.SyncTablesEditor.Infrastructure.DI.Abstract
{
    public interface ISyncTablesEditorRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);
        ResponseSTE UpdateRecord(SyncTables model);
        ResponseSTE DeleteRecord(SyncTables model);
        ResponseSTE SynchronizeTable(SyncTables model);
        ResponseSTE GetFullFilePath(int tabId);
        ResponseSTE GetFileLastChangeDate(int tabId);
        ResponseSTE SynchronizeAllTables();
        ResponseSTE UploadFile(FileInput uploadFileInfo);
        FileCheckResponse CheckFile(SyncTables model, string filePath);
        ResponseSTE UploadFileData(byte[] fileData, string fileDate, int tabId);
        ResponseSTE ExportTableToSql(int tabId);
    }
}