using BarsWeb.Areas.SignStatFiles.Models;
using BarsWeb.Core.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.SignStatFiles.Infrastructure.DI.Abstract
{
    public interface ISignStatFilesRepository
    {
        KendoDataSource<StatFile> GetAllFiles(DataSourceRequest request);
        KendoDataSource<FileWorkflow> GetFileDetails(long fileId);
        IList<string> GetAllowedExtensions();
        void SetFileOperation(FileOperation operation);
        string GetFileHash(long storageId);
        string GetFileHashForCAdES(long storageId);
        string GetCurrentUserSubjectSN();

        List<FileListRow> GetFilesList(List<string> allowedFileTypes);
        decimal UploadFileToDb(string filePath);
        byte[] GetLastSignature(long fileId);
        void UploadFileToResDir(string fileName, long fileId);
        void SetFileDetailsId(long fileId);
    }
}