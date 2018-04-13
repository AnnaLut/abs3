using System;
using System.Collections;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Web.Mvc;
using BarsWeb.Areas.Cash.Infrastructure;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using BarsWeb.Areas.Cash.Infrastructure.Sync;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;
using Bars.Application;
using BarsWeb.Controllers;
using BarsWeb.Infrastructure.Repository.DI.Implementation;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using AccountRepository = BarsWeb.Infrastructure.Repository.DI.Implementation.AccountRepository;

namespace BarsWeb.Areas.Cash.Controllers
{
    /// <summary>
    /// Получение данных об остатках наличности из регионов
    /// </summary>
    [AuthorizeUser]
    public class SyncController : ApplicationController
    {
        private readonly ISyncRepository _syncRepository;

        public SyncController(ISyncRepository syncRepository)
        {
            _syncRepository = syncRepository;
        }


        #region Методы синхронизации, которые запускает Oracle Job
        [AllowAnonymous]
        public string JobTest(string login = null, string password = null)
        {
            return string.Format("{0} | {1} | {2}", "Hello :)", (login ?? "EmptyLogin"), (password ?? "EmptyPassword"));
        }

        [AllowAnonymous]
        public JsonResult JobSyncAccounts(string login, string mfoCode = null, string parallel = "1", string async = "1")
        {
            SslValidation();
            return LoginLogout(login, () =>
            {
                SyncCallResult result = SyncAccounts(mfoCode, parallel == "1", async == "1");
                return Json(result);
            });
        }

        [AllowAnonymous]
        public JsonResult JobSyncAccountsRest(string login, string mfoCode = null, string parallel = "1", string async = "1")
        {
            SslValidation();
            return LoginLogout(login, () =>
            {
                SyncCallResult result = SyncAccountsRest(mfoCode, parallel == "1", async == "1");
                return Json(result);
            });
        }

        [AllowAnonymous]
        public JsonResult JobSyncTransactions(string login, string mfoCode = null, string parallel = "1", string async = "1")
        {
            SslValidation();
            return LoginLogout(login, () =>
            {
                SyncCallResult result = SyncTransactions(mfoCode, parallel == "1", async == "1");
                return Json(result);
            });
        }
        /// <summary>
        /// Выполнить функцию, предварительно сделав login, а после завершения - logout
        /// </summary>
        /// <param name="login"></param>
        /// <param name="f"></param>
        /// <returns></returns>
        private JsonResult LoginLogout(string login, Func<JsonResult> f)
        {
            //аторизуємо користувача для роботи з HttpContext;
            CustomIdentity userIdentity = new CustomIdentity(login, 1, true, false, login, "", "");
            CustomPrincipal principal = new CustomPrincipal(userIdentity, new ArrayList());
            System.Web.HttpContext.Current.User = principal;
            var repository = new AccountRepository(new AppModel());
            repository.LoginUser(login);

            JsonResult result = f();

            repository.LogOutUser();
            return result;
        }
        #endregion

        #region Методы синхронизации
        private const string ParallelCallFromUiKey = "PARALLEL_UI";
        private const string AsyncCallFromUiKey = "ASYNC_UI";

        /// <summary>
        /// Синхронизировать счета
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult SyncAccountsFromUI(string mfoCode = null)
        {
            SslValidation();
            SyncCallResult syncCallResult = SyncAccounts(mfoCode, GetBoolParam(ParallelCallFromUiKey), GetBoolParam(AsyncCallFromUiKey));
            return Json(syncCallResult);
        }

        /// <summary>
        /// Синхронизировать остатки по счетам
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult SyncAccountsRestFromUI(string mfoCode = null)
        {
            SslValidation();
            SyncCallResult syncCallResult = SyncAccountsRest(mfoCode, GetBoolParam(ParallelCallFromUiKey), GetBoolParam(AsyncCallFromUiKey));
            return Json(syncCallResult);
        }

        /// <summary>
        /// Синхронизировать список отделений (бранчей)
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult SyncBranchesFromUI(string mfoCode = null)
        {
            SslValidation();
            SyncCallResult syncCallResult = SyncBranches(mfoCode, GetBoolParam(ParallelCallFromUiKey), GetBoolParam(AsyncCallFromUiKey));
            return Json(syncCallResult);
        }

        /// <summary>
        /// Синхронизировать транзакції
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult SyncTransactionsFromUI(string mfoCode = null)
        {
            SslValidation();
            SyncCallResult syncCallResult = SyncTransactions(mfoCode, GetBoolParam(ParallelCallFromUiKey), GetBoolParam(AsyncCallFromUiKey));
            return Json(syncCallResult);
        }

        private void SslValidation()
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate(object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };
        }

        private bool GetBoolParam(string key)
        {
            var param = _syncRepository.GetParams().FirstOrDefault(x => x.PARAM == key);
            return param != null && param.VAL == "1";
        }

        private SyncCallResult SyncAccounts(string mfoCode, bool parallel, bool async)
        {
            SyncCallResult syncCallResult = SyncCallFacade.SyncBranchesThenAccounts(mfoCode, parallel, async);
            return syncCallResult;
        }

        private SyncCallResult SyncAccountsRest(string mfoCode, bool parallel, bool async)
        {
            SyncCallResult syncCallResult = SyncCallFacade.SyncAccountsRest(mfoCode, parallel, async);
            return syncCallResult;
        }

        private SyncCallResult SyncTransactions(string mfoCode, bool parallel, bool async)
        {
            SyncCallResult syncCallResult = SyncCallFacade.SyncTransactios(mfoCode, parallel, async);
            return syncCallResult;
        }
        private SyncCallResult SyncBranches(string mfoCode, bool parallel, bool async)
        {
            SyncCallResult syncCallResult = SyncCallFacade.SyncBranches(mfoCode, parallel, async);
            return syncCallResult;
        }
        #endregion

        #region Методы для построения визуального интерфейса

        public ViewResult Index(string mode)
        {
            ViewBag.Mode = mode;
            return View();
        }

        public ActionResult GetConnectionOptions([DataSourceRequest] DataSourceRequest request)
        {
            try
            {
                IQueryable<CLIM_SYNC_PARAMS> dbRecords = _syncRepository.GetConnectionOptions();
                IQueryable<ConnectionOption> viewRecords = ModelConverter.ToViewModel(dbRecords);
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CreateConnectionOption([DataSourceRequest] DataSourceRequest request, ConnectionOption connectionOption)
        {
            if (connectionOption != null && ModelState.IsValid)
            {
                try
                {
                    connectionOption = _syncRepository.CreateConnectionOption(connectionOption);
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { connectionOption }.ToDataSourceResult(request, ModelState));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult UpdateConnectionOption([DataSourceRequest] DataSourceRequest request, ConnectionOption connectionOption)
        {
            if (connectionOption != null && ModelState.IsValid)
            {
                try
                {
                    _syncRepository.UpdateConnectionOption(connectionOption);
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { connectionOption }.ToDataSourceResult(request, ModelState));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DeleteConnectionOption([DataSourceRequest] DataSourceRequest request, ConnectionOption connectionOption)
        {
            if (connectionOption != null)
            {
                try
                {
                    _syncRepository.DeleteConnectionOption(connectionOption.Mfo);
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { connectionOption }.ToDataSourceResult(request, ModelState));
        }

        public ActionResult GetParams([DataSourceRequest] DataSourceRequest request)
        {
            try
            {
                IQueryable<CLIM_PARAMS> dbRecords = _syncRepository.GetParams();
                IQueryable<Param> viewRecords = ModelConverter.ToViewModel(dbRecords);
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CreateParam([DataSourceRequest] DataSourceRequest request, Param param)
        {
            if (param != null && ModelState.IsValid)
            {
                try
                {
                    _syncRepository.CreateParam(param);
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { param }.ToDataSourceResult(request, ModelState));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult UpdateParam([DataSourceRequest] DataSourceRequest request, Param param)
        {
            if (param != null && ModelState.IsValid)
            {
                try
                {
                    _syncRepository.UpdateParam(param);
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { param }.ToDataSourceResult(request, ModelState));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DeleteParam([DataSourceRequest] DataSourceRequest request, Param param)
        {
            if (param != null)
            {
                try
                {
                    _syncRepository.DeleteParam(param.Name);
                }
                catch (Exception ex)
                {
                    //return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { param }.ToDataSourceResult(request, ModelState));
        }

        public ActionResult GetLog([DataSourceRequest] DataSourceRequest request, decimal? parentId = null, string syncType = null)
        {
            try
            {
                IQueryable<CLIM_PROTOCOL> dbRecords = _syncRepository.GetLog();
                dbRecords = parentId.HasValue
                    ? dbRecords.Where(x => x.PARENT_ID == parentId)
                    : dbRecords.Where(x => !x.PARENT_ID.HasValue);

                if (!string.IsNullOrEmpty(syncType))
                {
                    dbRecords = dbRecords.Where(x => x.TRANSFER_TYPE == syncType);
                }

                IQueryable<SyncResult> viewRecords = ModelConverter.ToViewModel(dbRecords);
                return Json(viewRecords.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        private JsonResult DataSourceErrorResult(Exception ex)
        {
            return Json(new DataSourceResult
            {
                Errors = new
                {
                    message = ex.ToString(),
                },
            });
        }

        #endregion
    }
}