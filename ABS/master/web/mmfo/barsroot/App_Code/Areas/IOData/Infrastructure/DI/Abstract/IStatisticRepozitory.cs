using System.Collections.Generic;
using BarsWeb.Areas.IOData.Models;

namespace BarsWeb.Areas.IOData.Infrastructure.DI.Abstract
{
    public interface IStatisticRepozitory
    {
        IEnumerable<ShedulerJob> ShedulerJobs();
        IEnumerable<JobLogRecord> JobLogRecords();

        IEnumerable<EnableJob> EnabledJobs();

        IEnumerable<JobParameter> JobParams(string jobName);

        void ChangeJobState(string jobName, string jobEnabled);
        void RecreateJob(string jobName);
        void UpdateJobParams(string jobName, IEnumerable<JobParameter> jobParams);
        void DeleteJobParams(string jobName, IEnumerable<JobParameter> jobParams);
        void InsertJobParams(string jobName, IEnumerable<JobParameter> jobParams);
        IEnumerable<JobParameter> AvailableJobParams(string jobName);
    }
}