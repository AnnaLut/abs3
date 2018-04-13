using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using BarsWeb.Areas.Cash.ViewModels;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{

    /// <summary>
    /// Синхронизация архива счетов
    /// </summary>
    internal class AccountRestSynchronizer : SynchronizerBase
    {
        public AccountRestSynchronizer(IAccountRepository accountRepository, ISyncRepository syncRepository)
            : base(accountRepository, syncRepository) { }

        protected override string TransferType
        {
            get { return SyncType.AccountsRest; }
        }

        protected override string BasicActionMethod
        {
            get { return GetBankDatesActionMethod; }
        }

        private string GetAccountActionMethod
        {
            get { return "api/cash/load/accountsRest"; }
        }

        private string GetBankDatesActionMethod
        {
            get { return "api/cash/load/bankDates"; }
        }

        protected override SyncResult MakeSync(ConnectionOption connectionOption, LogBinder logBinder)
        {
            string bankDatesUrl = CombineUrl(connectionOption.Url, GetBankDatesActionMethod);
            var syncResult = new SyncResult
            {
                // известно в самом начале
                Mfo = connectionOption.Mfo,
                URL = bankDatesUrl,
                DateStart = DateTime.Now,
                TransferType = TransferType,
                ParentId = logBinder.ParentId,
                RowLevel = logBinder.Level,
                ID = logBinder.Id
            };

            // 1. Получим список банковских дат, для которых ДОЛЖНЫ иметь актуальные данные
            // 2. Исключим из полученного списка даты, для которых УЖЕ ЕСТЬ актуальные данные
            // 3. Вычитаем данные, для сформированного списка банковских дат
            //
            try
            {
                // 1. Получим список банковских дат, для которых ДОЛЖНЫ иметь актуальные данные
                //
                string webApiResponse = MakeHttpRequest(bankDatesUrl, connectionOption.Login, connectionOption.Password);
                var bankDatesResponse = JsonConvert.DeserializeObject<BankDatesResponse>(webApiResponse);

                if (!bankDatesResponse.Success)
                {
                    syncResult.Status = SyncStatus.Error;
                    syncResult.Message = bankDatesResponse.ErrorMessage;
                    syncResult.DateEnd = DateTime.Now;
                    return syncResult;
                }
                List<DateTime> bankDates = bankDatesResponse.BankDates.ToList();
                bankDates.Sort();

                var syncResults = new List<SyncResult>();
                foreach (var bankDate in bankDates)
                {
                    var date = bankDate;
                    // 2. Исключим из полученного списка даты, для которых УЖЕ ЕСТЬ актуальные данные
                    //
                    bool hasActualData = SyncRepository.GetLog().Any(x => x.KF == connectionOption.Mfo
                                                                           && x.TRANSFER_BDATE == date
                                                                           && !string.IsNullOrEmpty(x.TRANSFER_RESULT)
                                                                           && x.TRANSFER_RESULT == SyncStatus.Success
                                                                           && !string.IsNullOrEmpty(x.TRANSFER_TYPE)
                                                                           && x.TRANSFER_TYPE == SyncType.AccountsRest);
                    if (!hasActualData)
                    {
                        // 3. Вычитаем данные, для сформированного списка банковских дат
                        //
                        // делаем копию 
                        ConnectionOption curConnectionOption = connectionOption.CloneMe();
                        curConnectionOption.Url = CombineUrl(curConnectionOption.Url, GetAccountActionMethod);
                        // изменяем копию
                        curConnectionOption.Url += "?bankdate=" + (date).ToString("yyyy-MM-dd");

                        var oneDatelogBinder = new LogBinder
                        {
                            ParentId = logBinder.Id,
                            Level = logBinder.Level + 1
                        };
                        // запишем признак начала синхронизации для текущей банковской даты
                        //
                        var syncResultBeforeSync = new SyncResult
                        {
                            Status = SyncStatus.InProcess,
                            Mfo = curConnectionOption.Mfo,
                            URL = curConnectionOption.Url,
                            DateStart = DateTime.Now,
                            TransferType = TransferType,
                            BankDate = date,
                            ParentId = oneDatelogBinder.ParentId,
                            RowLevel = oneDatelogBinder.Level,
                        };
                        // и запомним id строки журнала
                        oneDatelogBinder.Id = SyncRepository.WriteLog(syncResultBeforeSync, true);

                        // передаем в качестве входящего параметра
                        SyncResult oneDateSyncResult = SyncOneBankDate(curConnectionOption, bankDate, oneDatelogBinder);

                        // запишем признак завершения синхронизации по текущей банковской дате
                        SyncRepository.WriteLog(oneDateSyncResult, true);

                        syncResults.Add(oneDateSyncResult);
                        syncResult.RowsSucceed += oneDateSyncResult.RowsSucceed;
                        syncResult.RowsTotal += oneDateSyncResult.RowsTotal;
                    }
                }
                int succesBankDates = syncResults.Count(x => x.Status == SyncStatus.Success);
                int totalBankDates = syncResults.Count;

                syncResult.Status = succesBankDates == totalBankDates ? SyncStatus.Success : SyncStatus.Error;
                syncResult.Message = syncResults.Count == 0 ? "Дані для обробки відсутні" : string.Format("Успішно оброблено {0} з {1} банківських дат", succesBankDates, totalBankDates);
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

        private SyncResult SyncOneBankDate(ConnectionOption connectionOption, DateTime bankDate, LogBinder logBinder)
        {
            /*
            Места в коде для заполнения параметров протокола привязаны к исключениям, которые могут возникнуть
            */
            var syncResult = new SyncResult
            {
                // известно в самом начале
                Mfo = connectionOption.Mfo,
                URL = connectionOption.Url,
                DateStart = DateTime.Now,
                TransferType = TransferType,
                BankDate = bankDate,
                ParentId = logBinder.ParentId,
                RowLevel = logBinder.Level,
                ID = logBinder.Id
            };
            try
            {
                string webApiResponse = MakeHttpRequest(connectionOption.Url, connectionOption.Login,
                    connectionOption.Password);
                var accountsRestResponse = JsonConvert.DeserializeObject<AccountsRestResponse>(webApiResponse);

                if (!accountsRestResponse.Success)
                {
                    syncResult.Status = SyncStatus.Error;
                    syncResult.Message = accountsRestResponse.ErrorMessage;
                    syncResult.DateEnd = DateTime.Now;
                    return syncResult;
                }

                // количество строк известно после ответа WebApi
                List<RegionAccountRest> accountRests = accountsRestResponse.AccountsRests.ToList();
                syncResult.RowsTotal = accountRests.Count;

                foreach (var accountRest in accountRests)
                {
                    // добавить счет в таблицу счетов
                    AccountRepository.AddAccountRestData(accountRest);
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
    }
}