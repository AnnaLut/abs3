﻿using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Ninject;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Фабрика создания синхронизатора счетов
    /// </summary>
    internal class AccountSynchronizerFactory : ISynchronizerFactory
    {
        public SynchronizerBase GetSynchronizer()
        {
            IKernel kernel = new StandardKernel();
            CashAreaBinder.Bind(kernel);
            var accountRepository = kernel.Get<ICenterAccountRepository>();
            var syncRepository = kernel.Get<ISyncRepository>();

            return new AccountSynchronizer(accountRepository, syncRepository);
        }
    }
}