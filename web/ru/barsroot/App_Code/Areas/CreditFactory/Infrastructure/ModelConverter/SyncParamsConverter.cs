using System.Linq;
using Areas.CreditFactory.Models;
using BarsWeb.Areas.CreditFactory.ViewModels;

namespace BarsWeb.Areas.CreditFactory.Infrastructure
{
    partial class ModelConverter
    {
        public static CF_REQUEST_SETINGS ToDbModel(SyncParams viewModel)
        {
            var dbModel = new CF_REQUEST_SETINGS
            {
                CONN_STATES = string.IsNullOrEmpty(viewModel.Conn_States) ? "ERROR" : viewModel.Conn_States,
                CONN_ERR_MSG = viewModel.Conn_Err_Msg,
                MFO = viewModel.Mfo,
                URL_SERVICE = viewModel.Url_Service,
                USERNAME = viewModel.Username,
                PASSWORD = viewModel.Password,
                IS_ACTIVE = viewModel.Is_Active
            };
            return dbModel;
        }

        public static SyncParams ToViewModel(CF_REQUEST_SETINGS dbModel)
        {
            var viewModel = new SyncParams
            {
                Conn_States = string.IsNullOrEmpty(dbModel.CONN_STATES) ? "ERROR" : dbModel.CONN_STATES,
                Conn_Err_Msg = dbModel.CONN_ERR_MSG,
                Mfo = dbModel.MFO,
                Url_Service = dbModel.URL_SERVICE,
                Username = dbModel.USERNAME,
                Password = dbModel.PASSWORD,
                Is_Active = (int)dbModel.IS_ACTIVE
            };
            return viewModel;
        }
    }
}