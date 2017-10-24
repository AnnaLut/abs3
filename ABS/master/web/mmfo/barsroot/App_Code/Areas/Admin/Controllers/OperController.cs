using System;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Admin.Models.Oper;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using BarsWeb.Models;
using System.Web.Mvc;
using System.Text;
using System.IO;

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
        public ActionResult Index(string id = "edit")
        {
            ViewBag.AccessMode = id;
            return View();
        }
        #region GetOperDataGrid
        public ActionResult GetOperGrid([DataSourceRequest]DataSourceRequest request)
        {
            var data = _repo.OperData().ToList();
            //var dataCount = _repo.OperDataCount(request);
            return Json(new {Data = data.ToDataSourceResult(request)/*, Total = dataCount*/}, JsonRequestBehavior.AllowGet);
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

        public ActionResult GetRelatedTransactionGrid([DataSourceRequest]DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_RelatedTransaction> data = _repo.RelatedTransactionData(request, tt);
            var dataCount = _repo.RelatedTransactionDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetTransactionsHandbook([DataSourceRequest]DataSourceRequest request, string tt)
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

        public ActionResult GetVobGrid([DataSourceRequest]DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_VOB> data = _repo.VobData(request, tt);
            var dataCount = _repo.VobDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetBankDocsHandbook([DataSourceRequest]DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_BankDocsHandbook> data = _repo.BankDocsData(request, tt);
            var dataCount = _repo.BankDocsCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region GetMonitoringGroupsDataTab

        public ActionResult GetMonitoringGroupsGrid([DataSourceRequest]DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_MonitoringGroup> data = _repo.MonitoringGroupData(request, tt);
            var dataCount = _repo.MonitoringGroupDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetGroupsHandbook([DataSourceRequest]DataSourceRequest request, string tt)
        {
            IEnumerable<CHKLIST> data = _repo.GroupData(request, tt);
            var dataCount = _repo.GroupDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region GetFolderDataGrid

        public ActionResult GetFolderGrid([DataSourceRequest]DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_FOLDERS> data = _repo.FolderData(request, tt);
            var dataCount = _repo.FolderDataCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetOutFolderGrid([DataSourceRequest]DataSourceRequest request, string tt)
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
        public ActionResult GetFlags([DataSourceRequest]DataSourceRequest request, int[] flags, string tt)
        {
            try
            {
                var flagsData = _repo.FlagsData(flags, tt).ToList();
                //var dataCount = _repo.FlagsDataCount(request, flags, tt);
                var datatt = new { Data = flagsData.ToDataSourceResult(request) };
                return Json(datatt, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult GetFlagsHandbook([DataSourceRequest]DataSourceRequest request, int[] flags, string tt)
        {
            IEnumerable<TTS_FLAGS> data = _repo.FlagsOutData(request, flags);
            var dataCount = _repo.FlagsOutCount(request, flags);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetProps([DataSourceRequest]DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_Prop> data = _repo.PropData(request, tt);
            var dataCount = _repo.PropDataCount(request, tt);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetPropsHandbook([DataSourceRequest]DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_OP_FIELD> data = _repo.PropOutData(request, tt);
            var dataCount = _repo.PropOutDataCount(request, tt);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Balance Accounts DataGrid

        public ActionResult GetBalanceAccounts([DataSourceRequest]DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_PS> data = _repo.BalanceAccountsData(request, tt);
            var dataCount = _repo.BalanceAccountsCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAccountsHandbook([DataSourceRequest]DataSourceRequest request, string tt)
        {
            IEnumerable<TTS_NBS> data = _repo.AccountsData(request, tt);
            var dataCount = _repo.AccountsCount(request, tt);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        #endregion

        private JsonResult DataSourceErrorResult(Exception ex)
        {
            return Json(new DataSourceResult
            {
                Errors = new
                {
                    message = ex.Message
                }
            }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult ExportOperationsSQL(string cod)
        {
            //var data = "";
            try
            {
                byte[] data =  _repo.ExportOperationsSQL(cod);
                var stream = new MemoryStream(data);
                return File(stream, "text/plain", cod + "_сценарій" + ".txt");
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }



}