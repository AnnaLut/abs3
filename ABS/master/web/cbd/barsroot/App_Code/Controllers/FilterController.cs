using System.Web.Mvc;
using BarsWeb.Models;
using BarsWeb.Infrastructure.Repository.DI.Implementation;

namespace BarsWeb.Controllers
{
    [AuthorizeUser]
    [CheckAccessPage]
    public class FilterController : ApplicationController
    {
        private FilterRepository _repository;
        public FilterController()
        {
            _repository = new FilterRepository();
        }
        public ActionResult Index(int? id, string table)
        {
            ViewBag.UserId = _repository.UserId();
            return View(_repository.GetMetaTable(id,table));
        }

        public ActionResult Add(string name, int tableId, string where, string tables)
        {
            _repository.AddFilter(name,tableId,where,tables);
            return Json(new JsonResponse(), JsonRequestBehavior.AllowGet);
        }
        public ActionResult Delete(int id)
        {
            var result = new JsonResponse();
            if (!_repository.DeleteFilter(id))
            {
                result.status = JsonResponseStatus.Error;
                result.message = string.Format("Фільтр №{0} незнайдено.",id);
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}