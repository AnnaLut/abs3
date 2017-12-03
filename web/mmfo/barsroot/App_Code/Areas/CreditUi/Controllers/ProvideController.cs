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

/// <summary>
/// Summary description for ProvideController
/// </summary>
namespace BarsWeb.Areas.CreditUi.Controllers
{
    [AuthorizeUser]

    public class ProvideController : ApplicationController
    {
        private readonly IProvideRepository _provideRepository;
        string Status = "ok";

        public ProvideController(IProvideRepository provideRepository)
        {
            _provideRepository = provideRepository;
        }

        public ActionResult Index(decimal? id, decimal? tip)            
        {
            return View("~/Areas/CreditUi/Views/Provide/Index.cshtml");
        }
        public ActionResult GetStaticDataKredit(decimal id)
        {
            return Json(_provideRepository.GetStaticDataKredit(id));
        }

        public ActionResult GetStaticDataBPK(decimal id)
        {
            return Json(_provideRepository.GetStaticDataBPK(id));
        }

        public ActionResult GetProvideList(decimal id, decimal? tip, byte? balance, [DataSourceRequest]DataSourceRequest request)
        {
            try
            {
                IQueryable<ProvideList> session = _provideRepository.GetProvideList(id, tip, balance);
                return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetProvidePerRef(decimal id, decimal? tip, byte? balance, [DataSourceRequest]DataSourceRequest request)
        {
                try
                {
                    IQueryable<ExistProvide> session = _provideRepository.GetProvidePerRef(id, tip, balance);
                    return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
                }
                catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
                return Json(new { Status = Status }, JsonRequestBehavior.AllowGet);
            }
        public ActionResult DeleteProvide(string provideString, decimal id, int tip)
        {
            try
            {
                var serializer = new JavaScriptSerializer();
                List<decimal> acc_list = serializer.Deserialize<List<decimal>>(provideString);
                _provideRepository.BindProvideGroup(id, acc_list, 0, tip);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult JoinProvide(string provideString, decimal id,int tip)
        {
            try
            {
                var serializer = new JavaScriptSerializer();
                List<decimal> acc_list = serializer.Deserialize<List<decimal>>(provideString);
                _provideRepository.BindProvideGroup(id, acc_list, 1, tip);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AddProvide(string provideString, decimal? id, decimal? accs, int? tip)
        {
            try
            {
                var serializer = new JavaScriptSerializer();
                UpdateProvide provide = serializer.Deserialize<UpdateProvide>(provideString);
                List<UpdateProvide> provide_list = new List<UpdateProvide> { provide };
                _provideRepository.CreateOrEditGroupProvide(provide_list, id,accs,tip);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult EditProvide(string provideString, decimal? nd, int? tip)
        {
            try
            {
                var serializer = new JavaScriptSerializer();
                List<UpdateProvide> provide_list = serializer.Deserialize<List<UpdateProvide>>(provideString);
                _provideRepository.CreateOrEditGroupProvide(provide_list, nd,null,tip);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult GetPawn([DataSourceRequest] DataSourceRequest request, string nls, byte? tip, byte? balance)
        {
            return Json(_provideRepository.GetPawn(nls,tip,balance).ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetKV([DataSourceRequest] DataSourceRequest request, string branch)
        {
            return Json(_provideRepository.GetKV().ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetMpawn([DataSourceRequest] DataSourceRequest request, string branch)
        {
            return Json(_provideRepository.GetMPAWN().ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetRNK([DataSourceRequest] DataSourceRequest request, string branch)
        {
            return Json( _provideRepository.GetRNK().ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

    }
}