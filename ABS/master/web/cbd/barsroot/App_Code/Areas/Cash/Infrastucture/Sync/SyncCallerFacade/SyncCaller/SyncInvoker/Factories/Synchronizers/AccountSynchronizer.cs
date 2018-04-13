using System;
using System.Linq.Dynamic;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using BarsWeb.Areas.Cash.ViewModels;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{

    /// <summary>
    /// Синхронизатор счетов
    /// </summary>
    internal class AccountSynchronizer : SynchronizerBase
    {
        public AccountSynchronizer(IAccountRepository accountRepository, ISyncRepository syncRepository)
            : base(accountRepository, syncRepository) { }
        
        protected override string TransferType
        {
            get { return SyncType.Accounts; }
        }

        protected override string BasicActionMethod
        {
            get { return GetAccountActionMethod; }
        }


        private string GetAccountActionMethod
        {
            get { return "api/cash/load/accounts"; }
        }

        protected override SyncResult MakeSync(ConnectionOption connectionOption, LogBinder logBinder)
        {
            connectionOption.Url = CombineUrl(connectionOption.Url, GetAccountActionMethod);

            // если ранее выполнялась вычитка по данному mfo
            var hasAccounts = AccountRepository.HasAccounts(connectionOption.Mfo);
            if (hasAccounts)
            {
                connectionOption.Url += "?new=true";
            }

            /*
            Протокол для одного региона
            Места в коде для заполнения параметров протокола привязаны к исключениям, которые могут возникнуть
            */
            var syncResult = new SyncResult
            {
                // известно в самом начале
                Mfo = connectionOption.Mfo,
                URL = connectionOption.Url,
                DateStart = DateTime.Now,
                TransferType = TransferType,
                ParentId = logBinder.ParentId,
                RowLevel = logBinder.Level,
                ID = logBinder.Id
            };
            try
            {
                string webApiResponse = MakeHttpRequest(connectionOption.Url, connectionOption.Login,
                    connectionOption.Password);
                var accountsResponse = JsonConvert.DeserializeObject<AccountsResponse>(webApiResponse);

                if (!accountsResponse.Success)
                {
                    syncResult.Status = SyncStatus.Error;
                    syncResult.Message = accountsResponse.ErrorMessage;
                    syncResult.DateEnd = DateTime.Now;
                    return syncResult;
                }

                // количество строк известно после ответа WebApi
                syncResult.RowsTotal = accountsResponse.Accounts.Count();
                syncResult.BankDate = accountsResponse.BankDate;

                // для каждого счета в регионе
                //
                foreach (var cashAccount in accountsResponse.Accounts)
                {
                    // добавить счет в таблицу счетов
                    AccountRepository.AddAccountData(cashAccount);
                    // если не нет ошибок, то увеличиваем количество успешных обновлений строк
                    syncResult.RowsSucceed++;
                }
                syncResult.Status = SyncStatus.Success;
                syncResult.Message = syncResult.RowsSucceed == 0 ? "Дані для обробки відсутні" : string.Format("Оброблено {0} рядків", syncResult.RowsSucceed);
                syncResult.DateEnd = DateTime.Now;
            }
            catch (Exception ex)
            {
                syncResult.Status = SyncStatus.Error;
                syncResult.Message = ex.ToString();
                syncResult.DateEnd = DateTime.Now;
            }
            return syncResult;
        }

        protected override void AfterSync(ConnectionOption connectionOption)
        {
            //SyncRepository.ReCalcLimitViolations(connectionOption.Mfo);
        }
    }
}