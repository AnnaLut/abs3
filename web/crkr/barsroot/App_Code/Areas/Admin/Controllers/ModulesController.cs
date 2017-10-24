using System.Web.Mvc;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Admin.Controllers
{ /*
    [AuthorizeUser]
    //[CheckAccessPage]
    public class ModulesController : ApplicationController
    {
        private IModulesRepository _repository;
        //private IHomeRepository _homeRepository;
        public ModulesController(IModulesRepository repository)
        {
            _repository = repository;
        }
        public ActionResult Index()
        {
            /*var branches = _homeRepository.GetBranches();
            var valuta = _repository;
            ViewBag.Valuta = valuta;*/
   /*         return View(/*branches*/ //);
       /* }

        public ActionResult GridData([DataSourceRequest] DataSourceRequest request)
        {
            var modules = _repository.GetModule();
            return Json(modules.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GridDataUpd(string codeapp)
        {
            _repository.UpdateModule(codeapp);
            return View();
        }

        public ActionResult Detail(string codeapp)
        {
            return View(_repository.GetModule(codeapp));
        }

        public ActionResult Function(string codeapp)
        {
            var model = _repository.GetFunction(codeapp);
            var handBoock = _repository.GetNotInFunction(codeapp);
            ViewBag.handbookGroupsAcc = handBoock;
            return View(model);

        }

        public ActionResult References()
        {
            return View();
        }

        public ActionResult PrintDocs()
        {
            return View();
        }

        public ActionResult Users()
        {
            return View();
        }

        public ActionResult Test()
        {
            return View();
        }*/

/*        /// <summary>
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
        /// Тарифи по рахунку
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        public ActionResult DetailTarif(int id)
        {
            return View(_repository.GetAccountTarif(id));
        }
    }*/
}