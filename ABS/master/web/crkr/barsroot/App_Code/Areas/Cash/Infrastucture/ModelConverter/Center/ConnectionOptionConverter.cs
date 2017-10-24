using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {
        public static CLIM_SYNC_PARAMS ToDbModel(ConnectionOption viewModel)
        {
            var dbModel = new CLIM_SYNC_PARAMS
            {
                LAST_SYNC_DATE = viewModel.LastSyncDate,
                LAST_SYNC_STATUS = viewModel.LastSyncStatus,
                KF = viewModel.Mfo,
                NAME = viewModel.Name,
                SYNC_ENABLED = (short?)(viewModel.SyncEnabled ? 1 : 0),
                SYNC_LOGIN = viewModel.Login,
                SYNC_PASSWORD = viewModel.Password,
                SYNC_SERVICE_URL = viewModel.Url
            };
            return dbModel;
        }

        // todo Обратить внимание! Методы дублируют друг друга
        public static IQueryable<ConnectionOption> ToViewModel(IQueryable<CLIM_SYNC_PARAMS> dbModel)
        {
            return dbModel.Select(x => new ConnectionOption
            {
                Url = x.SYNC_SERVICE_URL,
                // Передаем хеш пароля
                // Password = x.SYNC_PASSWORD,
                Login = x.SYNC_LOGIN,
                LastSyncDate = x.LAST_SYNC_DATE,
                LastSyncStatus = x.LAST_SYNC_STATUS,
                Name = x.NAME,
                SyncEnabled = x.SYNC_ENABLED != null && x.SYNC_ENABLED != 0,
                Mfo = x.KF
            });
        }

        // todo Обратить внимание! Методы дублируют друг друга
        public static IQueryable<ConnectionOption> ToViewModelWithPassword(IQueryable<CLIM_SYNC_PARAMS> dbModel)
        {
            return dbModel.Select(x => new ConnectionOption
            {
                Url = x.SYNC_SERVICE_URL,
                // Передаем хеш пароля
                Password = x.SYNC_PASSWORD,
                Login = x.SYNC_LOGIN,
                LastSyncDate = x.LAST_SYNC_DATE,
                LastSyncStatus = x.LAST_SYNC_STATUS,
                Name = x.NAME,
                SyncEnabled = x.SYNC_ENABLED != null && x.SYNC_ENABLED != 0,
                Mfo = x.KF
            });
        }

        // todo Обратить внимание! Методы дублируют друг друга
        public static ConnectionOption ToViewModel(CLIM_SYNC_PARAMS dbModel)
        {
            var viewModel = new ConnectionOption
            {
                Url = dbModel.SYNC_SERVICE_URL,
                // передаем хеш пароля
                // Password =  dbModel.SYNC_PASSWORD,
                Login = dbModel.SYNC_LOGIN,
                LastSyncDate = dbModel.LAST_SYNC_DATE,
                LastSyncStatus = dbModel.LAST_SYNC_STATUS,
                Name = dbModel.NAME,
                SyncEnabled = dbModel.SYNC_ENABLED != null && dbModel.SYNC_ENABLED != 0,
                Mfo = dbModel.KF
            };
            return viewModel;
        }
    }
}