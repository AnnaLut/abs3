using System.Collections.Generic;
using System.Web;
using BarsWeb.Areas.Cash.ViewModels;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Стратегия последовательности обработки списка МФО при синхронизации
    /// </summary>
    internal abstract class SyncThreadStrategyBase
    {
        protected SyncThreadStrategyBase()
        {
            Connections = new List<OracleConnection>();
        }

        public HttpContext HttpContext { get; set; }

        /// <summary>
        /// Если задано, то для SQL-команд используется данный Connection
        /// </summary>
        //public OracleConnection Connection { get; set; }

        /// <summary>
        /// Если задано, то для SQL-команд используется данный Connection
        /// </summary>
        public List<OracleConnection> Connections { get; set; }

        /// <summary>
        /// Максимальное количество потоков, которое может использовать стратегия
        /// </summary>
        public abstract int MaxThreadCount { get; }

        /// <summary>
        /// Выполнить синхронизацию
        /// </summary>
        /// <param name="connectionOptions">Список настроек, которые нужно обработать</param>
        /// <param name="synchronizerFactory">Фабрика синхронизаторов, которую нужно применить</param>
        /// <param name="logBinder">Определяет родительскую строку протокола для новых строк</param>
        public abstract IEnumerable<SyncResult> Sync(IEnumerable<ConnectionOption> connectionOptions, ISynchronizerFactory synchronizerFactory, LogBinder logBinder);
    }
}