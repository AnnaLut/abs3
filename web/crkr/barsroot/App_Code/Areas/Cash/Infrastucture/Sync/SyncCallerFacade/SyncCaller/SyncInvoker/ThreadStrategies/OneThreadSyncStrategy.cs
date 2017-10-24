using System;
using System.Collections.Generic;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Последовательное выполнение синхронизации
    /// </summary>
    internal class OneThreadSyncStrategy : SyncThreadStrategyBase
    {
        public override int MaxThreadCount
        {
            get { return 1; }
        }

        public override IEnumerable<SyncResult> Sync(IEnumerable<ConnectionOption> connectionOptions, ISynchronizerFactory synchronizerFactory, LogBinder logBinder)
        {
            var syncResults = new List<SyncResult>();
            foreach (var connectionOption in connectionOptions)
            {
                SyncResult syncResult = null;
                try
                {
                    SynchronizerBase synchronizer = synchronizerFactory.GetSynchronizer();
                    synchronizer.Connection = Connections[0];
                    syncResult = synchronizer.Sync(connectionOption, (LogBinder)logBinder.Clone());
                }
                catch (Exception ex)
                {
                    syncResult = new SyncResult
                    {
                        DateStart = DateTime.Now,
                        Status = SyncStatus.Error,
                        Message = ex.ToString(),
                        Mfo = connectionOption.Mfo,
                    };
                }
                finally
                {
                    syncResults.Add(syncResult);
                }
            }
            return syncResults;
        }
    }
}