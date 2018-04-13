using System;
using System.Linq.Dynamic;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using BarsWeb.Areas.Cash.ViewModels;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{

    /// <summary>
    /// Синхронизатор отделений (бранчей)
    /// </summary>
    internal class BranchSynchronizer : SynchronizerBase
    {
        public BranchSynchronizer(IAccountRepository accountRepository, ISyncRepository syncRepository)
            : base(accountRepository, syncRepository) { }
        
        protected override string TransferType
        {
            get { return SyncType.Branches; }
        }

        protected override string BasicActionMethod
        {
            get { return GetBranchesActionMethod; }
        }


        private string GetBranchesActionMethod
        {
            get { return "api/cash/load/branches"; }
        }

        protected override SyncResult MakeSync(ConnectionOption connectionOption, LogBinder logBinder)
        {
            connectionOption.Url = CombineUrl(connectionOption.Url, GetBranchesActionMethod);

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
                var brachesResponse = JsonConvert.DeserializeObject<BranchesResponse>(webApiResponse);

                if (!brachesResponse.Success)
                {
                    syncResult.Status = SyncStatus.Error;
                    syncResult.Message = brachesResponse.ErrorMessage;
                    syncResult.DateEnd = DateTime.Now;
                    return syncResult;
                }

                // количество строк известно после ответа WebApi
                syncResult.RowsTotal = brachesResponse.Branches.Count();

                // для каждого счета в регионе
                //
                foreach (var branch in brachesResponse.Branches)
                {
                    // добавить счет в таблицу счетов
                    AccountRepository.AddBranchData(branch);
                    // если нет ошибок, то увеличиваем количество успешных обновлений строк
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