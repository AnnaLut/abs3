using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Параллельное выполенение синхронизации
    /// </summary>
    internal class ParallelThreadSyncStrategy : SyncThreadStrategyBase
    {
        /// <summary>
        /// Количество настроек, для которых обработка уже начата (общая переменная на все потоки, используем мютекс для записи)
        /// </summary>
        private int _pickedCount;

        /// <summary>
        /// Результаты синхронизации по каждой настройке (каждому МФО)
        /// </summary>
        private List<SyncResult> _syncResults;

        /// <summary>
        /// Для блокировки мютекса доступа к _syncResults из разных потоков
        /// </summary>
        private readonly object _syncResultsLock = new object();

        private void AddSyncResult(SyncResult syncResult)
        {
            lock (_syncResultsLock)
            {
                _syncResults.Add(syncResult);
            }
        }

        /// <summary>
        /// Настройки для обработки
        /// </summary>
        private List<ConnectionOption> _connectionOptions;

        public override int MaxThreadCount
        {
            get { return Environment.ProcessorCount; }
        }

        private LogBinder _logBinder;

        public override IEnumerable<SyncResult> Sync(IEnumerable<ConnectionOption> connectionOptions, ISynchronizerFactory synchronizerFactory, LogBinder logBinder)
        {
            _logBinder = logBinder;
            _connectionOptions = connectionOptions.ToList();
            _pickedCount = 0;
            _syncResults = new List<SyncResult>();

            // необходимое количество потоков для обработки всех настроек
            int threadsCount = Math.Min(MaxThreadCount, _connectionOptions.Count);

            if (threadsCount <= 0)
            {
                return null;
            }

            // создаем n-1 дополнительных потоков
            var startedTasks = new List<Task>();
            for (int i = 0; i < threadsCount - 1; i++)
            {
                int currentConnectionOption = i;
                var syncTask = Task.Factory.StartNew(() =>
                    StartThreadFunction(synchronizerFactory, currentConnectionOption));
                var errorHandlerTask = syncTask.ContinueWith(antecedentTask => HandleException(antecedentTask.Exception, currentConnectionOption));
                startedTasks.Add(syncTask);
                startedTasks.Add(errorHandlerTask);
            }

            // также используем текущий поток
            //
            var lastConnectionOptionIndex = threadsCount - 1;
            try
            {
                StartThreadFunction(synchronizerFactory, lastConnectionOptionIndex);
            }
            catch (Exception ex)
            {
                HandleException(ex, lastConnectionOptionIndex);
            }

            Task.WaitAll(startedTasks.ToArray());
            return _syncResults;
        }

        private void StartThreadFunction(ISynchronizerFactory synchronizerFactory, int indexForProcess)
        {
            // устанавливаем контекст, т.к. это уже другой поток
            if (HttpContext != null)
            {
                HttpContext.Current = HttpContext;
            }
            //валидация сертификата
            ServicePointManager.ServerCertificateValidationCallback = delegate(object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };
            
            SynchronizerBase synchronizer = synchronizerFactory.GetSynchronizer();
            synchronizer.Connection = Connections[indexForProcess];
            ThreadFunction(synchronizer);
        }

        private void ThreadFunction(SynchronizerBase synchronizer)
        {
            bool hasItems;
            do
            {
                // увеличиваем счетчик принятых в обработку
                int pickedCount = Interlocked.Increment(ref _pickedCount);

                // если счетчик не больше общего количества, значит еще есть что обрабатывать
                hasItems = pickedCount <= _connectionOptions.Count;
                if (hasItems)
                {
                    SyncResult syncResult = synchronizer.Sync(_connectionOptions[pickedCount - 1], (LogBinder)_logBinder.Clone());
                    AddSyncResult(syncResult);
                }
            } while (hasItems);
        }

        private void HandleException(Exception exception, int indexOfFailed)
        {
            if (exception != null)
            {
                ConnectionOption failedConnectionOption = _connectionOptions[indexOfFailed];
                var syncResult = new SyncResult
                {
                    DateStart = DateTime.Now,
                    Status = SyncStatus.Error,
                    Message = exception.ToString(),
                    Mfo = failedConnectionOption.Mfo,
                };

                AddSyncResult(syncResult);
            }
        }
    }
}