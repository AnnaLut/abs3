using System.Web.Mvc;
using BarsWeb.Areas.Acct.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Acct.Controllers
{ 
    /// <summary>
    /// Перегляд рахунків
    /// </summary>
    [AuthorizeUser]
    [Authorize]
    //[CheckAccessPage]
    public class AccountsController : ApplicationController
    {
        private readonly IAccountsRepository _repository;
        private readonly IHomeRepository _homeRepository;
        public AccountsController(IAccountsRepository repository, IHomeRepository homeRepository)
        {
            _repository = repository;
            _homeRepository = homeRepository;
        }
        /// <summary>
        /// перегляд рахунків
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            string theme = "bootstrap";
            var cook = HttpContext.Request.Cookies["theme"];
            if (cook != null)
            {
                theme = cook.Value;
            }
            Session["theme"] = theme;

            var branches = _homeRepository.GetBranches();
            var valuta = _repository;
            ViewBag.Valuta = valuta;
            return View(branches);
        }
        /// <summary>
        /// Пеповнення списку рахунків
        /// </summary>
        /// <param name="request">параметри запроса гріда</param>
        /// <param name="branch">бранч для фільтрації</param>
        /// <returns>JSON</returns>
        public ActionResult GridData([DataSourceRequest] DataSourceRequest request,string branch)
        {
            var accounts = _repository.GetAccounts(branch);
            return Json(accounts.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// детальна інформація про рахунок
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        public ActionResult Detail(int id)
        {
            return View(_repository.GetAccount(id));
        }

        /// <summary>
        /// сторінка доступів до рахунку
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        public ActionResult DetailAccess(int id)
        {
            var model = _repository.GetGroupsAcc(id);
            var handBoock = _repository.GetGroupsAccNotInGroupsAccs(id);
            ViewBag.handbookGroupsAcc = handBoock;
            return View(model);
        }
        /// <summary>
        /// Спец параметри рахунку
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        public ActionResult DetailSpecParam(int id)
        {
            return View();
        }
        /// <summary>
        /// відсотки по рахунку
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        public ActionResult DetailPercent(int id)
        {
            return View();
        }

        /// <summary>
        /// Тарифи по рахунку
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        public ActionResult DetailTarif(int id)
        {
            return View(model:id);
        }
        public ActionResult TarifGridData([DataSourceRequest] DataSourceRequest request, int id)
        {
            return View(_repository.GetAccountTarif(id,request));
        }
        /// <summary>
        /// Події
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        public ActionResult DetailEvents(int id)
        {
            return View();
        }
    }
}