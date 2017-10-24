using System.Collections.Generic;
using BarsWeb.Areas.IOData.Models;

namespace BarsWeb.Areas.IOData.Infrastructure.DI.Abstract
{
    public interface IIODataRepository
    {
        IEnumerable<ActiveJob> ActiveJobs();
        IEnumerable<FileModel> Files(string jobName);
        StatusResult CheckJob(Job item);
        void UpdateJob(Job item);
        void RemoveJob(Job item);
        void UploadOneFile(UploadRequestModel data);
    }
}