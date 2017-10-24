using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Admin.Models;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using BarsWeb.Models;
using System.Web.Mvc;

namespace BarsWeb.Areas.Admin.Controllers 
{
    [CheckAccessPage]
    [Authorize]
    public class OperController : ApplicationController
    {
        private readonly IOperRepository _repo;
        public OperController(IOperRepository repo)
        {
            _repo = repo;
        }
        public ActionResult Index()
        {
            return View();
        }
        #region GetOperDataGrid
        public ActionResult GetOperGrid(DataSourceRequest request)
        {
            IEnumerable<TTS> data = _repo.OperData(request);
            var dataCount = _repo.OperDataCount(request);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region CardHandbook

        public ActionResult DkHandbook()
        {
            var data = _repo.DkHandbookData();
            return Json(new { Data = data }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult InterbankHandbook()
        {
            var data = _repo.InterbankHandbookData();
            return Json(new { Data = data }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region GetRelatedTransactionsTab

        public ActionResult GetRelatedTransactionGrid(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_RelatedTransaction> data = _repo.RelatedTransactionData(request, tt);
            var dataCount = _repo.RelatedTransactionDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetTransactionsHandbook(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS> dataList = _repo.TransactionData(request, tt);
            var data = dataList.Select(c => new
            {
                c.TT,
                c.NAME
            }).ToList();
            var dataCount = _repo.TransactionDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region GetVobDataTab

        public ActionResult GetVobGrid(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_VOB> data = _repo.VobData(request, tt);
            var dataCount = _repo.VobDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetBankDocsHandbook(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_BankDocsHandbook> data = _repo.BankDocsData(request, tt);
            var dataCount = _repo.BankDocsCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region GetMonitoringGroupsDataTab

        public ActionResult GetMonitoringGroupsGrid(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_MonitoringGroup> data = _repo.MonitoringGroupData(request, tt);
            var dataCount = _repo.MonitoringGroupDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetGroupsHandbook(DataSourceRequest request, string tt)
        {
            IEnumerable<CHKLIST> data = _repo.GroupData(request, tt);
            var dataCount = _repo.GroupDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region GetFolderDataGrid

        public ActionResult GetFolderGrid(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_FOLDERS> data = _repo.FolderData(request, tt);
            var dataCount = _repo.FolderDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetOutFolderGrid(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_FOLDERS> dataList = _repo.OutFoldersData(request, tt);
            var data = dataList.Select(c => new
            {
                c.IDFO,
                c.NAME
            }).ToList();
            var dataCount = _repo.OutFoldersDataCount(request, tt);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Flags & Props DataGrid
        public ActionResult GetFlags(DataSourceRequest request, int[] flags, string tt)
        {
            IEnumerable<TTS_OpFlags> flagsData = _repo.FlagsData(request, flags, tt);
            var dataCount = _repo.FlagsDataCount(request, flags, tt);
            return Json(new { Data = flagsData, Total = dataCount });
        }

        public ActionResult GetFlagsHandbook(DataSourceRequest request, int[] flags, string tt)
        {
            IEnumerable<TTS_FLAGS> data = _repo.FlagsOutData(request, flags);
            var dataCount = _repo.FlagsOutCount(request, flags);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetProps(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_Prop> data = _repo.PropData(request, tt);
            var dataCount = _repo.PropDataCount(request, tt);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetPropsHandbook(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_OP_FIELD> data = _repo.PropOutData(request, tt);
            var dataCount = _repo.PropOutDataCount(request, tt);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Balance Accounts DataGrid

        public ActionResult GetBalanceAccounts(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_PS> data = _repo.BalanceAccountsData(request, tt);
            var dataCount = _repo.BalanceAccountsCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAccountsHandbook(DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_NBS> data = _repo.AccountsData(request, tt);
            var dataCount = _repo.AccountsCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        #endregion
    }

}