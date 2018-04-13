using System.Collections.Generic;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Представляет упрощенный интерфейс для доступа к классам SyncCallerBase (фасад)
    /// </summary>
    internal class SyncCallFacade
    {
        /// <summary>
        /// Синхронизировать счета
        /// </summary>
        /// <returns></returns>
        public static SyncCallResult SyncAccounts(string mfoCode, bool parallel, bool async)
        {
            var syncCaller = new SyncInvoker
            {
                MfoCode = mfoCode,
                Parallel = parallel,

                StartInfos = new List<SyncInvokerStartInfo>
                {
                    new SyncInvokerStartInfo
                    {
                        SynchronizerFactory = new AccountSynchronizerFactory(), 
                        TransferType = SyncType.Accounts
                    }
                }
            };

            if (async)
            {
                return syncCaller.DoAsync();
            }
            return syncCaller.Do();
        }

        /// <summary>
        /// Синхронизировать транзакції
        /// </summary>
        /// <returns></returns>
        public static SyncCallResult SyncTransactios(string mfoCode, bool parallel, bool async)
        {
            var syncCaller = new SyncInvoker
            {
                MfoCode = mfoCode,
                Parallel = parallel,

                StartInfos = new List<SyncInvokerStartInfo>
                {
                    new SyncInvokerStartInfo
                    {
                        SynchronizerFactory = new TramsactionSynchronizerFactory(), 
                        TransferType = SyncType.Transactions
                    }
                }
            };

            if (async)
            {
                return syncCaller.DoAsync();
            }
            return syncCaller.Do();
        }

        /// <summary>
        /// Синхронизировать архив счетов
        /// </summary>
        /// <returns></returns>
        public static SyncCallResult SyncAccountsRest(string mfoCode, bool parallel, bool async)
        {
            var syncCaller = new SyncInvoker
            {
                MfoCode = mfoCode,
                Parallel = parallel,

                StartInfos = new List<SyncInvokerStartInfo>
                {
                    new SyncInvokerStartInfo
                    {
                        SynchronizerFactory = new AccountRestSynchronizerFactory(), 
                        TransferType = SyncType.AccountsRest
                    }
                }
            };

            if (async)
            {
                return syncCaller.DoAsync();
            }
            return syncCaller.Do();
        }

        /// <summary>
        /// Синхронизировать список отделений (бранчей)
        /// </summary>
        /// <returns></returns>
        public static SyncCallResult SyncBranches(string mfoCode, bool parallel, bool async)
        {
            var syncCaller = new SyncInvoker
            {
                MfoCode = mfoCode,
                Parallel = parallel,

                StartInfos = new List<SyncInvokerStartInfo>
                {
                    new SyncInvokerStartInfo
                    {
                        SynchronizerFactory = new BranchSynchronizerFactory(), 
                        TransferType = SyncType.Branches
                    }
                }
            };

            if (async)
            {
                return syncCaller.DoAsync();
            }
            return syncCaller.Do();
        }

        /// <summary>
        /// Синхронизировать список отделений (бранчей)
        /// </summary>
        /// <returns></returns>
        public static SyncCallResult SyncBranchesThenAccounts(string mfoCode, bool parallel, bool async)
        {
            var syncCaller = new SyncInvoker
            {
                MfoCode = mfoCode,
                Parallel = parallel,

                StartInfos = new List<SyncInvokerStartInfo>
                {
                    new SyncInvokerStartInfo
                    {
                        SynchronizerFactory = new BranchSynchronizerFactory(), 
                        TransferType = SyncType.Branches
                    },
                    new SyncInvokerStartInfo
                    {
                        SynchronizerFactory = new AccountSynchronizerFactory(), 
                        TransferType = SyncType.Accounts
                    }
                }
            };

            if (async)
            {
                return syncCaller.DoAsync();
            }
            return syncCaller.Do();
        }
    }
}