using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using BarsWeb.Controllers;
using System.Web.Mvc;
using Areas.Cdm.Models;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Cdm.Controllers
{
    //[CheckAccessPage]
    [Authorize]
    public class QualityController : ApplicationController
    {
        private readonly IQualityRepository _repo;
        private readonly ICdmRepository _cdmRepo;
        private readonly IBranchesRepository _branchRepo;
        public QualityController(IQualityRepository repo, ICdmRepository cdmRepo, IBranchesRepository branchRepo)
        {
            _repo = repo;
            _cdmRepo = cdmRepo;
            _branchRepo = branchRepo;
        }

        public ActionResult Index(string mode)
        {
            ViewBag.Mode = mode;
            return View();
        }

        public ActionResult AdvisoryList(AdvisoryListParams listParams)
        {
            return View(listParams);
        }

        public ActionResult GetAdvisoryList([DataSourceRequest] DataSourceRequest request, AdvisoryListParams listParams)
        {
            var data = _repo.GetAdvisoryList(listParams, request);
            var total = _repo.GetAdvisoryListCount(listParams, request);
            return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAdvisoryListByRnk(int rnk, int groupId)
        {
            var data = _repo.GetAdvisoryList(new AdvisoryListParams() {GroupId = groupId, CustRnk = rnk});
            return Json(new { data }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetGroups(bool isAdminMode)
        {
            return Json(_repo.GetQualityGroups(isAdminMode), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetSubGroups()
        {
            return Json(_repo.GetQualitySubGroups(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetCustAdvisoryList(decimal rnk)
        {
            return Json(_repo.GetCustAdvisory(rnk), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAllAttrGroups()
        {
            return Json(_repo.GetAllAttrGroups(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetCustAttributesList(decimal rnk)
        {
            List<EBK_CUST_ATTR_LIST_V> result = _repo.GetCustAttributesList(rnk).ToList();
            var defCulture = CultureInfo.CreateSpecificCulture("en-US");
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SaveCustomerAttributes(string newData)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                var attrList = JsonConvert.DeserializeObject<List<CustomerAttribute>>(newData);
                var rnk = attrList.First().Rnk;
                _repo.SaveCustomerAttributes(attrList);
                result.data = _cdmRepo.PackAndSendSingleCard(rnk, "PUT");
                result.message = "Зміни до картки успішно внесено.";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetDropDownData()
        {
            var result = _repo.GetAllDropDownData();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        protected override JsonResult Json(object data, string contentType, System.Text.Encoding contentEncoding, JsonRequestBehavior behavior)
        {
            return new JsonResult()
            {
                Data = data,
                ContentType = contentType,
                ContentEncoding = contentEncoding,
                JsonRequestBehavior = behavior,
                MaxJsonLength = Int32.MaxValue
            };
        }

        public ActionResult GetDialogData([DataSourceRequest] DataSourceRequest request, string dialogName)
        {
            var result = _repo.GetDialogData(dialogName, request);
            return Json(new { Data = result, Total = _repo.LastDialogDataLendth(), Title = _repo.LastDialogDescription()}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetQualityGroupList([DataSourceRequest] DataSourceRequest request, decimal groupId)
        {
            var result = _repo.GetCustomGroupsList(groupId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteSubgroup(decimal group, decimal subGroup)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _repo.DeleteQualitySubgroup(group, subGroup);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult AddSubgroup(decimal group, string sign, decimal percent)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _repo.AddSubgroup(group, sign, percent);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult BranchList()
        {
            return Json(_branchRepo.GetAllBranches().Select(b => b.Branch), JsonRequestBehavior.AllowGet);
        }
        
    }

}