using System.Web.Mvc;
using System.Linq;
using BarsWeb.Controllers;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CreditUi.Models;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using System;
using System.Web.Script.Serialization;

namespace BarsWeb.Areas.CreditUi.Controllers
{
    [AuthorizeUser]
    public class AccountsController : ApplicationController
    {
        private readonly IAccountsRepository _accountsRepository;

        public AccountsController(IAccountsRepository accountsRepository)
        {
            _accountsRepository = accountsRepository;
        }


        public ActionResult Index(decimal id)
        {
            return View("~/Areas/CreditUi/Views/Accounts/Index.cshtml");
        }

        public ActionResult GetAccountsList(decimal id,[DataSourceRequest]DataSourceRequest request)
        {
            IQueryable<Account> session = _accountsRepository.GetAccounts(id);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetStaticData(decimal nd)
        {
            return Json(_accountsRepository.GetStaticData(nd));
        }

        public ActionResult AutoSG(decimal nd)
        {
            string Status = "ok";
            try
            {
                _accountsRepository.AutoSG(nd);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult ConnectionAccWithKD(decimal nd, string nls, int kv)
        {
            string Status = "ok";
            try
            {
                _accountsRepository.ConnectAccountWithKD(nd,nls,kv);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult CloseKD(decimal nd)
        {
            string Status = "ok";
            try
            {
                _accountsRepository.CloseKD(nd);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult Remain8999(decimal nd)
        {
            string Status = "ok";
            try
            {
                _accountsRepository.Remain8999(nd);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult Limit9129(decimal nd)
        {
            string Status = "ok";
            try
            {
                _accountsRepository.Lim9129(nd);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult DelWithoutClose(decimal nd, decimal acc, string tip)
        {
            string Status = "ok";
            try
            {
                _accountsRepository.DelAccountWithoutClose(nd, acc, tip);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult UpdateAccount(string accountString)
        {
            string Status = "ok";
            try
            {
                var serializer = new JavaScriptSerializer();
            UpdateAccount account = serializer.Deserialize<UpdateAccount>(accountString);
            _accountsRepository.UpdateAccount(account);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult GetKV()
        {
            return Json(_accountsRepository.GetKV());
        }

        public void SetPul(decimal nd)
        {
            _accountsRepository.setMasIni(nd);
        }

    }
}