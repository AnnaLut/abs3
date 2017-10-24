using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models.AssignmentSpecParams;
using System.Collections.Generic;
using BarsWeb.Controllers;
using System.Web.Mvc;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Admin.Controllers
{
    [CheckAccessPage]
    [AuthorizeUser]
    public class AssignmentSpecParamsController : ApplicationController
    {

        private readonly IAssignmentSpecParamsRepository _repository;
        public AssignmentSpecParamsController(IAssignmentSpecParamsRepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetBalanceAccount([DataSourceRequest]DataSourceRequest request)
        {
            List<BalanceAccount> balanceAccounts = _repository.GetBalanceAccount(request);
            decimal balanceAccountsCount = _repository.GetBalanceAccountCount(request);
            return Json(new { Data = balanceAccounts, Total = balanceAccountsCount }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetParameters([DataSourceRequest]DataSourceRequest request, string parameterType, string balanceAccountNumber)
        {
            List<Parameter> selectedParameters = _repository.GetParameters(request, parameterType, balanceAccountNumber);
            decimal selectedParametersCount = _repository.GetParametersCount(request, parameterType, balanceAccountNumber);
            return Json(new { Data = selectedParameters, Total = selectedParametersCount }, JsonRequestBehavior.AllowGet);
        }
     
    }
}
