using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Ninject;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Фабрика создания синхронизатора архивов счетов
    /// </summary>
    internal class AccountRestSynchronizerFactory : ISynchronizerFactory
    {
        public SynchronizerBase GetSynchronizer()
        {
            IKernel kernel = new StandardKernel();
            CashAreaBinder.Bind(kernel);
            var accountRepository = kernel.Get<IAccountRepository>();
            var syncRepository = kernel.Get<ISyncRepository>();

            return new AccountRestSynchronizer(accountRepository, syncRepository);
        }
    }
}