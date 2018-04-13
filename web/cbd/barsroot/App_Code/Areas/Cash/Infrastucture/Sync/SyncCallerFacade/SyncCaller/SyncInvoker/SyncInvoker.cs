using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using System.Web;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;
using Bars.Classes;
using Ninject;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Вызывает синхронизацию по переданным параметрам. Умеет выполнять ее синхронно и асинхронно
    /// </summary>
    public class SyncInvoker
    {
        public SyncInvoker()
        {
            SyncOnlyEnabled = true;
            IKernel kernel = new StandardKernel();
            CashAreaBinder.Bind(kernel);
            SyncRepository = kernel.Get<ISyncRepository>();
        }

        protected readonly ISyncRepository SyncRepository;


        public List<SyncInvokerStartInfo> StartInfos { get; set; }

        private SyncInvokerStartInfo _curStartInfo;

        /// <summary>
        /// Фильтр на МФО, если не задано, то синхронизируются все МФО
        /// </summary>
        public string MfoCode { get; set; }

        /// <summary>
        /// Обрабатывать настройки синхронизации только с признаком "Выполнять синхронизацию" (по умолчанию - true)
        /// </summary>
        public bool SyncOnlyEnabled { get; set; }

        public bool Parallel { get; set; }

        /// <summary>
        /// Стратегия выполенния синхронизации
        /// </summary>
        private SyncThreadStrategyBase SyncThreadStrategy { get; set; }

        private SyncResult _totalSyncResult;


        /// <summary>
        /// Выполнить синхронизацию
        /// </summary>
        /// <returns></returns>
        public SyncCallResult Do()
        {
            CreateSyncStrategy();

            SyncCallResult lastResult = null;
            try
            {
                foreach (var startInfo in StartInfos)
                {
                    _curStartInfo = startInfo;

                    try
                    {
                        LogStart();
                        List<SyncResult> syncResults = MakeSync();
                        lastResult = LogEnd(syncResults);
                    }
                    catch (Exception ex)
                    {
                        LogException(ex);
                        lastResult = new SyncCallResult
                        {
                            Success = false,
                            Message = ex.ToString()
                        };
                    }
                }
            }
            finally
            {
                CloseConnections();
            }

            return lastResult;
        }

        /// <summary>
        /// Выполнить синхронизацию асинхронно
        /// </summary>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        public SyncCallResult DoAsync()
        {
            CreateSyncStrategy();

            var lastTask = Task.Factory.StartNew(() =>
            {
                _curStartInfo = StartInfos[0];
                LogStart();
                return MakeSync();
            })
            .ContinueWith(antecedentTask => HandleResult(antecedentTask.Exception, antecedentTask.Result));

            // привязываем остальные
            for (int i = 1; i < StartInfos.Count; i++)
            {
                int tempI = i;
                lastTask = lastTask.ContinueWith(antecedentTask =>
                {
                    _curStartInfo = StartInfos[tempI];
                    LogStart();
                    return MakeSync();
                })
                .ContinueWith(antecedentTask => HandleResult(antecedentTask.Exception, antecedentTask.Result));
            }

            // соединения закрываем после обработки ошибок, т.к. обработчик использует их
            lastTask.ContinueWith(antecedentTask => CloseConnections());

            var result = new SyncCallResult
            {
                Success = true,
                Message = string.Format("Синхронізація розпочата")
            };
            return result;
        }

        private void CreateSyncStrategy()
        {
            if (Parallel && Environment.ProcessorCount > 1)
            {
                SyncThreadStrategy = new ParallelThreadSyncStrategy();
            }
            else
            {
                SyncThreadStrategy = new OneThreadSyncStrategy();
            }

            int connectionsCount = string.IsNullOrEmpty(MfoCode) ? SyncThreadStrategy.MaxThreadCount : 1;
            for (int i = 0; i < connectionsCount; i++)
            {
                SyncThreadStrategy.Connections.Add(OraConnector.Handler.UserConnection);
            }
            SyncThreadStrategy.HttpContext = HttpContext.Current;
        }

        private List<SyncResult> MakeSync()
        {
            // устанавливаем контекст, т.к. это может быть уже другой поток
            if (SyncThreadStrategy.HttpContext != null)
            {
                HttpContext.Current = SyncThreadStrategy.HttpContext;
            }

            ServicePointManager.ServerCertificateValidationCallback = delegate(object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };
            // получить список всех регионов
            //
            IQueryable<CLIM_SYNC_PARAMS> dbRecords = SyncRepository.GetConnectionOptions();
            IEnumerable<ConnectionOption> connectionOptions = ModelConverter.ToViewModelWithPassword(dbRecords).ToList();
            if (!string.IsNullOrEmpty(MfoCode))
            {
                connectionOptions = connectionOptions.Where(x => x.Mfo == MfoCode);
            }
            if (SyncOnlyEnabled)
            {
                connectionOptions = connectionOptions.Where(x => x.SyncEnabled);
            }
            List<ConnectionOption> list = connectionOptions.ToList();

            var syncResults = new List<SyncResult>();
            if (list.Any())
            {
                IEnumerable<SyncResult> results = SyncThreadStrategy.Sync(list, _curStartInfo.SynchronizerFactory, new LogBinder { Level = 1, ParentId = _totalSyncResult.ID });
                if (results != null)
                {
                    syncResults = results.ToList();
                }
            }
            return syncResults;
        }

        private void HandleResult(Exception exception, List<SyncResult> syncResults)
        {
            if (exception != null)
            {
                LogException(exception);
                return;
            }

            if (SyncThreadStrategy.HttpContext != null)
            {
                HttpContext.Current = SyncThreadStrategy.HttpContext;
            }
            SyncRepository.Connection = SyncThreadStrategy.Connections[0];

            LogEnd(syncResults);
        }

        private void LogStart()
        {
            if (SyncThreadStrategy.HttpContext != null)
            {
                HttpContext.Current = SyncThreadStrategy.HttpContext;
            }
            SyncRepository.Connection = SyncThreadStrategy.Connections[0];

            _totalSyncResult = new SyncResult
            {
                DateStart = DateTime.Now,
                Status = SyncStatus.InProcess,
                TransferType = _curStartInfo.TransferType,
            };
            _totalSyncResult.ID = SyncRepository.WriteLog(_totalSyncResult, false);
        }

        private SyncCallResult LogEnd(List<SyncResult> syncResults)
        {
            int succesRegions = syncResults.Count(x => x.Status == SyncStatus.Success);
            int totalRegions = syncResults.Count;
            var result = new SyncCallResult
            {
                Success = succesRegions == totalRegions,
                Message = string.Format("Успішно оброблено {0} з {1} регіонів", succesRegions, totalRegions)
            };

            _totalSyncResult.Status = result.Success ? SyncStatus.Success : SyncStatus.Error;
            _totalSyncResult.Message = result.Message;
            _totalSyncResult.DateEnd = DateTime.Now;
            SyncRepository.WriteLog(_totalSyncResult, false);
            return result;
        }

        private void LogException(Exception exception)
        {
            if (exception != null)
            {
                if (SyncThreadStrategy.HttpContext != null)
                {
                    HttpContext.Current = SyncThreadStrategy.HttpContext;
                }
                SyncRepository.Connection = SyncThreadStrategy.Connections[0];

                _totalSyncResult.Status = SyncStatus.Error;
                _totalSyncResult.DateEnd = DateTime.Now;
                _totalSyncResult.Message = exception.ToString();
                SyncRepository.WriteLog(_totalSyncResult, false);
            }
        }

        private void CloseConnections()
        {
            if (SyncThreadStrategy != null && SyncThreadStrategy.Connections != null)
            {
                foreach (OracleConnection connection in SyncThreadStrategy.Connections)
                {
                    connection.Close();
                }
            }
        }
    }
}