using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Cash.Infrastructure;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Async.Controllers
{
    /// <summary>
    /// Списки счетов
    /// </summary>
    [AuthorizeUser]
    public class AdminController : ApplicationController
    {
        private readonly IAccountRepository _accountRepository;
        private readonly IMfoRepository _mfoRepository;

        public AdminController(IAccountRepository accountRepository, IMfoRepository mfoRepository)
        {
            _accountRepository = accountRepository;
            _mfoRepository = mfoRepository;
        }

        public ViewResult Index()
        {
            return View();
        }

        public ActionResult Edit()
        {
            return View();
        }
    }
}